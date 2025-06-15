# File: ./main/workspace/main-workspace.tf
#
# This module provisions one or more Databricks workspaces and related infrastructure
# based on the workspace definitions in terraform.tfvars.
#

#----------------------------------------
# Resource Group(s) for Databricks Workspaces
#----------------------------------------

# Creates one resource group per workspace using the values provided in var.workspaces.
# This allows isolated resource management per workspace.
resource "azurerm_resource_group" "databricks_rg" {
  for_each = toset(distinct([
    for ws in var.workspaces : ws.rg_name
  ]))  
  name     = each.value
  location = module.common.location["primary"] # Typically resolved to a region like "australiaeast"
  tags     = module.common.tags
}


#----------------------------------------
# Databricks Workspace(s)
#----------------------------------------

# Provisions one Databricks workspace for each entry in var.workspaces.
# Managed Resource Group and encryption settings are also defined per workspace.
resource "azurerm_databricks_workspace" "workspace" {
  depends_on                        = [azurerm_resource_group.databricks_rg]
  for_each                          = var.workspaces
  name                              = each.value.name
  resource_group_name               = each.value.rg_name
  location                          = module.common.location["primary"]
  sku                               = each.value.sku
  managed_resource_group_name       = each.value.managed_rg
  infrastructure_encryption_enabled = each.value.encryption
}

#----------------------------------------
# Unity Catalog Metastore Assignment
#----------------------------------------

# Associates each created workspace with a shared Unity Catalog metastore.
# This enables cross-workspace governance and access control.
resource "databricks_metastore_assignment" "metastore" {
  provider     = databricks.accounts
  depends_on   = [azurerm_databricks_workspace.workspace]
  for_each     = var.workspaces
  workspace_id = azurerm_databricks_workspace.workspace[each.key].workspace_id
  metastore_id = module.common.metastore_id
}

# Fetch each SCIM-synced admin group once at the account level
data "databricks_group" "groups" {
  for_each     = local.workspace_permissions 
  provider     = databricks.accounts
  display_name = each.value.group_name
}

# Optional Delay to Allow Propagation to MWS APIs
resource "null_resource" "workspace_propagation_delay" {
  depends_on = [azurerm_databricks_workspace.workspace]
  provisioner "local-exec" {
    command = "sleep 30"
  }
}

# Grant permissions on each workspace to each admin group
resource "databricks_mws_permission_assignment" "workspace_admin" {
  for_each   = local.workspace_permissions 
  depends_on = [null_resource.workspace_propagation_delay]
  provider   = databricks.accounts

  workspace_id = azurerm_databricks_workspace.workspace[regex("^(.*?)_", each.key)[0]].workspace_id
  principal_id = data.databricks_group.groups[each.key].id
  permissions  = [each.value.permission]
}



#----------------------------------------
# Network Connectivity Configuration (NCC)
#----------------------------------------

# Creates a Databricks Network Connectivity Configuration (NCC) at the account level.
# NCC is required for advanced networking scenarios like private link or IP access lists.
resource "databricks_mws_network_connectivity_config" "ncc" {
  provider = databricks.accounts
  name     = var.databricks_ncc_name
  region   = module.common.location["primary"]
}

#----------------------------------------
# Bind NCC to Workspaces
#----------------------------------------

# Associates the NCC configuration with each workspace.
# This enables the defined networking config to be enforced on workspace traffic.
resource "databricks_mws_ncc_binding" "ncc_binding" {
  provider                       = databricks.accounts
  for_each                       = var.workspaces
  network_connectivity_config_id = databricks_mws_network_connectivity_config.ncc.network_connectivity_config_id
  workspace_id                   = azurerm_databricks_workspace.workspace[each.key].workspace_id
}