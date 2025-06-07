# databricks_infra

## Getting Started
After cloning this repository check the below dependencies then follow the steps below.

### Dependencies
- terraform cli installed
- azure cli installed
- shared resources resource group is created with a storage account and container available to write terraform state to.
- service principal created with appropriate subscription permissions (Contributor, Role Based Access Control Administrator) and sared storage account permissions (Storage Blob Contributor)
1. change directory into module you want to run e.g. from repo root 
```bash 
cd main/network
```
2. create files filling in the values before running the `echo` command.
```bash 
echo '
databricks_account_id   = ""
subscription_id         = ""
client_id               = ""
client_secret           = ""
tenant_id               = ""' >> .tfvars
```
```bash 
echo '
terraform {
  backend "azurerm" {
    resource_group_name   = ""
    storage_account_name  = ""
    container_name        = ""
    key                   = ""
    subscription_id       = ""
    client_id             = ""
    client_secret         = ""
    tenant_id             = ""
  }
}' >> backend.tf
```
3. use the azure cli to login
```bash 
az login --service-principal --username <value> --password <value> --tenant <value>
```

4. run the below terraform commands one at a time (or as needed)
```bash 
terraform init
```
```bash 
terraform plan -var-file=<(cat .tfvars ../config/non-prod/network-non-prod.tfvars) -out=tf.plan
```
```bash 
terraform apply tf.plan
```
```bash 
terraform destroy -var-file=<(cat .tfvars ../config/non-prod/network-non-prod.tfvars)
```