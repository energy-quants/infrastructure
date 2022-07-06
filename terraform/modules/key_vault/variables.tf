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
    The name of the resource group in which to create the resource.
    Changing this forces a new resource to be created.
  EOF
  type = string
}

variable "sku" {
  description = <<-EOF
    The SKU name of the key vault.
    Valid options are `{standard|premium}`
  EOF
  type = string
  default = "premium"
}

variable "soft_delete_retention_days" {
  description = <<-EOF
    The number of days that items should be retained for once soft-deleted.
    This value can be between [7, 90].
    Note: This field can only be configured one time and cannot be updated!
  EOF
  type = number
  default = 7
}

variable "contact" {
  description = <<-EOF
    Email addresses of who to contact regarding certificate expiry.
    Note: Setting this field requires `managecontacts` certificate permission.
  EOF
  type = list(string)
  default = []
}

variable "purge_protection_enabled" {
  description = <<-EOF
    Is purge protection enabled?
    Once purge protection has been Enabled it's not possible to disable it!
  EOF
  type = bool
  default = false
}

variable "enabled_for_deployment" {
  description = <<-EOF
    Boolean flag to specify whether Azure Virtual Machines are permitted
    to retrieve certificates stored as secrets from the key vault
  EOF
  type = bool
  default = false
}

variable "enabled_for_disk_encryption" {
  description = <<-EOF
    Boolean flag to specify whether Azure Disk Encryption is permitted
    to retrieve secrets from the vault and unwrap keys.
  EOF
  type = bool
  default = false
}

variable "enabled_for_template_deployment" {
  description = <<-EOF
  Boolean flag to specify whether Azure Resource Manager is permitted
  to retrieve secrets from the key vault.
  EOF
  type = bool
  default = false
}

variable "allowed_ip_addresses" {
  description = "Specifies IP addresses from which access is allowed."
  type    = list(string)
  default = []
}

variable "allowed_subnet_ids" {
  description = "Specifies subnets from which access is allowed."
  type    = list(string)
  default = []
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the resource."
  type        = map
  default     = {}
}
