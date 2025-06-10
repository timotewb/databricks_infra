#----------------------------------------------------------------------------------------
# dev
#----------------------------------------------------------------------------------------
resource "databricks_catalog" "dev" {
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == var.workspace_names["dev"] }

  provider = databricks.workspace_dev
  name    = each.value.name
  comment = each.value.comment
  isolation_mode = "ISOLATED"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/%s",
    each.value.container_name,
    each.value.storage_account,
    each.value.sub_directory
  )
}
resource "databricks_workspace_binding" "catalog_dev" {
  depends_on = [ databricks_catalog.dev ]
  for_each = { for k, v in local.catalog_workspace_bindings : k => v if v.home_workspace == var.workspace_names["dev"] }

  provider = databricks.workspace_dev
  securable_name = each.value.catalog_name
  workspace_id = each.value.workspace_id
  binding_type = each.value.binding_type
}
resource "databricks_grants" "catalog_dev" {
  depends_on = [ databricks_catalog.dev, databricks_workspace_binding.catalog_dev ]
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == var.workspace_names["dev"] }
  
  provider = databricks.workspace_dev
  catalog = databricks_catalog.dev[each.key].name
  dynamic "grant" {
    for_each = each.value.privileges
    content {
      principal  = grant.key
      privileges = var.catalog_grant_templates[grant.value]
    }
  }
}


#----------------------------------------------------------------------------------------
# test
#----------------------------------------------------------------------------------------
resource "databricks_catalog" "test" {
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == var.workspace_names["test"] }

  provider = databricks.workspace_test
  name    = each.value.name
  comment = each.value.comment
  isolation_mode = "ISOLATED"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/%s",
    each.value.container_name,
    each.value.storage_account,
    each.value.sub_directory
  )
}
resource "databricks_workspace_binding" "catalog_test" {
  depends_on = [ databricks_catalog.test ]
  for_each = { for k, v in local.catalog_workspace_bindings : k => v if v.home_workspace == var.workspace_names["test"] }

  provider = databricks.workspace_test
  securable_name = each.value.catalog_name
  workspace_id = each.value.workspace_id
  binding_type = each.value.binding_type
}
resource "databricks_grants" "catalog_test" {
  depends_on = [ databricks_catalog.test,  databricks_workspace_binding.catalog_test ]
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == var.workspace_names["test"] }

  provider = databricks.workspace_test
  catalog = databricks_catalog.test[each.key].name
  dynamic "grant" {
    for_each = each.value.privileges
    content {
      principal  = grant.key
      privileges = var.catalog_grant_templates[grant.value]
    }
  }
}

#----------------------------------------------------------------------------------------
# ana
#----------------------------------------------------------------------------------------
resource "databricks_catalog" "ana" {
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == var.workspace_names["ana"] }

  provider = databricks.workspace_ana
  name    = each.value.name
  comment = each.value.comment
  isolation_mode = "ISOLATED"
  storage_root = format("abfss://%s@%s.dfs.core.windows.net/%s",
    each.value.container_name,
    each.value.storage_account,
    each.value.sub_directory
  )
}
resource "databricks_workspace_binding" "catalog_ana" {
  depends_on = [ databricks_catalog.ana ]
  for_each = { for k, v in local.catalog_workspace_bindings : k => v if v.home_workspace == var.workspace_names["ana"] }

  provider = databricks.workspace_ana
  securable_name = each.value.catalog_name
  workspace_id = each.value.workspace_id
  binding_type = each.value.binding_type
}
resource "databricks_grants" "catalog_ana" {
  depends_on = [ databricks_catalog.ana, databricks_workspace_binding.catalog_ana ]
  for_each = { for k, v in local.catalog_create : k => v if v.home_workspace == var.workspace_names["ana"] }

  provider = databricks.workspace_ana
  catalog = databricks_catalog.ana[each.key].name
  dynamic "grant" {
    for_each = each.value.privileges
    content {
      principal  = grant.key
      privileges = var.catalog_grant_templates[grant.value]
    }
  }
}


# # Data Source: Query Databricks Workspaces
# data "databricks_workspace" "this" {
#   for_each = toset(flatten([
#     for catalog_key, catalog in var.catalog : catalog.workspace
#   ]))

#   name = each.value
# }

# # # Local values: Construct workspace bindings
# locals {
#   catalog_workspace_bindings = {
#     for pair in flatten([
#       for catalog_key, catalog in var.catalog : [
#         for binding_ws in catalog.bindings : {
#           key            = "${catalog_key}_${ws}"
#           catalog_name   = catalog.name
#           workspace_name = ws
#           workspace_id   = data.databricks_workspace.this[ws].id  # Fetch workspace ID
#         }
#       ]
#     ]) :
#     pair.key => {
#       catalog_name = pair.catalog_name
#       workspace_id = pair.workspace_id
#     }
#   }
# }

# data "azurerm_databricks_workspace" "this" {
#   name                = local.databricks_workspace_name
#   resource_group_name = local.resource_group

# }

# resource "databricks_catalog_workspace_binding" "this" {
#   for_each = local.catalog_workspace_bindings

#   catalog_name   = each.value.catalog_name
#   #workspace_name = each.value.workspace_name
#   workspace_id   = data.databricks_workspace.workspace[each.value.workspace_name].id
# }

