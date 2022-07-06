# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "id" {
  byte_length = 3
  keepers = {
    name                    = "${var.name}"
    location                = "${var.location}"
    resource_group_name     = "${var.resource_group_name}"
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
resource "azurerm_key_vault" "akv" {
  name                            ="${local.name_prefix}-akv-${random_id.id.hex}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  sku_name                        = var.sku
  tenant_id                       = data.azurerm_subscription.current.tenant_id
  soft_delete_retention_days      = var.soft_delete_retention_days
  enable_rbac_authorization       = true
  purge_protection_enabled        = var.purge_protection_enabled
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  dynamic "contact" {
    for_each = var.contact
    content {
      email = contact.value
    }
  }

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = var.allowed_ip_addresses
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  tags = local.tags
  lifecycle {
    create_before_destroy = true
  }
}
