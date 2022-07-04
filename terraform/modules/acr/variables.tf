variable "name" {
  description = <<-EOF
    The Azure region where the resource should exist.
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
    The name of the resource group in which to create the registry.
    Changing this forces a new resource to be created.
  EOF
  type = string
}


variable "sku" {
  description = <<-EOF
    The SKU name of the container registry.
    Valid options are `{Basic|Standard|Premium}`
  EOF
  type = string
  default = "Premium"
}

variable "admin_enabled" {
  description = <<-EOF
    Specifies whether the admin user is enabled.
  EOF
  type    = bool
  default = false
}

variable "public_network_access_enabled" {
  description = <<-EOF
    Whether public network access is allowed for the container registry.
  EOF
  type    = bool
  default = true
}

variable "allowed_ip_ranges" {
  description = "Specifies IP ranges (in CIDR format) from which access is allowed."
  type    = list(string)
  default = []
}

variable "allowed_subnet_ids" {
  description = "Specifies subnets from which access is allowed."
  type    = list(string)
  default = []
}

variable "untagged_retention_days" {
  description = <<-EOF
    The number of days to retain an untagged manifest after which it gets purged.
  EOF
  type    = number
  default = 7
}


variable "zone_redundancy_enabled" {
  description = <<-EOF
    Whether zone redundancy is enabled for this container registry.
    Changing this forces a new resource to be created.
  EOF
  type    = bool
  default = false
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the resource."
  type        = map
  default     = {}
}
