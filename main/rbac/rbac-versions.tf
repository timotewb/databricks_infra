# Specify required Terraform providers for this configuration
# - This ensures Terraform downloads the correct plugin for interacting with Databricks
# - The 'source' attribute defines the official provider namespace on the Terraform Registry
terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks" # Official Databricks provider from the Terraform Registry
    }
  }
}
