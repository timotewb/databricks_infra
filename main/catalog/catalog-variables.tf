# File: /non-prod/catalog/variables.tf

#----------------------------------------
# General Environment Variables
#----------------------------------------


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
# Catalog Variables
#----------------------------------------

# Map of storage accounts to be created
# - Each object includes full configuration details:
#   - name: the storage account name
variable "catalog" {
  description = "Map of catalog configurations keyed by logical catalog identifiers."
  type = map(object({
    home_workspace = string
    name            = string
    comment         = string
    storage_account = string
    container_name  = string
    sub_directory   = string
    privileges      = map(string)
    bindings        = map(object({
      workspace_id = number
      binding_type = string
    }))
  }))
}
variable "catalog_grant_templates" {
  description = "Map of grant template names to lists of privileges."
  type = map(list(string))
}

variable "databricks_account_id" {
    description = "The Databricks Account ID from the console."
    type        = string
    sensitive   = true
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
variable "workspace_url" {
    description = "The URL of the Databricks workspace."
    type        = string
    sensitive   = true
}
variable "workspace_names" {
  description = "Map of workspace names used to filter."
  type = map(string)
}