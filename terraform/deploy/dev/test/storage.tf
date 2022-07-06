module "st-event_queue" {
  source   = "../../../modules/storage/account"
  name     = "test-event-queue"
  location = "australiaeast"
  resource_group_name = module.rg-test.name
  account_kind = "StorageV2"
  account_tier = "Standard"
  allowed_ip_addresses = ["122.199.1.227"]
  tags     = var.tags
}

module "st-storage_event" {
  source   = "../../../modules/storage/account"
  name     = "test-storage-event"
  location = "australiaeast"
  resource_group_name = module.rg-test.name
  account_kind = "BlockBlobStorage"
  account_tier = "Premium"
  allowed_ip_addresses = ["122.199.1.227"]
  tags     = var.tags
}