environment = "non-prod"

databricks_ncc_name = "swuce-np-ac"
workspaces = {
  "swuce-np-dbrws" = {
    name          = "swuce-np-dbrws"
    rg_name       = "workspace-rg" # TODO: change to workspace-np-rg
    managed_rg    = "workspace-mrg"
    public_access = false
    encryption    = true
    sku           = "premium"
    permissions = {
      "TWB-Admin" = "ADMIN"
      "TWB-Data-Engineer" = "USER"
    }
  }
}