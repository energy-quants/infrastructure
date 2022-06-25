module "storage_account" {
  source = "../account"
  name                          = var.name
  subscription_name             = var.subscription_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  account_kind                  = "BlockBlobStorage"
  account_tier                  = "Premium"
  account_replication_type      = var.account_replication_type
  enable_hierarchical_namespace = var.enable_hierarchical_namespace
  allowed_ip_addresses          = var.allowed_ip_addresses
  allowed_subnet_ids            = var.allowed_subnet_ids
  blob_properties               = var.blob_properties
  tags                          = var.tags
}


# FIXME: https://github.com/hashicorp/terraform-provider-azurerm/issues/2977
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment
resource "azurerm_resource_group_template_deployment" "container" {
  depends_on          = [
    module.storage_account
  ]
  for_each            = toset(var.containers)
  name                ="${module.storage_account.name}-${each.key}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"
  parameters_content  = jsonencode({
    storage_account_name = {
      value = module.storage_account.name
    }
    container_name = {
      value = each.key
    }
  })
  template_content = file("${path.module}/container.json")
}