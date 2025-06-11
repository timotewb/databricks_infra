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
# Network Variables
#----------------------------------------

# Name of the Azure Resource Group where network resources (e.g., vNet, private endpoints) are deployed
variable "network_rg" {
  description = "Network Resource Group Name"
  type        = string
}

#----------------------------------------
# Storage Variables
#----------------------------------------

# Map of storage accounts to be created
# - Each object includes full configuration details:
#   - name: the storage account name
#   - rg_name: target resource group
#   - kind: type of storage (usually "StorageV2")
#   - tier: Standard or Premium
#   - replication_type: e.g., LRS, GRS
#   - hns_enabled: whether to enable hierarchical namespace (ADLS Gen2)
#   - public_access: enable/disable public access
#   - containers: list of container names to create within the account
variable "storage_account" {
  description = "Map of Storage Accounts to be created"
  type = map(object({
    name             = string
    rg_name          = string
    kind             = string
    tier             = string
    replication_type = string
    hns_enabled      = bool
    public_access    = bool
    allowed_ips      = optional(list(string), [])
    containers       = list(string)
    tags             = map(string)
  }))
}

#----------------------------------------
# Databricks Variables
#----------------------------------------

# Databricks Account ID (used for account-level API interactions, like Unity Catalog and NCC)
# - Typically associated with the `databricks.accounts` provider
variable "databricks_account_id" {
  description = "Databricks Account ID"
  type        = string
}

# Map of Databricks Network Connectivity Configurations (NCCs) by environment
# - Each entry represents a specific NCC (e.g., nonprod, prod)
variable "databricks_ncc" {
  description = "Databricks Network Connectivity Configuration (NCC)"
  type        = map(string)
}

# Specifies the name of the NCC connector in the Databricks account
variable "databricks_ncc_name" {
  description = "Databricks NCC Name"
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
# - The Entra ID group name (`identity_name`)
# - The desired role to assign (`rbac_role`)

# variable "storage_rbac" {
#   description = "Mapping of storage accounts to identity and RBAC role"
#   type = map(object({
#     identity_name = string
#     rbac_role     = string
#   }))
# }


#----------------------------------------
# Datafactory Variables
#----------------------------------------

# variable "data_factories" {
#   description = "Map of Data Factory Resources that will be granted access to the Databricks storage accounts"
#   type = map(object({
#     name    = string
#     rg_name = string
#   }))
# }

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