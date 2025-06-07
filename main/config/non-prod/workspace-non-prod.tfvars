#----------------------------------------
# Databricks Settings
#----------------------------------------

# The Databricks Account ID used for all workspace deployments under this configuration.
# This value is required for Terraform to authenticate and manage Databricks workspaces at the account level.
# databricks_account_id = "e05790b3-4261-4044-8485-0ca3e84065c6"

# The Databricks NCC name in the account cloud resources that contains private endpoint rules
databricks_ncc_name = "ncc-retail"

# Map of workspace configurations keyed by logical workspace identifiers.
# Each entry defines properties for a Databricks workspace.
# This structure supports multi-workspace deployment from a single configuration.
workspaces = {
  # Retail UI workspace configuration (non-prod)
  "retail_ui" = {
    name          = "aue-rg-databricks-retail_ui-np01"         # Workspace name
    rg_name       = "aue-rg-databricks-np01"                   # Resource group where the workspace will be created
    managed_rg    = "aue-rg-databricks-retail_ui_managed-np01" # Managed resource group used internally by Databricks
    public_access = false                                      # Disables public network access to the workspace
    encryption    = true                                       # Enables CMK encryption for workspace data
    sku           = "premium"                                  # Specifies the pricing tier
    admin_group   = "RDS-Admin"                                # Specifies Admin Group for the workspace
  }

  # Dev workspace for Retail Data Core platform
  "dev-retail-data-core" = {
    name          = "dev-retail-data-core"
    rg_name       = "aue-rg-databricks-d01"
    managed_rg    = "aue-rg-databricks-retail-data-core-d01"
    public_access = false
    encryption    = true
    sku           = "premium"
    admin_group   = "RDS-Admin"
  }

  # Test workspace for Retail Data Core platform
  "test-retail-data-core" = {
    name          = "test-retail-data-core"
    rg_name       = "aue-rg-databricks-t01"
    managed_rg    = "aue-rg-databricks-retail-data-core-t01"
    public_access = false
    encryption    = true
    sku           = "premium"
    admin_group   = "RDS-Admin"
  }
}


environment = "non-prod" # Specifies the deployment environment for this configuration