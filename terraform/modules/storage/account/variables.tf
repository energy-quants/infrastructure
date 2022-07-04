terraform {
  # https://www.terraform.io/docs/language/expressions/type-constraints.html#experimental-optional-object-type-attributes
  experiments = [module_variable_optional_attrs]
}


variable "name" {
  description = <<-EOF
    Specifies the name of the storage account.
    Changing this forces a new storage account to be created.
  EOF
  type = string
}

variable "location" {
  description = <<-EOF
    Specifies the supported Azure location where the resource exists.
    Changing this forces a new storage account to be created.
  EOF
  type = string
}

variable "resource_group_name" {
  description = <<-EOF
    The name of the resource group in which to create the storage account.
    Changing this forces a new storage account to be created.
  EOF
  type = string
}

variable "account_kind" {
  description = <<-EOF
    Specifies the kind of storage account.
    Valid options are `{BlockBlobStorage|FileStorage|StorageV2}`.
    Changing this forces a new storage account to be created.
  EOF
  type = string
}

variable "account_tier" {
  description = <<-EOF
    Defines the Tier `{Standard|Premium}` to use for this storage account.
    Changing this forces a new storage account to be created.
  EOF
  type    = string
  default = "Premium"
}

variable "account_replication_type" {
  description = <<-EOF
    Defines the type of replication to use for this storage account.
    Valid options are `{LRS|GRS|RAGRS|ZRS|GZRS|RAGZRS}`.
    Changing this forces a new storage account to be created.
  EOF
  type    = string
  default = "LRS"
}

variable "enable_hierarchical_namespace" {
  description = <<-EOF
    If true then Hierarchical Namespace  (Data Lake) will be enabled.
    Only valid for blob storage accounts.
    Changing this forces a new storage account to be created.
  EOF
  type    = bool
  default = false
}

variable "allowed_ip_addresses" {
  description = "Specifies IP addresses from which access is allowed."
  type        = list(string)
  default     = []
}

variable "allowed_subnet_ids" {
  description = "Specifies subnets from which access is allowed."
  type        = list(string)
  default     = []
}

variable "blob_properties" {
  description = "Specifies properties for blob storage."
  type = object({
    cors_rule = optional(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    }))
    versioning_enabled              = optional(bool)
    change_feed_enabled             = optional(bool)
    last_access_time_enabled        = optional(bool)
    delete_retention_days           = optional(number)  # [1, 365], default 7
    container_delete_retention_days = optional(number)  # [1, 365], default 7
  })
  default = null
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the resource."
  type        = map
  default     = {}
}
