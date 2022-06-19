# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "id" {
  count = var.append_uid ? 1 : 0
  byte_length = 3
  keepers = {
    # Anything which forces a new resource to be created should be in the keepers
    name     = "${var.name}"
    location = "${var.location}"
  }
}


# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "rg" {
  name     = (
    var.append_uid
    ? "${var.name}-${random_id.id[0].hex}"
    : "${var.name}"
  )
  location = var.location
  tags     = var.tags
}
