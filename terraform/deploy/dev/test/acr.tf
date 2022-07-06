module "acr-test" {
  source   = "../../../modules/acr"
  name     = "test"
  location = "australiaeast"
  resource_group_name = module.rg-test.name
  allowed_ip_ranges = ["122.199.1.227/32"]
  tags     = var.tags
}


output "acr" {
  sensitive = true
  value = {
    test = {
      id                  = module.acr-test.id
      name                = module.acr-test.name
      location            = module.acr-test.location
      resource_group_name = module.acr-test.resource_group_name
      login               = module.acr-test.login
      identity            = module.acr-test.identity
    }
  }
}