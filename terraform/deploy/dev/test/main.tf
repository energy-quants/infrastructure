module "rg-test" {
  source   = "../../../modules/resource_group"
  location = "australiaeast"
  name     = "test"
  tags     = var.tags
}
