locals {
  real_environments = var.environment == "prod" ? ["prod"] : ["dev", "test"]
}

resource "databricks_catalog" "this" {
  for_each = var.catalog

  name    = each.value.name
  comment = each.value.comment

  storage_root = "abfss://${replace(each.value.name, "${split("_", each.value.name)[0]}_", "")}@${each.value.storage_account}.dfs.core.windows.net/${replace(each.value.name, "${split("_", each.value.name)[0]}_", "")}"
}


resource "databricks_grants" "catalog" {
  for_each = var.catalog

  catalog = databricks_catalog.this[each.key].name

  dynamic "grant" {
    for_each = each.value.privileges
    content {
      principal  = grant.key
      privileges = grant.value
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

# # Local values: Construct workspace bindings
# locals {
#   catalog_workspace_bindings = {
#     for pair in flatten([
#       for catalog_key, catalog in var.catalog : [
#         for ws in catalog.workspace : {
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

