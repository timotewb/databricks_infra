environment = "non-prod"

databricks_ncc_name = "ncc-retail"
workspaces = {
  "dev-retail-data-core" = {
    name          = "dev-retail-data-core"
    rg_name       = "aue-rg-databricks-d01"
    managed_rg    = "aue-rg-databricks-retail-data-core-d01"
    public_access = false
    encryption    = true
    sku           = "premium"
    admin_group   = "RDS-Admin"
  }
  "test-retail-data-core" = {
    name          = "test-retail-data-core"
    rg_name       = "aue-rg-databricks-t01"
    managed_rg    = "aue-rg-databricks-retail-data-core-t01"
    public_access = false
    encryption    = true
    sku           = "premium"
    admin_group   = "RDS-Admin"
  }
}