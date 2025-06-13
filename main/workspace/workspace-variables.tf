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
# Databricks Variables
#----------------------------------------

# Specifies the Databricks account ID used for deploying resources.
# Required when managing workspaces or other Databricks account-level resources.
variable "databricks_account_id" {
  description = "Databricks Account ID"
  type        = string
}

# Specifies the Administrative Group names that will be granted access to the workspaces
#variable "databricks_admin_groups" {
#  description = "List of Databricks Admin Group Names"
#  type        = list(string)
#}

# Specifies the name of the NCC connector in the Databricks account
variable "databricks_ncc_name" {
  description = "Databricks NCC Name"
  type        = string
}

# Defines a map of Databricks workspace configurations keyed by workspace identifier.
# Each workspace object should include:
# - name: Name of the workspace
# - rg_name: Name of the resource group the workspace will reside in
# - public_access: Boolean to enable or disable public network access
# - encryption: Boolean indicating whether CMK encryption is enabled
# - managed_rg: Name of the managed resource group for the workspace
# - sku: Pricing tier (e.g., "premium", "standard")
variable "workspaces" {
  description = "Map of Databricks Workspaces to be created"
  type = map(object({
    name          = string
    rg_name       = string
    public_access = bool
    encryption    = bool
    managed_rg    = string
    sku           = string
    permissions   = map(string) 
  }))
}
variable "subscription_id" {
    description = "The Azure Subscription ID."
    type        = string
    sensitive   = true
}
variable "client_id" {
    description = "Application ID for SP."
    type        = string
    sensitive   = true
}
variable "client_secret" {
    description = "Client Secret for SP."
    type        = string
    sensitive   = true
}
variable "tenant_id" {
    description = "Tenant ID."
    type        = string
    sensitive   = true
}
variable "admin_user_id" {
  description = "ID of the admin user for the Databricks workspace"
  type        = number
  default     = 0 # Default can be overridden in tfvars or via command line
}