# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "nic" {
  byte_length = 3
  keepers = {
    vm_hash = random_id.vm.hex
  }
}


# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
resource "azurerm_network_interface" "nic" {
  name = "${local.name_prefix}-vm-${random_id.vm.hex}-nic-${random_id.nic.hex}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  enable_accelerated_networking = var.enable_accelerated_networking

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address == null ? "Dynamic" : "Static"
    private_ip_address            = var.private_ip_address
  }

  tags = local.tags
  lifecycle {
    create_before_destroy = true
  }
}