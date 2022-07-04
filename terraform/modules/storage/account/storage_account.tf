# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "id" {
  byte_length = 6
  keepers = {
    # Anything which forces a new resource to be created should be in the keepers
    name                          = "${var.name}"
    location                      = "${var.location}"
    resource_group_name           = "${var.resource_group_name}"
    account_kind                  = "${var.account_kind}"
    account_tier                  = "${var.account_tier}"
    account_replication_type      = "${var.account_replication_type}"
    enable_hierarchical_namespace = "${var.enable_hierarchical_namespace}"
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "st" {
  name = "${local.name_prefix}stax${random_id.id.hex}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  is_hns_enabled = var.enable_hierarchical_namespace ? true : false

  dynamic "blob_properties" {
    for_each = var.blob_properties == null ? [] : [true]
    content {
      dynamic "cors_rule" {
        for_each =  var.blob_properties.cors_rule == null ? [] : [true]
        content {
          allowed_headers    = var.blob_properties.cors_rule.allowed_headers
          allowed_methods    = var.blob_properties.cors_rule.allowed_methods
          allowed_origins    = var.blob_properties.cors_rule.allowed_origins
          exposed_headers    = var.blob_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.blob_properties.cors_rule.max_age_in_seconds
        }
      }
      versioning_enabled       = var.blob_properties.versioning_enabled
      change_feed_enabled      = var.blob_properties.change_feed_enabled
      last_access_time_enabled = var.blob_properties.last_access_time_enabled
      dynamic "delete_retention_policy" {
        for_each =  var.blob_properties.delete_retention_days == null ? [] : [true]
        content {
          days = var.blob_properties.delete_retention_days
        }
      }
      dynamic "container_delete_retention_policy" {
        for_each =  var.blob_properties.container_delete_retention_days == null ? [] : [true]
        content {
          days = var.blob_properties.container_delete_retention_days
        }
      }
    }
  }

  network_rules {
    default_action             = "Deny"
    bypass                     = ["Logging", "Metrics", "AzureServices"]
    ip_rules                   = var.allowed_ip_addresses
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  tags = local.tags
  lifecycle {
    create_before_destroy = true
  }
}