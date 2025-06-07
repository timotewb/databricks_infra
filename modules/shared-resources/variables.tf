# File: /modules/shared-resources/variables.tf

#----------------------------------------
# Azure Account Variables 
#----------------------------------------


variable "github_app_id" {
  description = "Github Runner Application ID"
  type        = string
  default     = "ac923905-5fe6-42d5-8fd1-8f620ced9081"
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = "e6cf3f80-614d-4939-895c-3d5287c0f245"
}

variable "subscription_ids" {
  description = "Map of subscription names to their IDs"
  type        = map(string)
  default = {
    "Retail-DevOps-Management-01"   = "89f0b118-29c4-4df8-a5ff-2eac7ab3e7ba"
    "Retail-Customer-Experience-01" = "c371dd75-2d84-4642-824d-c3aa73405064"
    "Retail-Data-Services-01"       = "c4328310-9fdc-4b88-8c5d-7287350bba6f"
    "Retail-Connectivity-01"        = "7192c3fd-8037-43ba-b062-404f405d6837"
    "Production"                    = "6d322761-8e09-4cd8-9c3b-b2650706e02e"
  }
}

variable "location" {
  description = "Map of subscription names to their IDs"
  type        = map(string)
  default = {
    "primary"   = "australiaeast"
    "secondary" = "australiasoutheast"
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    BusinessUnit = "NZ Retail"
    Project      = "Retail Data Platform"
    ManagedBy    = "Terraform"
  }
}

variable "tag_env_aliases" {
  description = "Map of environment names to accepted tag values"
  type        = map(list(string))
  default = {
    dev  = ["dev", "development"]
    test = ["test", "testing"]
    prod = ["prod", "production"]
  }
}

#----------------------------------------
# Databricks Account Variables 
#----------------------------------------

variable "metastore_id" {
  description = "Databricks Unity Catalog Metastore ID"
  type        = string
  default     = "e3008994-ec27-419e-9f55-0a8e2e36c717"
}