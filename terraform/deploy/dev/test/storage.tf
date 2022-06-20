module "st-tfstate" {
  source   = "../../../modules/storage/account"
  name     = "eqtfstate"
  location = "australiaeast"
  resource_group_name = module.rg-test.name
  account_kind = "BlockBlobStorage"
  enable_hierarchical_namespace = false

  blob_properties = {
    versioning_enabled              = true
    delete_retention_days           = 7
    container_delete_retention_days = 7
  }

  tags     = var.tags
}
