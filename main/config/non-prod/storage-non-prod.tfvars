environment = "non-prod"
databricks_ncc = {
  non-prod = "swuce-np-ac"
}
databricks_ncc_name = "swuce-np-ac"
network_rg = "network-np-rg"
storage_account = {
  "swuce" = {
    name             = "swuce0sa"
    rg_name          = "storage-rg" #TODO: Update to -np-
    kind             = "StorageV2"
    tier             = "Standard"
    replication_type = "GRS"
    hns_enabled      = true
    public_access    = true
    containers       = ["swuce-source", "swuce-integrated", "swuce-curated", "swuce-x-raw"]
    allowed_ips      = []
    tags = {
      Environment = "dev"
      CostCenter  = "TBD"
      Owner       = "TBD"
    }
  }
}