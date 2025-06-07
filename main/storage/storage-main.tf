# File: non-prod/storage/main-storage.tf
#
# This creates one or more Storage Accounts, Containers, and integrates them with Databricks
# using a Network Access Connector (NCC) and Unity Catalog configuration.

#----------------------------------------
# RESOURCE GROUP
#----------------------------------------

# Create one or more resource groups for the storage accounts
# - Uses a for_each to allow dynamic creation based on input variable map
resource "azurerm_resource_group" "storage_rg" {
  for_each = var.storage_account
  name     = each.value.rg_name
  location = module.common.location["primary"]
  tags     = module.common.tags
}

#----------------------------------------
# STORAGE ACCOUNT(S)
#----------------------------------------

# Create one or more Azure Data Lake Storage Gen2 accounts (ADLS)
# - Each is configured using input variables for flexibility
# - Enabled for Hierarchical Namespace (is_hns_enabled) if specified
resource "azurerm_storage_account" "adls" {
  depends_on                    = [azurerm_resource_group.storage_rg]
  for_each                      = var.storage_account
  name                          = each.value.name
  resource_group_name           = each.value.rg_name
  location                      = module.common.location["primary"]
  account_tier                  = each.value.tier
  account_kind                  = each.value.kind
  account_replication_type      = each.value.replication_type
  is_hns_enabled                = each.value.hns_enabled
  public_network_access_enabled = each.value.public_access
  tags                          = each.value.tags
}

# Add any public access as required to Storage Account ACL
resource "azurerm_storage_account_network_rules" "ip_access_allowed" {
  for_each = {
    for key, sa in var.storage_account : key => sa
    if sa.public_access == true
  }

  storage_account_id = azurerm_storage_account.adls[each.key].id

  default_action = "Deny"
  ip_rules       = each.value.allowed_ips
  bypass         = ["AzureServices"]
}

#----------------------------------------
# DATABRICKS ACCESS CONNECTOR REFERENCE
#----------------------------------------

# Lookup the existing Databricks Network Access Connector (NCC)
# - This is used to assign permissions for storage access
data "azurerm_databricks_access_connector" "ncc" {
  name                = var.databricks_ncc[var.environment]
  resource_group_name = var.network_rg
}

# Assign "Storage Blob Data Contributor" role to the NCC's managed identity
# - Grants read/write access to the storage account for Databricks
resource "azurerm_role_assignment" "storage_account_data_contributor" {
  for_each             = azurerm_storage_account.adls
  scope                = each.value.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_databricks_access_connector.ncc.identity[0].principal_id
}


#----------------------------------------
# DATABRICKS STORAGE RBAC ASSIGNMENTS
#----------------------------------------

# Resolve the object ID of each Entra ID group based on the display name.
# The group name is provided via the `identity_name` attribute in storage_rbac.
# This allows us to assign roles using the group's object ID.
data "azuread_group" "group" {
  for_each     = var.storage_rbac
  display_name = each.value.identity_name
}

# Build a lookup map of storage accounts by their *actual* name
# so we can reference them by name later (since the storage account
# Terraform resource is keyed by logical ID, not real name).
locals {
  storage_accounts_by_name = {
    for key, sa in azurerm_storage_account.adls :
    sa.name => sa
  }
}

# Assign the specified role (`rbac_role`) to the specified identity
# (`identity_name`, resolved to an object ID) at the scope of the 
# correct storage account.
resource "azurerm_role_assignment" "assign_rbac" {
  for_each = var.storage_rbac

  scope                = local.storage_accounts_by_name[each.key].id
  role_definition_name = each.value.rbac_role
  principal_id         = data.azuread_group.group[each.key].object_id
}

#----------------------------------------
# STORAGE CONTAINERS
#----------------------------------------

# Flatten the list of containers across all storage accounts into a single map
# - Helps with assigning unique keys for container creation
locals {
  storage_containers_flat = {
    for item in flatten([
      for sa_key, sa_items in var.storage_account : [
        for container_name in sa_items.containers : {
          storage_account_key  = sa_key
          storage_account_name = sa_items.name
          container_name       = container_name
        } if sa_items != null && length(sa_items.containers) > 0
      ]
    ]) : "${item.storage_account_key}/${item.container_name}" => item
  }
}

# Create containers within each storage account
# - Container names and parent storage account IDs are resolved via local map
resource "azurerm_storage_container" "data_containers" {
  for_each              = local.storage_containers_flat
  name                  = each.value.container_name
  storage_account_id    = azurerm_storage_account.adls[each.value.storage_account_key].id
  container_access_type = "private"
}

#----------------------------------------
# DATABRICKS NCC PRIVATE ENDPOINT REGISTRATION (ACCOUNT LEVEL)
#----------------------------------------

# Lookup the Databricks network connectivity config by name
# - Needed to register private endpoints (e.g., storage)
data "databricks_mws_network_connectivity_config" "ncc" {
  provider = databricks.accounts
  name     = var.databricks_ncc_name
}

# Register each storage account with the Databricks NCC as a private endpoint
# - Required for Unity Catalog to securely access the ADLS endpoints
resource "databricks_mws_ncc_private_endpoint_rule" "storage" {
  provider                       = databricks.accounts
  for_each                       = azurerm_storage_account.adls
  network_connectivity_config_id = data.databricks_mws_network_connectivity_config.ncc.network_connectivity_config_id
  resource_id                    = each.value.id
  group_id                       = "dfs" # Refers to the endpoint group for ADLS Gen2 (DFS protocol)
}

