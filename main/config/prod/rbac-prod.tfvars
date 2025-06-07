# Databricks Settings

#----------------------------------------
# DATABRICKS ACCOUNT & WORKSPACE SETTINGS
#----------------------------------------

# The Databricks account ID (used for account-level APIs like Unity Catalog)
# - This ID is typically used with the `databricks.accounts` provider alias
databricks_account_id = "c8eaeaff-82c9-439d-ab7e-5cb3e83082c6"

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
  "Harshit.Agarwal@MeridianEnergy.co.nz" = {
    type = "user"
    targets = [
      {
        storage_account = "auestorrdcp01"
        resource_group  = "aue-rg-dataplatform-p01"
        rbac_role       = "Storage Blob Data Contributor"
      },
    ]
  }

  "tim.wipiiti-benseman@meridianenergy.co.nz" = {
    type = "user"
    targets = [
      {
        storage_account = "auestorrdcp01"
        resource_group  = "aue-rg-dataplatform-p01"
        rbac_role       = "Storage Blob Data Contributor"
      },
    ]
  }
}
