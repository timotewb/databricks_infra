locals {
  real_environments = var.environment == "prod" ? ["prod"] : ["dev", "test"]
}
locals {
  catalog_workspace_bindings = {
    for pair in flatten([
      for catalog_key, catalog in var.catalog : [
        for binding_key, binding in catalog.bindings : {
          key            = "${catalog_key}_${binding_key}"
          catalog_key    = catalog_key
          binding_key    = binding_key
          catalog_name   = catalog.name
          workspace_id   = binding.workspace_id
          binding_type    = binding.binding_type
          home_workspace  = catalog.home_workspace
          name           = catalog.name
          comment        = catalog.comment
        }
      ]
    ]) :
    pair.key => {
      catalog_name = pair.catalog_name
      workspace_id = pair.workspace_id
      binding_type = pair.binding_type
      home_workspace = pair.home_workspace
      name          = pair.name
      comment       = pair.comment
    }
  }
}

locals {
  catalog_create = {
    for pair in flatten([
      for catalog_key, catalog in var.catalog : {
          key            = "${catalog_key}_catalog_create"
          catalog_key    = catalog_key
          name           = catalog.name
          comment        = catalog.comment
          container_name = catalog.container_name
          storage_account = catalog.storage_account
          sub_directory  = catalog.sub_directory
          home_workspace = catalog.home_workspace
          privileges     = catalog.privileges
    }
    ]) :
    pair.key => {
      name          = pair.name
      comment       = pair.comment
      container_name = pair.container_name
      storage_account = pair.storage_account
      sub_directory = pair.sub_directory
      home_workspace = pair.home_workspace
      privileges    = {
        for privilege_key, privilege_value in pair.privileges : privilege_key => privilege_value
      }
    }
  }
}