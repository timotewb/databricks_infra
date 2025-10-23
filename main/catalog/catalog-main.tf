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
