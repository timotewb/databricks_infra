locals {
  workspace_permissions = {
    for pair in flatten([
      for workspace_key, workspace in var.workspaces : [
        for permission_key, permission in workspace.permissions : {
          key            = "${workspace_key}_${permission_key}"
          group_name     = permission_key
          permission     = permission
          ws_key         = workspace_key
        }
      ]
    ]) :
    pair.key => {
      group_name = pair.group_name
      permission = pair.access
      ws_key     = pair.ws_key
    }
  }
}

output "workspace_access" {
    value = local.workspace_permissions
}