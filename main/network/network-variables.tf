# File: /non-prod/network/variables.tf

#----------------------------------------
# General Environment Variables
#----------------------------------------

# Specifies the deployment environment (e.g., "dev", "non-prod", "prod").
# Commonly passed via TF_VAR_environment from automation pipelines.
variable "environment" {
  description = "The deployment environment"
  type        = string
  default     = "undefined" # Fallback if not explicitly set
}

#----------------------------------------
# Network Resource Group Configuration
#----------------------------------------

# Map of resource groups required for the network infrastructure.
# Keyed by logical name, each object defines the RG name.
# Enables reusable RG creation logic across modules.
variable "resourceGroups" {
  description = "Map of network resource groups to be created"
  type = map(object({
    name = string # Resource group name
  }))
}

#----------------------------------------
# Databricks NCC Configuration
#----------------------------------------

# Map of Databricks Network Connectivity Configurations (NCCs) to be provisioned.
# Keyed by logical identifier, each entry defines a named NCC instance.
variable "databricks_ncc" {
  description = "Map of Databricks Network Connectivity Configs to be created"
  type = map(object({
    name = string # Name of the NCC instance
  }))
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