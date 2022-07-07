# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
resource "random_password" "pwd" {
  length  = 16
  special = true
}


# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server
resource "azurerm_postgresql_flexible_server" "svr" {
  name                   ="${local.name_prefix}-pgsql-svr-${random_id.id.hex}"
  location               = var.location
  resource_group_name    = var.resource_group_name
  create_mode            = "Default"
  version                = var.postgres_version  # 14
  # https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-compute-storage
  sku_name               = var.sku_name  # "MO_Standard_E2ds_v4"
  storage_mb             = var.storage_mb  # 65536
  backup_retention_days  = 7

  administrator_login    = "sysop"
  administrator_password = random_password.pwd.result

  tags = local.tags
  lifecycle {
    create_before_destroy = true
  }
}
