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

# workspace names used to filter


# map of grant templates keyed by names.

# Map of catalog configuration keyed by logical catalog identifiers.
# Each entry defines properties for a catalog.
catalog = {
#----------------------------------------------------------------------------------------
# analyst catalogs
#----------------------------------------------------------------------------------------
# data
  "ana_data_retail" = {
    home_workspace = "ana-retail-data-core"
    name                  = "ana_data_retail" # Name of the catalog in ui
    comment = "This catalog is used to store permanenet business and project data, managed through Terraform."
    storage_account  = "auestorrdcatw33"
    container_name = "data"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write3"
    }
    bindings = {
      "ana-retail-data-core": {
        workspace_id: 1697628615520647,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# user
  "ana_user_retail" = {
    home_workspace = "ana-retail-data-core"
    name                  = "ana_user_retail" # Name of the catalog in ui
    comment = "This catalog is used as a user sandbox for storing data, managed through Terraform."
    storage_account  = "auestorrdcatw33"
    container_name = "user"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write3"
    }
    bindings = {
      "ana-retail-data-core": {
        workspace_id: 1697628615520647,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
#----------------------------------------------------------------------------------------
# dev catalogs
#----------------------------------------------------------------------------------------
# x_raw
  "dev_x_raw_retail" = {
    home_workspace = "dev-retail-data-core"
    name                  = "dev_x_raw_retail" # Name of the catalog in ui
    comment = "This is the source raw catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcdtw33"
    container_name = "x-raw"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write3"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_id: 2147433627612946,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# source
  "dev_source_retail" = {
    home_workspace = "dev-retail-data-core"
    name                  = "dev_source_retail" # Name of the catalog in ui
    comment = "This is the source catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcdtw33"
    container_name = "source"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write2"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_id: 2147433627612946,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# integrated
  "dev_integrated_retail" = {
    home_workspace = "dev-retail-data-core"
    name                  = "dev_integrated_retail" # Name of the catalog in ui
    comment = "This is the integrated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcdtw33"
    container_name = "integrated"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write2"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_id: 2147433627612946,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# curated  
  "dev_curated_retail" = {
    home_workspace = "dev-retail-data-core"
    name                  = "dev_curated_retail" # Name of the catalog in ui
    comment = "This is the curated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcdtw33"
    container_name = "curated"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write2"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_id: 2147433627612946,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }

#----------------------------------------------------------------------------------------
# test catalogs
#----------------------------------------------------------------------------------------
# x_raw
  "test_x_raw_retail" = {
    home_workspace = "test-retail-data-core"
    name                  = "test_x_raw_retail" # Name of the catalog in ui
    comment = "This is the source raw catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcttw33"
    container_name = "x-raw"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "read"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_id: 2147433627612946,
        binding_type: "BINDING_TYPE_READ_ONLY"
      }
      "test-retail-data-core": {
        workspace_id: 301826705083788,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# source
  "test_source_retail" = {
    home_workspace = "test-retail-data-core"
    name                  = "test_source_retail" # Name of the catalog in ui
    comment = "This is the source catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcdtw33"
    container_name = "source"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "read"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_id: 2147433627612946,
        binding_type: "BINDING_TYPE_READ_ONLY"
      }
      "test-retail-data-core": {
        workspace_id: 301826705083788,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# # integrated
  "test_integrated_retail" = {
    home_workspace = "test-retail-data-core"
    name                  = "test_integrated_retail" # Name of the catalog in ui
    comment = "This is the integrated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcttw33"
    container_name = "integrated"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "read"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_id: 2147433627612946,
        binding_type: "BINDING_TYPE_READ_ONLY"
      }
      "test-retail-data-core": {
        workspace_id: 301826705083788,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# # curated
  "test_curated_retail" = {
    home_workspace = "test-retail-data-core"
    name                  = "test_curated_retail" # Name of the catalog in ui
    comment = "This is the curated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcttw33"
    container_name = "curated"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "read"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_id: 2147433627612946,
        binding_type: "BINDING_TYPE_READ_ONLY"
      }
      "test-retail-data-core": {
        workspace_id: 301826705083788,
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }

}
