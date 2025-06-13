#----------------------------------------
# Databricks Settings
#----------------------------------------

# The Databricks Account ID used for all workspace deployments under this configuration.
# This value is required for Terraform to authenticate and manage Databricks workspaces at the account level.


# The Databricks NCC name in the account cloud resources that contains private endpoint rules
databricks_ncc_name = "ncc-retail-prod"

# Map of workspace configurations keyed by logical workspace identifiers.
# Each entry defines properties for a Databricks workspace.
# This structure supports multi-workspace deployment from a single configuration.
workspaces = {
  # Prod workspace for Retail Data Core platform
  "prod-retail-data-core" = {
    name          = "prod-retail-data-core"                  # Workspace name
    rg_name       = "aue-rg-databricks-p01"                  # Resource group where the workspace will be created
    managed_rg    = "aue-rg-databricks-retail-data-core-p01" # Managed resource group used internally by Databricks
    public_access = false                                    # Disables public network access to the workspace
    encryption    = true                                     # Enables CMK encryption for workspace data
    sku           = "premium"                                # Specifies the pricing tier
    permissions = {
      "admin@timotewblive.onmicrosoft.com" = "ADMIN"
      "data.engineer@timotewblive.onmicrosoft.com" = "USER"
    }
  }

  "prod-retail-analyst" = {
    name          = "prod-retail-analyst"                  # Workspace name
    rg_name       = "aue-rg-databricks-p01"                  # Resource group where the workspace will be created
    managed_rg    = "aue-rg-databricks-retail-data-analyst-p01" # Managed resource group used internally by Databricks
    public_access = false                                    # Disables public network access to the workspace
    encryption    = true                                     # Enables CMK encryption for workspace data
    sku           = "premium"                                # Specifies the pricing tier
    permissions = {
      "admin@timotewblive.onmicrosoft.com" = "ADMIN"
      "data.engineer@timotewblive.onmicrosoft.com" = "USER"
    }
  }
}
