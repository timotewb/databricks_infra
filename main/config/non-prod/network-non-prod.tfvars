###################################
# Non-Production Network Settings #
###################################

# Define a map of resource groups to be created in this environment
# - This allows consistent naming and reuse across modules
# - "network" refers to the resource group that will contain all networking-related resources
resourceGroups = {
  "network" = {
    name = "aue-rg-network-np01" # Resource group name for non-production networking components
  }
}

# Define a map of Databricks Network Connectivity Configs (NCCs) to be deployed
# - Each key represents a release environment (e.g., nonprod, prod)
# - Each value includes the unique name for the NCC in that environment
# - NCC is used by Databricks for secure access to Azure services (e.g., storage accounts)
databricks_ncc = {
  non-prod = {
    name = "aue-dbac-retail-ncc-np01" # NCC for the non-production environment
  }
}
