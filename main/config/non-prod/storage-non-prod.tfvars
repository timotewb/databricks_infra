# Databricks Settings

#----------------------------------------
# DATABRICKS ACCOUNT & WORKSPACE SETTINGS
#----------------------------------------

# The Databricks account ID (used for account-level APIs like Unity Catalog)
# - This ID is typically used with the `databricks.accounts` provider alias

# The Azure Resource ID of the Databricks workspace
# - Used for workspace-scoped resources (clusters, jobs, external locations, etc.)
# - This is due to a limitation with the current Databricks Terraform provider / Databricks implementation
# - It doens't matter which workspace this is, as long as the Azure OIDC can authenticate to it

# Map of Databricks Network Connectivity Connectors (NCCs)
# - One entry per environment (e.g., nonprod)
# - Used to securely access Azure resources from Databricks via managed identity
databricks_ncc = {
  non-prod = "aue-dbac-retail-ncc-np01"
}

# The Databricks NCC name in the account cloud resources that contains private endpoint rules
databricks_ncc_name = "ncc-retail"

#----------------------------------------
# NETWORK CONFIGURATION
#----------------------------------------

# Name of the resource group containing the networking components (e.g., NCC, vNet, private endpoints)
network_rg = "aue-rg-network-np01"

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
  "datalake" = {
    name             = "auestormdpdatalakenptw33" # ADLS account for the general data lake
    rg_name          = "aue-rg-dataplatform-np01"
    kind             = "StorageV2"
    tier             = "Standard"
    replication_type = "GRS"
    hns_enabled      = true
    public_access    = false
    containers       = ["mdp-lakehouse", "data", "user"] # Container(s) to create in this account
    allowed_ips      = []
    tags = {
      Environment = "npe"
      CostCenter  = "TBD"
      Owner       = "TBD"
    }
  }

  "rdcd01" = {
    name             = "auestorrdcdtw33" # ADLS account for Retail D01
    rg_name          = "aue-rg-dataplatform-d01"
    kind             = "StorageV2"
    tier             = "Standard"
    replication_type = "GRS"
    hns_enabled      = true
    public_access    = true
    containers       = ["mdp-lakehouse", "source", "integrated", "curated", "x-raw"]
    allowed_ips      = []
    tags = {
      Environment = "dev"
      CostCenter  = "TBD"
      Owner       = "TBD"
    }
  }

  "rdct01" = {
    name             = "auestorrdcttw33" # ADLS account for Retail T01
    rg_name          = "aue-rg-dataplatform-t01"
    kind             = "StorageV2"
    tier             = "Standard"
    replication_type = "GRS"
    hns_enabled      = true
    public_access    = true
    containers       = ["mdp-lakehouse", "source", "integrated", "curated", "x-raw"]
    allowed_ips      = []
    tags = {
      Environment = "test"
      CostCenter  = "TBD"
      Owner       = "TBD"
    }
  }

  "rdca01" = {
    name             = "auestorrdcatw33" # ADLS account for Retail T01
    rg_name          = "aue-rg-dataplatform-a01"
    kind             = "StorageV2"
    tier             = "Standard"
    replication_type = "GRS"
    hns_enabled      = true
    public_access    = true
    containers       = ["mdp-lakehouse", "data", "user"]
    allowed_ips      = []
    tags = {
      Environment = "test"
      CostCenter  = "TBD"
      Owner       = "TBD"
    }
  }
}

#----------------------------------------
# STORAGE ACCOUNT INITIAL RBAC ASSIGNMENTS
#----------------------------------------

# This variable defines which Entra ID (Azure AD) identity should be granted
# what role on each storage account. The key must match the actual storage
# account name (e.g., "auestorrdcd01"). 
#
# !!! Further RBAC updates should be made in the RBAC specific codebase. 

storage_rbac = {
  "auestorrdcd01" = {
    identity_name = "Data_Team_Developers"
    rbac_role     = "Storage Blob Data Contributor"
  }
  "auestorrdct01" = {
    identity_name = "Data_Team_Developers"
    rbac_role     = "Storage Blob Data Contributor"
  }
}

#----------------------------------------
# DATA FACTORY STORAGE ACCOUNT RBAC
#----------------------------------------

# Map of Data Factory names that require their managed identities to be assigned access to the Databricks storage accounts
data_factories = {
  dev-dataplatform-source-data-df = {
    name    = "dev-dataplatform-source-data-df"
    rg_name = "CustomerTeam-Warehouse-Dev"
  }
  test-dataplatform-source-data-df = {
    name    = "test-dataplatform-source-data-df"
    rg_name = "customerteam-warehouse-test"
  }
  qa-dataplatform-source-data-df = {
    name    = "qa-dataplatform-source-data-df"
    rg_name = "customerteam-warehouse-qa"
  }
  prod-dataplatform-source-data-df = {
    name    = "prod-dataplatform-source-data-df"
    rg_name = "CustomerTeam-Warehouse-prod"
  }
  dev-mdp-process-df = {
    name    = "dev-mdp-process-df"
    rg_name = "customerteam-warehouse-dev"
  }
  test-mdp-process-df = {
    name    = "test-mdp-process-df"
    rg_name = "CustomerTeam-Warehouse-Test"
  }
  qa-mdp-process-df = {
    name    = "qa-mdp-process-df"
    rg_name = "CustomerTeam-Warehouse-QA"
  }
  prod-mdp-process-df = {
    name    = "prod-mdp-process-df"
    rg_name = "CustomerTeam-Warehouse-Prod"
  }
}

environment = "non-prod" # Specifies the deployment environment for this configuration