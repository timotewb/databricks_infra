# File: /non-prod/network/providers.tf

# Import shared configuration variables such as tenant ID, subscription mappings,
# location, and tags from a common module used across environments
module "common" {
  source = "../../modules/shared-resources"
}

# Configure the backend for storing Terraform state remotely in Azure
# - The storage account, container, and key will be injected via deployment pipeline
# terraform {
#   backend "azurerm" {}
# }

# Configure the Azure Resource Manager provider (azurerm)
# - Uses the shared tenant and subscription values for consistent environment targeting
# - Disables automatic registration of resource providers to speed up deployment
# - Enables OIDC authentication (e.g., for GitHub Actions or other federated identity flows)
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  tenant_id                       = module.common.tenant_id
  subscription_id                 = module.common.subscription_ids["devops-as"]
  client_id                       = var.client_id
  client_secret                   = var.client_secret
}

provider "databricks" {
  alias      = "accounts"
  host       = "https://accounts.azuredatabricks.net"
  account_id = var.databricks_account_id
  azure_tenant_id     = var.tenant_id
  azure_client_id     = var.client_id
  azure_client_secret = var.client_secret
  auth_type  = "azure-cli"
}
provider "databricks" {
  alias = "workspace_dev"
  host = var.workspace_url_dev
  account_id = var.databricks_account_id
  azure_tenant_id     = var.tenant_id
  azure_client_id     = var.client_id
  azure_client_secret = var.client_secret
  auth_type  = "azure-cli"
}
provider "databricks" {
  alias = "workspace_test"
  host = var.workspace_url_test
  account_id = var.databricks_account_id
  azure_tenant_id     = var.tenant_id
  azure_client_id     = var.client_id
  azure_client_secret = var.client_secret
  auth_type  = "azure-cli"
}

provider "databricks" {
  alias = "workspace_ana"
  host = var.workspace_url_ana
  account_id = var.databricks_account_id
  azure_tenant_id     = var.tenant_id
  azure_client_id     = var.client_id
  azure_client_secret = var.client_secret
  auth_type  = "azure-cli"
}

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