# Specify required Terraform providers for this configuration
# - This ensures Terraform downloads the correct plugin for interacting with Databricks
# - The 'source' attribute defines the official provider namespace on the Terraform Registry
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.21.1"
    }
    databricks = {
      source = "databricks/databricks"
      version = "1.69.0"
      configuration_aliases = [ databricks.accounts ]
    }
  }
}
