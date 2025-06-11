environment = "non-prod"
databricks_ncc = {
  non-prod = "aue-dbac-retail-ncc-np01"
}
databricks_ncc_name = "ncc-retail"
network_rg = "aue-rg-network-np01"
storage_account = {
  "rdcd01" = {
    name             = "auestorrdcdtw33"
    rg_name          = "aue-rg-dataplatform-d01"
    kind             = "StorageV2"
    tier             = "Standard"
    replication_type = "GRS"
    hns_enabled      = true
    public_access    = true
    containers       = ["mdp-lakehouse", "source", "integrated", "curated", "x-raw"]
    allowed_ips      = []
    tags = {
      Environment = "dev"
      CostCenter  = "TBD"
      Owner       = "TBD"
    }
  }
  "rdct01" = {
    name             = "auestorrdcttw33"
    rg_name          = "aue-rg-dataplatform-t01"
    kind             = "StorageV2"
    tier             = "Standard"
    replication_type = "GRS"
    hns_enabled      = true
    public_access    = true
    containers       = ["mdp-lakehouse", "source", "integrated", "curated", "x-raw"]
    allowed_ips      = []
    tags = {
      Environment = "test"
      CostCenter  = "TBD"
      Owner       = "TBD"
    }
  }
}
