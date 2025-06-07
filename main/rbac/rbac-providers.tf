#######################################
# File: /non-prod/rbac/providers.tf #
#######################################

# Import common module that contains shared configuration data 
# such as tenant ID and subscription mappings
module "common" {
  source = "../../modules/shared-resources"
}

# Configure the backend for Terraform state
# The actual storage account, container, and key will be passed in from the deployment workflow
terraform {
  backend "azurerm" {}
}

# Configure the Azure Resource Manager (azurerm) provider
# - Disables automatic registration of resource providers for faster execution
# - Uses OIDC authentication (e.g., GitHub Actions federated identity)
# - Uses subscription and tenant ID from the common module
provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  tenant_id                       = module.common.tenant_id
  subscription_id                 = module.common.subscription_ids["Retail-Data-Services-01"]
  use_oidc                        = true
}

provider "azurerm" {
  alias = "Production"
  features {}
  resource_provider_registrations = "none"
  tenant_id                       = module.common.tenant_id
  subscription_id                 = module.common.subscription_ids["Production"]
  use_oidc                        = true
}

# Configure the Azure Active Directory (azuread) provider
# - Used for managing AAD objects such as service principals and groups
# - Tenant ID is retrieved from the common module
provider "azuread" {
  tenant_id = module.common.tenant_id
}

# Configure the Databricks provider for **account-level** resources
# - Used for Unity Catalog objects such as storage credentials and external locations
# - Requires account-level host and account ID
provider "databricks" {
  alias      = "accounts"
  host       = "https://accounts.azuredatabricks.net"
  account_id = var.databricks_account_id
}

# Configure the Databricks provider for **workspace-level** resources
# - Used for clusters, jobs, and workspace-scoped assets
# - Uses the Azure resource ID of the target Databricks workspace
provider "databricks" {
  alias                       = "workspace"
  azure_workspace_resource_id = var.databricks_workspace_id
}