#----------------------------------------
# DATABRICKS UNITY CATALOG: STORAGE CREDENTIALS
#----------------------------------------

# Create a Databricks storage credential backed by the NCC's managed identity
# - Required for Unity Catalog to access external locations
resource "databricks_storage_credential" "external" {
  provider   = databricks.workspace
  depends_on = [azurerm_storage_container.data_containers]
  name       = var.databricks_ncc[var.environment]

  azure_managed_identity {
    access_connector_id = data.azurerm_databricks_access_connector.ncc.id
  }

  comment = "Managed identity credential managed by TF"
}

# Grant Github Service Principal permission to create external locations
# - This targets a specific AAD principal by object ID
resource "databricks_grant" "storage_credential_grant" {
  provider           = databricks.workspace
  depends_on         = [databricks_storage_credential.external]
  storage_credential = databricks_storage_credential.external.name
  principal          = module.common.github_app_id
  privileges         = ["CREATE_EXTERNAL_LOCATION"]
}

#----------------------------------------
# DATABRICKS UNITY CATALOG: EXTERNAL LOCATIONS
#----------------------------------------

# Create external locations in Unity Catalog for each container
# - These link storage containers to Unity Catalog using the NCC managed identity credential
resource "databricks_external_location" "external_locations" {
  provider   = databricks.workspace
  depends_on = [databricks_grant.storage_credential_grant]
  for_each   = local.storage_containers_flat

  name            = "${each.value.storage_account_name}-${each.value.container_name}"
  credential_name = databricks_storage_credential.external.id
  url = format("abfss://%s@%s.dfs.core.windows.net/",
    each.value.container_name,
  azurerm_storage_account.adls[each.value.storage_account_key].name)
  # Optional:
  # read_only     = false
  # force_destroy = true
}

#----------------------------------------
# DATAFACTORY --> DATABRICKS STORAGE ACCOUNTS: RBAC
#----------------------------------------

# This section assigns the "Storage Blob Data Contributor" role to each Data Factory's
# System-Assigned Managed Identity, granting it access to relevant Databricks storage accounts.
# The assignments are grouped by environment (dev/test/prod) based on the Environment tag on each storage account.

#----------------------------------------
# Reference to Data Factories
#----------------------------------------

data "azurerm_data_factory" "df" {
  provider            = azurerm.Production
  for_each            = var.data_factories
  name                = each.value.name
  resource_group_name = each.value.rg_name
}

#----------------------------------------
# Development Storage Accounts: Filter
#----------------------------------------

locals {
  dev_storage_accounts = {
    for name, sa in azurerm_storage_account.adls : name => sa
    if contains(
      module.common.tag_env_aliases["dev"],  # Match any dev-related alias (e.g., "dev", "development")
      lower(try(sa.tags["Environment"], "")) # Normalize case and handle missing tag
    )
  }
}

#----------------------------------------
# Development Role Assignments
#----------------------------------------

resource "azurerm_role_assignment" "dev_tags" {
  for_each = {
    for pair in setproduct(
      values(data.azurerm_data_factory.df), # All imported Data Factories
      values(local.dev_storage_accounts)    # All "dev" tagged storage accounts
    ) :
    "${pair[0].name}-${pair[1].name}" => {            # Unique key combining DF and SA name
      principal_id = pair[0].identity[0].principal_id # Data Factory's managed identity
      scope        = pair[1].id                       # Storage Account scope for role assignment
    }
  }

  principal_id         = each.value.principal_id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = each.value.scope
}

#----------------------------------------
# Test Storage Accounts: Filter
#----------------------------------------

locals {
  test_storage_accounts = {
    for name, sa in azurerm_storage_account.adls : name => sa
    if contains(
      module.common.tag_env_aliases["test"],
      lower(try(sa.tags["Environment"], ""))
    )
  }
}

#----------------------------------------
# Test Role Assignments
#----------------------------------------

resource "azurerm_role_assignment" "test_tags" {
  for_each = {
    for pair in setproduct(
      values(data.azurerm_data_factory.df),
      values(local.test_storage_accounts)
    ) :
    "${pair[0].name}-${pair[1].name}" => {
      principal_id = pair[0].identity[0].principal_id
      scope        = pair[1].id
    }
  }

  principal_id         = each.value.principal_id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = each.value.scope
}

#----------------------------------------
# Production Storage Accounts: Filter
#----------------------------------------

locals {
  prod_storage_accounts = {
    for name, sa in azurerm_storage_account.adls : name => sa
    if contains(
      module.common.tag_env_aliases["prod"],
      lower(try(sa.tags["Environment"], ""))
    )
  }
}

#----------------------------------------
# Production Role Assignments
#----------------------------------------

resource "azurerm_role_assignment" "prod_tags" {
  for_each = {
    for pair in setproduct(
      values(data.azurerm_data_factory.df),
      values(local.prod_storage_accounts)
    ) :
    "${pair[0].name}-${pair[1].name}" => {
      principal_id = pair[0].identity[0].principal_id
      scope        = pair[1].id
    }
  }

  principal_id         = each.value.principal_id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = each.value.scope
}
