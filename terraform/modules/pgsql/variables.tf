variable "name" {
  description = <<-EOF
    Specifies the name of the resource.
    Changing this forces a new resource to be created.
  EOF
  type = string
}

variable "location" {
  description = <<-EOF
    The Azure region where the resource should exist.
    Changing this forces a new resource to be created.
  EOF
  type = string
}

variable "resource_group_name" {
  description = <<-EOF
    The name of the resource group in which to create the resource.
    Changing this forces a new resource to be created.
  EOF
  type = string
}

variable "postgres_version" {
  description = <<-EOF
    The version of PostgreSQL Flexible Server to use.
  EOF
  type = string
}

variable "sku_name" {
  description = <<-EOF
    The SKU Name for the PostgreSQL Flexible Server.
  EOF
  type = string
  default = "MO_Standard_E2ds_v4"
}

variable "storage_mb" {
  description = <<-EOF
    The max storage allowed for the PostgreSQL Flexible Server.
    Possible values are `{32768|65536|131072|262144|524288|1048576|2097152|4194304|8388608|16777216|33554432}`.
  EOF
  type = number
  default = 32768
}

variable "backup_retention_days" {
  description = <<-EOF
    The backup retention days for the PostgreSQL Flexible Server.
    This value can be between [7, 35].
  EOF
  type = number
  default = 7
}

variable "allowed_ip_ranges" {
  description = "Specifies IP ranges (in CIDR notation) from which access is allowed."
  type    = list(string)
  default = []
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the resource."
  type        = map
  default     = {}
}
