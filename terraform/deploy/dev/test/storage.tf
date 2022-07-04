module "st-event-queue" {
  source   = "../../../modules/storage/account"
  name     = "test-event-queue"
  location = "australiaeast"
  resource_group_name = module.rg-test.name
  account_kind = "StorageV2"
  account_tier = "Standard"
  tags     = var.tags
}

module "st-event-queue" {
  source   = "../../../modules/storage/account"
  name     = "test-storage-event"
  location = "australiaeast"
  resource_group_name = module.rg-test.name
  account_kind = "BlockBlobStorage"
  account_tier = "Premium"
  tags     = var.tags
}