# Databricks Settings

#----------------------------------------
# DATABRICKS ACCOUNT & WORKSPACE SETTINGS
#----------------------------------------

# The Databricks account ID (used for account-level APIs like Unity Catalog)
# - This ID is typically used with the `databricks.accounts` provider alias
databricks_account_id = "e05790b3-4261-4044-8485-0ca3e84065c6"

# The Azure Resource ID of the Databricks workspace
# - Used for workspace-scoped resources (clusters, jobs, external locations, etc.)
# - This is due to a limitation with the current Databricks Terraform provider / Databricks implementation
# - It doens't matter which workspace this is, as long as the Azure OIDC can authenticate to it
databricks_workspace_id = "/subscriptions/c4328310-9fdc-4b88-8c5d-7287350bba6f/resourceGroups/aue-rg-databricks-np01/providers/Microsoft.Databricks/workspaces/aue-rg-databricks-retail_ui-np01"

#----------------------------------------
# STORAGE ACCOUNT RBAC ASSIGNMENTS
#----------------------------------------

# This map defines role assignments for Azure identities (users or groups)
# on one or more storage accounts. Each key is the identity name (UPN for users,
# display name for groups), and the value contains:
# - `type`: whether the identity is a "user" or "group"
# - `targets`: a list of storage accounts the identity should be granted access to,
#   along with the target resource group and RBAC role

storage_rbac = {
  "timote.wb_live.com#EXT#@timotewblive.onmicrosoft.com" = {
    type = "user"
    targets = [
      {
        storage_account = "auestorrdcd01"
        resource_group  = "aue-rg-dataplatform-d01"
        rbac_role       = "Storage Blob Data Contributor"
      },
      {
        storage_account = "auestorrdct01"
        resource_group  = "aue-rg-dataplatform-t01"
        rbac_role       = "Storage Blob Data Contributor"
      }
    ]
  }

  "admin@timotewblive.onmicrosoft.com" = {
    type = "user"
    targets = [
      {
        storage_account = "auestorrdcd01"
        resource_group  = "aue-rg-dataplatform-d01"
        rbac_role       = "Storage Blob Data Contributor"
      },
      {
        storage_account = "auestorrdct01"
        resource_group  = "aue-rg-dataplatform-t01"
        rbac_role       = "Storage Blob Data Contributor"
      }
    ]
  }
}
