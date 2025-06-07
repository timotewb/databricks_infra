# File: /non-prod/network/variables.tf

#----------------------------------------
# General Environment Variables
#----------------------------------------

# Defines the deployment environment, such as "dev", "non-prod", or "prod".
# This is typically passed via TF_VAR_environment to support environment-specific logic.
variable "environment" {
  description = "The deployment environment"
  type        = string
  default     = "undefined" # Acts as a fallback if TF_VAR_environment is not set
}

#----------------------------------------
# Databricks Account/Workspace Variables
#----------------------------------------

# Databricks Account ID (used for account-level API interactions, like Unity Catalog and NCC)
# - Typically associated with the `databricks.accounts` provider
variable "databricks_account_id" {
  description = "Databricks Account ID"
  type        = string
}

# Resource ID of the Databricks workspace
# - Used with the workspace-level Databricks provider for managing jobs, clusters, and external locations
variable "databricks_workspace_id" {
  description = "Databricks Workspace ID"
  type        = string
}

#----------------------------------------
# Storage RBAC Variables
#----------------------------------------

# This variable defines the input schema for `storage_rbac`.
# Each entry represents a storage account (by name), and provides:
# - The Storage Account name (`storage_account`)
# - The Entra ID group name (`identity_name`)
# - The desired role to assign (`rbac_role`)

variable "storage_rbac" {
  description = "Map of identities to their storage account role assignments"
  type = map(object({
    type    = string  # "user" or "group"
    targets = list(object({
      storage_account = string
      resource_group  = string
      rbac_role       = string
    }))
  }))
}