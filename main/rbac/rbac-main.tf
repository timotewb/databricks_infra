# File: non-prod/rbac/rbac-main.tf
#
# This is for controlling RBAC rights for resources

#----------------------------------------
# STORAGE ACCOUNTS
#----------------------------------------

# Resolve identities
data "azuread_user" "user" {
  for_each            = { for k, v in var.storage_rbac : k => v if v.type == "user" }
  user_principal_name = each.key
}

data "azuread_group" "group" {
  for_each     = { for k, v in var.storage_rbac : k => v if v.type == "group" }
  display_name = each.key
}

# Flatten and loop
locals {
  rbac_flat = flatten([
    for identity, meta in var.storage_rbac : [
      for target in meta.targets : {
        identity       = identity
        type           = meta.type
        storage_account = target.storage_account
        resource_group  = target.resource_group
        rbac_role       = target.rbac_role
      }
    ]
  ])

  unique_storage_refs = distinct([
    for entry in local.rbac_flat : {
      storage_account = entry.storage_account
      resource_group  = entry.resource_group
    }
  ])
}

# Storage Account lookups
data "azurerm_storage_account" "target" {
  for_each = {
    for ref in local.unique_storage_refs :
    "${ref.storage_account}-${ref.resource_group}" => ref
  }

  name                = each.value.storage_account
  resource_group_name = each.value.resource_group
}

# Role assignments
resource "azurerm_role_assignment" "assign" {
  for_each = {
    for entry in local.rbac_flat :
    "${entry.identity}-${entry.storage_account}-${entry.rbac_role}" => entry
  }

  scope                = data.azurerm_storage_account.target["${each.value.storage_account}-${each.value.resource_group}"].id
  role_definition_name = each.value.rbac_role

  principal_id = (
    each.value.type == "user" ?
    data.azuread_user.user[each.value.identity].object_id :
    data.azuread_group.group[each.value.identity].object_id
  )
}

