catalog = {
#----------------------------------------------------------------------------------------
# dev catalogs
#----------------------------------------------------------------------------------------
# x_raw
  "dev_x_raw_retail" = {
    home_workspace = "dev-retail-data-core"
    name                  = "dev_x_raw_retail"
    comment = "This is the source raw catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcdtw33"
    container_name = "x-raw"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write3"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_code: "dev",
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# source
  "dev_source_retail" = {
    home_workspace = "dev-retail-data-core"
    name                  = "dev_source_retail"
    comment = "This is the source catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcdtw33"
    container_name = "source"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write2"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_code: "dev",
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# integrated
  "dev_integrated_retail" = {
    home_workspace = "dev-retail-data-core"
    name                  = "dev_integrated_retail"
    comment = "This is the integrated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcdtw33"
    container_name = "integrated"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write2"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_code: "dev",
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# curated  
  "dev_curated_retail" = {
    home_workspace = "dev-retail-data-core"
    name                  = "dev_curated_retail"
    comment = "This is the curated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcdtw33"
    container_name = "curated"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "write2"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_code: "dev",
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
    name                  = "test_x_raw_retail"
    comment = "This is the source raw catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcttw33"
    container_name = "x-raw"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "read"
    }
    bindings = {
      "test-retail-data-core": {
        workspace_code: "test",
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# source
  "test_source_retail" = {
    home_workspace = "test-retail-data-core"
    name                  = "test_source_retail"
    comment = "This is the source catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcdtw33"
    container_name = "source"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "read"
    }
    bindings = {
      "test-retail-data-core": {
        workspace_code: "test",
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# # integrated
  "test_integrated_retail" = {
    home_workspace = "test-retail-data-core"
    name                  = "test_integrated_retail"
    comment = "This is the integrated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcttw33"
    container_name = "integrated"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "read"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_code: "dev",
        binding_type: "BINDING_TYPE_READ_ONLY"
      }
      "test-retail-data-core": {
        workspace_code: "test",
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# # curated
  "test_curated_retail" = {
    home_workspace = "test-retail-data-core"
    name                  = "test_curated_retail"
    comment = "This is the curated catalog for the Retail Data Core platform, managed through Terraform."
    storage_account  = "auestorrdcttw33"
    container_name = "curated"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "read"
      "data.engineer@timotewblive.onmicrosoft.com" = "read"
    }
    bindings = {
      "dev-retail-data-core": {
        workspace_code: "dev",
        binding_type: "BINDING_TYPE_READ_ONLY"
      }
      "test-retail-data-core": {
        workspace_code: "test",
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }

}
