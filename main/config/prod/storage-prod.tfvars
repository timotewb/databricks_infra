# Databricks Settings

#----------------------------------------
# DATABRICKS ACCOUNT & WORKSPACE SETTINGS
#----------------------------------------

# The Databricks account ID (used for account-level APIs like Unity Catalog)
# - This ID is typically used with the `databricks.accounts` provider alias


# The Azure Resource ID of the Databricks workspace
# - Used for workspace-scoped resources (clusters, jobs, external locations, etc.)

# Map of Databricks Network Connectivity Connectors (NCCs)
# - One entry per environment (e.g., nonprod)
# - Used to securely access Azure resources from Databricks via managed identity
databricks_ncc = {
  prod = "aue-dbac-retail-ncc-p01"
}

# The Databricks NCC name in the account cloud resources that contains private endpoint rules
databricks_ncc_name = "ncc-retail-prod"

#----------------------------------------
# NETWORK CONFIGURATION
#----------------------------------------

# Name of the resource group containing the networking components (e.g., NCC, vNet, private endpoints)
network_rg = "aue-rg-network-p01"

#----------------------------------------
# STORAGE ACCOUNT CONFIGURATION
#----------------------------------------

# Map of storage account definitions, keyed by logical name
# Each entry contains:
# - The actual storage account name
# - Resource group name where it should be deployed
# - Type (StorageV2), tier (Standard), and replication type (e.g., GRS)
# - Whether hierarchical namespace is enabled (HNS = true for ADLS Gen2)
# - Public access (false = private)
# - List of containers to create within the account

storage_account = {
  "rdcp01" = {
    name             = "auestorrdcptw33" # ADLS account for Retail P01
    rg_name          = "aue-rg-dataplatform-p01"
    kind             = "StorageV2"
    tier             = "Standard"
    replication_type = "GRS"
    hns_enabled      = true
    public_access    = true
    containers       = ["mdp-lakehouse", "source", "integrated", "curated", "x-raw"] # Container(s) to create in this account
    allowed_ips      = []
    tags = {
      Environment = "prod"
      CostCenter  = "TBD"
      Owner       = "TBD"
    }
  }
  "rdca01" = {
    name             = "auestorrdcpatw33" # ADLS account for Retail P01
    rg_name          = "aue-rg-dataplatform-p01"
    kind             = "StorageV2"
    tier             = "Standard"
    replication_type = "GRS"
    hns_enabled      = true
    public_access    = true
    containers       = ["mdp-lakehouse", "data", "user"] # Container(s) to create in this account
    allowed_ips      = []
    tags = {
      Environment = "analyst"
      CostCenter  = "TBD"
      Owner       = "TBD"
    }
  }
}

#----------------------------------------
# STORAGE ACCOUNT RBAC ASSIGNMENTS
#----------------------------------------

# This variable defines which Entra ID (Azure AD) identity should be granted
# what role on each storage account. The key must match the actual storage
# account name (e.g., "auestorrdcd01").

storage_rbac = {
  "auestorrdcp01" = {
    identity_name = "Data_Team_Developers"
    rbac_role     = "Storage Blob Data Contributor"
  }
}

#----------------------------------------
# DATA FACTORY STORAGE ACCOUNT RBAC
#----------------------------------------

# Map of Data Factory names that require their managed identities to be assigned access to the Databricks storage accounts
data_factories = {
    prod-dataplatform-source-data-df = {
    name    = "prod-dataplatform-source-data-df"
    rg_name = "CustomerTeam-Warehouse-prod"
  }
}

environment = "prod" # Specifies the deployment environment for this configuration