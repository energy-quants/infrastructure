# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "id" {
  byte_length = 3
  keepers = {
    name                   = "${var.name}"
    location               = "${var.location}"
    resource_group_name    = "${var.resource_group_name}"
  }
}


# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "vnet" {
  name                = "${local.name_prefix}-vnet-${random_id.id.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = local.tags
}
