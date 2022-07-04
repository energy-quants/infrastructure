# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "id" {
  byte_length = 3
  keepers = {
    name                    = "${var.name}"
    location                = "${var.location}"
    resource_group_name     = "${var.resource_group_name}"
    zone_redundancy_enabled = "${var.zone_redundancy_enabled}"
  }
}


# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
resource "azurerm_container_registry" "acr" {
  name                =  "${local.name_prefix}acr${random_id.id.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  zone_redundancy_enabled = var.zone_redundancy_enabled

  identity {
    type = "SystemAssigned"
  }

  retention_policy {
    enabled = var.untagged_retention_days == null ? false : true
    days    = var.untagged_retention_days
  }

  network_rule_set {
    default_action = "Deny"
    ip_rule = [
      for ip_range in var.allowed_ip_ranges:
      {
        action   = "Allow",
        ip_range = ip_range,
      }
    ]
    virtual_network = [
      for subnet_id in var.allowed_subnet_ids:
      {
        action    = "Allow",
        subnet_id = subnet_id,
      }
    ]
  }

  tags = local.tags
  lifecycle {
    create_before_destroy = true
  }
}
