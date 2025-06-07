# File: /non-prod/network/providers.tf

# Import shared configuration variables such as tenant ID, subscription mappings,
# location, and tags from a common module used across environments
module "common" {
  source = "../../modules/shared-resources"
}

# Configure the backend for storing Terraform state remotely in Azure
# - The storage account, container, and key will be injected via deployment pipeline
terraform {
  backend "azurerm" {}
}

# Configure the Azure Resource Manager provider (azurerm)
# - Uses the shared tenant and subscription values for consistent environment targeting
# - Disables automatic registration of resource providers to speed up deployment
# - Enables OIDC authentication (e.g., for GitHub Actions or other federated identity flows)
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  tenant_id                       = module.common.tenant_id
  subscription_id                 = module.common.subscription_ids["Retail-Data-Services-01"]
  use_oidc                        = true
}
