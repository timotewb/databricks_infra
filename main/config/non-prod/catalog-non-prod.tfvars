catalog = {
#----------------------------------------------------------------------------------------
# dev catalogs
#----------------------------------------------------------------------------------------
# x_raw
  "swuce_x_raw" = {
    home_workspace = "swuce-np-dbrws"
    name                  = "swuce_x_raw"
    comment = "This is the source raw catalog managed through Terraform."
    storage_account  = "swuce0sa"
    container_name = "swuce-x-raw"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "write1"
      "data.engineer@timotewblive.onmicrosoft.com" = "write1"
    }
    bindings = {
      "swuce-np-ac": {
        workspace_code: "dev",
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# source
  "swuce_source" = {
    home_workspace = "swuce-np-dbrws"
    name                  = "swuce_source"
    comment = "This is the source catalog managed through Terraform."
    storage_account  = "swuce0sa"
    container_name = "swuce-source"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "write1"
      "data.engineer@timotewblive.onmicrosoft.com" = "write1"
    }
    bindings = {
      "swuce-np-ac": {
        workspace_code: "dev",
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# integrated
  "swuce_integrated" = {
    home_workspace = "swuce-np-dbrws"
    name                  = "swuce_integrated"
    comment = "This is the integrated catalog managed through Terraform."
    storage_account  = "swuce0sa"
    container_name = "swuce-integrated"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "write1"
      "data.engineer@timotewblive.onmicrosoft.com" = "write1"
    }
    bindings = {
      "swuce-np-ac": {
        workspace_code: "dev",
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
# curated  
  "swuce_curated" = {
    home_workspace = "swuce-np-dbrws"
    name                  = "swuce_curated"
    comment = "This is the curated catalog managed through Terraform."
    storage_account  = "swuce0sa"
    container_name = "swuce-curated"
    privileges = {
      "admin@timotewblive.onmicrosoft.com" = "write1"
      "data.engineer@timotewblive.onmicrosoft.com" = "write1"
    }
    bindings = {
      "swuce-np-ac": {
        workspace_code: "dev",
        binding_type: "BINDING_TYPE_READ_WRITE"
      }
    }
  }
}