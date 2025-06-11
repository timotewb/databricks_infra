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

variable "catalog_grant_templates"{
  type = map(list(string))
  description = "Map of grant templates keyed by names. Each template defines a set of privileges for Unity Catalog."
  default = {
  "read" = ["USE_CATALOG", "USE_SCHEMA", "BROWSE", "EXECUTE", "READ_VOLUME", "SELECT"]
  "write3" = ["USE_CATALOG", "USE_SCHEMA", "APPLY_TAG", "BROWSE", "EXECUTE", "READ_VOLUME", "SELECT", "MODIFY", "REFRESH"]
  "write2" = ["USE_CATALOG", "USE_SCHEMA", "APPLY_TAG", "BROWSE", "EXECUTE", "READ_VOLUME", "SELECT", "MODIFY", "REFRESH", "WRITE_VOLUME"]
  "write1" = ["USE_CATALOG", "USE_SCHEMA", "APPLY_TAG", "BROWSE", "EXECUTE", "READ_VOLUME", "SELECT", "MODIFY", "REFRESH", "WRITE_VOLUME", "CREATE"]
  }
}
variable "workspace_names" {
  description = "Map of workspace names keyed by environment"
  type        = map(string)
  default = {
    "dev"  = "dev-retail-data-core"
    "test" = "test-retail-data-core"
    "prod" = "prod-retail-data-core"
    "ana"  = "prod-retail-analyst"
  }
}

variable "workspace_ids" {
  description = "Map of workspace ids keyed by environment"
  type        = map(number)
  default = {
    "dev"  = 3314672737661664
    "test" = 1952610885136542
    "prod" = 3939779496654265
    "ana"  = 3754814852473328
  }
}

variable "workspace_urls" {
  description = "Map of workspace urls keyed by environment"
  type        = map(string)
  default = {
    "dev"  = "https://adb-3314672737661664.4.azuredatabricks.net"
    "test" = "https://adb-1952610885136542.2.azuredatabricks.net"
    "prod" = "https://adb-3939779496654265.5.azuredatabricks.net"
    "ana"  = "https://adb-3754814852473328.8.azuredatabricks.net"
  }
}