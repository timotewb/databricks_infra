#----------------------------------------------------------------------------------------
# dev
#----------------------------------------------------------------------------------------
resource "databricks_catalog" "dev" {
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == module.common.workspace_names["dev"] }

  provider = databricks.workspace_dev
  name    = each.value.name
  comment = each.value.comment
  isolation_mode = "ISOLATED"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/",
    each.value.container_name,
    each.value.storage_account
  )
}
resource "databricks_workspace_binding" "catalog_dev" {
  depends_on = [ databricks_catalog.dev ]
  for_each = { for k, v in local.catalog_workspace_bindings : k => v if v.home_workspace == module.common.workspace_names["dev"] }

  provider = databricks.workspace_dev
  securable_name = each.value.catalog_name
  workspace_id = each.value.workspace_id
  binding_type = each.value.binding_type
}
resource "databricks_grants" "catalog_dev" {
  depends_on = [ databricks_catalog.dev, databricks_workspace_binding.catalog_dev ]
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == module.common.workspace_names["dev"] }

  provider = databricks.workspace_dev
  catalog = databricks_catalog.dev[each.key].name
  dynamic "grant" {
    for_each = each.value.privileges
    content {
      principal  = grant.key
      privileges = module.common.catalog_grant_templates[grant.value]
    }
  }
}


#----------------------------------------------------------------------------------------
# test
#----------------------------------------------------------------------------------------
resource "databricks_catalog" "test" {
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == module.common.workspace_names["test"] }

  provider = databricks.workspace_test
  name    = each.value.name
  comment = each.value.comment
  isolation_mode = "ISOLATED"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/",
    each.value.container_name,
    each.value.storage_account
  )
}
resource "databricks_workspace_binding" "catalog_test" {
  depends_on = [ databricks_catalog.test ]
  for_each = { for k, v in local.catalog_workspace_bindings : k => v if v.home_workspace == module.common.workspace_names["test"] }

  provider = databricks.workspace_test
  securable_name = each.value.catalog_name
  workspace_id = each.value.workspace_id
  binding_type = each.value.binding_type
}
resource "databricks_grants" "catalog_test" {
  depends_on = [ databricks_catalog.test,  databricks_workspace_binding.catalog_test ]
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == module.common.workspace_names["test"] }

  provider = databricks.workspace_test
  catalog = databricks_catalog.test[each.key].name
  dynamic "grant" {
    for_each = each.value.privileges
    content {
      principal  = grant.key
      privileges = module.common.catalog_grant_templates[grant.value]
    }
  }
}

#----------------------------------------------------------------------------------------
# ana
#----------------------------------------------------------------------------------------
resource "databricks_catalog" "ana" {
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == module.common.workspace_names["ana"] }

  provider = databricks.workspace_ana
  name    = each.value.name
  comment = each.value.comment
  isolation_mode = "ISOLATED"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/",
    each.value.container_name,
    each.value.storage_account
  )
}
resource "databricks_workspace_binding" "catalog_ana" {
  depends_on = [ databricks_catalog.ana ]
  for_each = { for k, v in local.catalog_workspace_bindings : k => v if v.home_workspace == module.common.workspace_names["ana"] }

  provider = databricks.workspace_ana
  securable_name = each.value.catalog_name
  workspace_id = each.value.workspace_id
  binding_type = each.value.binding_type
}
resource "databricks_grants" "catalog_ana" {
  depends_on = [ databricks_catalog.ana, databricks_workspace_binding.catalog_ana ]
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == module.common.workspace_names["ana"] }

  provider = databricks.workspace_ana
  catalog = databricks_catalog.ana[each.key].name
  dynamic "grant" {
    for_each = each.value.privileges
    content {
      principal  = grant.key
      privileges = module.common.catalog_grant_templates[grant.value]
    }
  }
}



#----------------------------------------------------------------------------------------
# prod
#----------------------------------------------------------------------------------------
resource "databricks_catalog" "prod" {
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == module.common.workspace_names["prod"] }

  provider = databricks.workspace_prod
  name    = each.value.name
  comment = each.value.comment
  isolation_mode = "ISOLATED"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/",
    each.value.container_name,
    each.value.storage_account
  )
}
resource "databricks_workspace_binding" "catalog_prod" {
  depends_on = [ databricks_catalog.prod ]
  for_each = { for k, v in local.catalog_workspace_bindings : k => v if v.home_workspace == module.common.workspace_names["prod"] }

  provider = databricks.workspace_prod
  securable_name = each.value.catalog_name
  workspace_id = each.value.workspace_id
  binding_type = each.value.binding_type
}
resource "databricks_grants" "catalog_prod" {
  depends_on = [ databricks_catalog.prod, databricks_workspace_binding.catalog_prod ]
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == module.common.workspace_names["prod"] }

  provider = databricks.workspace_prod
  catalog = databricks_catalog.prod[each.key].name
  dynamic "grant" {
    for_each = each.value.privileges
    content {
      principal  = grant.key
      privileges = module.common.catalog_grant_templates[grant.value]
    }
  }
}