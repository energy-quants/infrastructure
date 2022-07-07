# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "fw" {
  for_each = toset(var.allowed_ip_ranges)
  byte_length = 3
  keepers = {
    name                    = "${var.name}"
    location                = "${var.location}"
    resource_group_name     = "${var.resource_group_name}"
  }
}


# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule
resource "azurerm_postgresql_flexible_server_firewall_rule" "firewall_rule" {
  for_each = toset(var.allowed_ip_ranges)
  name             = "${local.name}-FW-RULE-${random_id.fw["${each.value}"].hex}"
  server_id        = azurerm_postgresql_flexible_server.svr.id
  start_ip_address = cidrhost(each.value, 0)
  end_ip_address   = cidrhost(each.value, -1)
}
