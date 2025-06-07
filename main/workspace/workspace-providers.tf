# File: /non-prod/Network/providers.tf

#----------------------------------------
# Shared Module Import
#----------------------------------------

# Import common variables and values (e.g., tenant ID, subscription mappings)
# from a central module containing shared configuration resources.
module "common" {
  source = "../../modules/shared-resources"
}

#----------------------------------------
# Terraform Backend Configuration
#----------------------------------------

# Configure the backend to use Azure Blob Storage (azurerm) for state file management.
# Backend settings like storage account name, container name, and key are provided via the deployment pipeline (e.g., GitHub Actions or Azure DevOps).
terraform {
  backend "azurerm" {}
}

#----------------------------------------
# AzureRM Provider Configuration
#----------------------------------------

# Configure the AzureRM provider to:
# - Disable automatic registration of resource providers for performance/stability.
# - Use values from the shared 'common' module for tenant ID and subscription ID.
# - Authenticate using OpenID Connect (OIDC), typically enabled via GitHub Actions federated credentials.
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  tenant_id                       = module.common.tenant_id
  subscription_id                 = module.common.subscription_ids["Retail-Data-Services-01"]
  use_oidc                        = true
}

#----------------------------------------
# Databricks Account-Level Provider
#----------------------------------------

# Configure a Databricks provider for account-level operations (e.g., workspace creation).
# The `accounts` alias distinguishes it from a workspace-scoped provider, if used elsewhere.
provider "databricks" {
  alias      = "accounts"
  host       = "https://accounts.azuredatabricks.net" # URL for Databricks account APIs
  account_id = var.databricks_account_id              # Sourced from tfvars or variable file
}
