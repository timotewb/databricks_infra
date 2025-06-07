# File: non-prod/network/network.tf

# Create a resource group for network-related resources
# - Name is sourced from the shared variable map for consistency across environments
# - Location and tags are pulled from the shared 'common' module
resource "azurerm_resource_group" "network_rg" {
  name     = var.resourceGroups["network"].name
  location = module.common.location["primary"]
  tags     = module.common.tags
}

# Deploy a Databricks Network Access Connector (NCC)
# - Required for Unity Catalog and external access via managed identity
# - Enables secure communication between Databricks and other Azure services (e.g., storage accounts)
# - Assigned a system-managed identity for authentication
# - Deployed into the network resource group
resource "azurerm_databricks_access_connector" "ncc" {
  depends_on          = [azurerm_resource_group.network_rg]
  name                = var.databricks_ncc[var.environment].name
  resource_group_name = var.resourceGroups["network"].name
  location            = module.common.location["primary"]
  identity {
    type = "SystemAssigned" # Automatically creates an Azure-managed identity for use by Databricks
  }
}
