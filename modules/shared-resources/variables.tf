# File: /modules/shared-resources/variables.tf

#----------------------------------------
# Azure Account Variables 
#----------------------------------------


variable "timwbdbr_ar" {
  description = "Service Principal"
  type        = string
  default     = "7ce72dbd-8896-45e9-8eee-110c86ee50e7"
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = "c0341060-11ba-4e09-a49e-b2074cc0a379"
}

variable "subscription_ids" {
  description = "Map of subscription names to their IDs"
  type        = map(string)
  default = {
    "devops-as"   = "5f3d7f2f-1189-427d-aaa3-5c220e2b3e9a"
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
    BusinessUnit = "TimWB"
    Project      = "TimWB Data Platform"
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
  default     = "6d7f2b45-dc09-4790-a3c4-f3bc088d7cee"
}