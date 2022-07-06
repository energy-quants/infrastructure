module "akv-test" {
  source   = "../../../modules/key_vault"
  name     = "test"
  location = "australiaeast"
  resource_group_name = module.rg-test.name
  allowed_ip_addresses = ["122.199.1.227"]
  tags     = var.tags
}


output "akv" {
  value = {
    test = {
      id                  = module.akv-test.id
      name                = module.akv-test.name
      location            = module.akv-test.location
      resource_group_name = module.akv-test.resource_group_name
      vault_uri           = module.akv-test.vault_uri
    }
  }
}
