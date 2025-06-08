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

# Map of catalog configuration keyed by logical catalog identifiers.
# Each entry defines properties for a catalog.
catalog = {

  # Dev source_raw catalog for Retail Data Core platform
  "dev_source_raw_retail" = {
    name                  = "dev_source_raw_retail"
    workspace             = ["dev-retail-data-core"]
    privileges            = {
                                "RDS-Admin" = ["ALL_PRIVILEGES"]
                            }
    comment               = "This is the source raw catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcd01"
  }

  "test_source_raw_retail" = {
    name                  = "test_source_raw_retail"
    workspace             = ["test-retail-data-core"]
    privileges            = {
                                "RDS-Admin" = ["ALL_PRIVILEGES"]
                            }
    comment               = "This is the source raw catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdct01"
  }

  # dev source catalog for Retail Data Core platform
  "dev_source_retail" = {
    name                  = "dev_source_retail"
    workspace             = ["dev-retail-data-core"]
    privileges            = {
                                "RDS-Admin" = ["ALL_PRIVILEGES"]
                            }
    comment               = "This is the source catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcd01"
  }

  "test_source_retail" = {
    name                  = "test_source_retail"
    workspace             = ["test-retail-data-core"]
    privileges            = {
                                "RDS-Admin" = ["ALL_PRIVILEGES"]
                            }
    comment               = "This is the source catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdct01"
  }

  # dev integrated catalog for Retail Data Core platform
  "dev_integrated_retail" = {
    name                  = "dev_integrated_retail"
    workspace             = ["dev-retail-data-core"]
    privileges            = {
                                "RDS-Admin" = ["ALL_PRIVILEGES"]
                            }
    comment               = "This is the integrated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcd01"
  }

  "test_integrated_retail" = {
    name                  = "test_integrated_retail"
    workspace             = ["test-retail-data-core"]
    privileges            = {
                                "RDS-Admin" = ["ALL_PRIVILEGES"]
                            }
    comment               = "This is the integrated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdct01"
  }

  # dev curated catalog for Retail Data Core platform
  "dev_curated_retail" = {
    name                  = "dev_curated_retail"
    workspace             = ["dev-retail-data-core"]
    privileges            = {
                                "RDS-Admin" = ["ALL_PRIVILEGES"]
                            }
    comment               = "This is the curated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcd01"
  }

  "test_curated_retail" = {
    name                  = "test_curated_retail"
    workspace             = ["test-retail-data-core"]
    privileges            = {
                                "RDS-Admin" = ["ALL_PRIVILEGES"]
                            }
    comment               = "This is the curated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdct01"
  }
}
