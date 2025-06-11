# Catalog Settings

#----------------------------------------
# DATABRICKS ACCOUNT & WORKSPACE SETTINGS
#----------------------------------------

# The Databricks account ID (used for account-level APIs like Unity Catalog)
# - This ID is typically used with the `databricks.accounts` provider alias

# The Azure Resource ID of the Databricks workspace
# - Used for workspace-scoped resources (clusters, jobs, external locations, etc.)
# - This is due to a limitation with the current Databricks Terraform provider / Databricks implementation
# - It doens't matter which workspace this is, as long as the Azure OIDC can authenticate to it

# Map of catalog configuration keyed by logical catalog identifiers.
# Each entry defines properties for a catalog.
catalog = {
#----------------------------------------------------------------------------------------
# analyst catalogs
#----------------------------------------------------------------------------------------
# data
  "ana_data_retail" = {
    home_workspace = "prod-retail-analyst"
    name                  = "ana_data_retail" # Name of the catalog in ui
    comment = "This catalog is used to store permanenet business and project data, managed through Terraform."
    storage_account  = "auestorrdcpatw33"
    container_name = "data"
    sub_directory = "data"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write3"
    }
    bindings = {
      "prod-retail-analyst": {
        workspace_id: 2576627461530391,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# user
  "ana_user_retail" = {
    home_workspace = "prod-retail-analyst"
    name                  = "ana_user_retail" # Name of the catalog in ui
    comment = "This catalog is used as a user sandbox for storing data, managed through Terraform."
    storage_account  = "auestorrdcpatw33"
    container_name = "user"
    sub_directory = "user"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write3"
    }
    bindings = {
      "prod-retail-analyst": {
        workspace_id: 2576627461530391,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
#----------------------------------------------------------------------------------------
# prod catalogs
#----------------------------------------------------------------------------------------
# x_raw
  "prod_x_raw_retail" = {
    home_workspace = "prod-retail-data-core"
    name                  = "prod_x_raw_retail" # Name of the catalog in ui
    comment = "This is the source raw catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcptw33"
    container_name = "x-raw"
    sub_directory = "x-raw"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write3"
    }
    bindings = {
      "prod-retail-data-core": {
        workspace_id: 455787457764141,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# source
  "prod_source_retail" = {
    home_workspace = "prod-retail-data-core"
    name                  = "prod_source_retail" # Name of the catalog in ui
    comment = "This is the source catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcptw33"
    container_name = "source"
    sub_directory = "source"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write2"
    }
    bindings = {
      "prod-retail-data-core": {
        workspace_id: 455787457764141,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# integrated
  "prod_integrated_retail" = {
    home_workspace = "prod-retail-data-core"
    name                  = "prod_integrated_retail" # Name of the catalog in ui
    comment = "This is the integrated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcptw33"
    container_name = "integrated"
    sub_directory = "integrated"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write2"
    }
    bindings = {
      "prod-retail-data-core": {
        workspace_id: 455787457764141,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
      "prod-retail-analyst": {
        workspace_id: 2576627461530391,
        binding_type: "BINDING_TYPE_READ_ONLY"
      }
    }
  }
# curated  
  "prod_curated_retail" = {
    home_workspace = "prod-retail-data-core"
    name                  = "prod_curated_retail" # Name of the catalog in ui
    comment = "This is the curated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcptw33"
    container_name = "curated"
    sub_directory = "curated"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write2"
    }
    bindings = {
      "prod-retail-data-core": {
        workspace_id: 455787457764141,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
      "prod-retail-analyst": {
        workspace_id: 2576627461530391,
        binding_type: "BINDING_TYPE_READ_ONLY"
      }
    }
  }

}
