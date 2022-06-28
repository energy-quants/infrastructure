terraform {
  # https://www.terraform.io/docs/language/expressions/type-constraints.html#experimental-optional-object-type-attributes
  experiments = [module_variable_optional_attrs]
}

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

# https://azureprice.net/?region=australiaeast
variable "size" {
  description = "The SKU which should be used for the Virtual Machine."
  type = string
  default = "Standard_B2ms"
}

variable "admin_username" {
  description = <<-EOF
    The username of the local administrator used for the Virtual Machine.
    Changing this forces a new resource to be created.
  EOF
  type = string
  default = "sysop"
}

variable "source_image_id" {
  description = <<-EOF
    The ID of the Image which this Virtual Machine should be created from.
    Mutually exclusive with `source_image_reference`.
    Changing this forces a new resource to be created.
  EOF
  type = string
  default = null
}

# az vm image list --all --publisher Canonical | jq '[.[] | select(.sku=="20_04-lts")]| max_by(.version)'
variable "source_image_reference" {
  description = <<-EOF
    Specifies the platform image to use.
    Mutually exclusive with `source_image_id`.
    Changing this forces a new resource to be created.
  EOF
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
     publisher = "Canonical"
     offer     = "0001-com-ubuntu-server-focal"
     sku       = "20_04-lts-gen2"
     version   = "latest"
  }
}

variable "subnet_id" {
  description = "The ID of the subnet where the NIC should be created."
  type = string
}

variable "private_ip_address" {
  description = "The private IP address of the VM. If null, one will be allocated dynmically."
  type = string
  default = null
}

variable "enable_accelerated_networking" {
  description = <<-EOF
    If true, enables acceleraated networking on the NIC.
    Only supported on certain VM sizes.
  EOF
  type = bool
  default = false
}

variable "os_disk" {
  description = "Specifies properties for the OS disk."
  type = object({
    caching                   = string  # {None|ReadOnly|ReadWrite}
    storage_account_type      = string  # {Standard_LRS|StandardSSD_LRS|Premium_LRS|StandardSSD_ZRS|Premium_ZRS}
    write_accelerator_enabled = bool  # Requires caching is None and account type is Premium_LRS
    ephemeral_disk            = optional(string)  # {CacheDisk|ResourceDisk}
  })
  default = {
    caching                   = "None"
    storage_account_type      = "Premium_LRS"
    write_accelerator_enabled = true
    ephemeral_disk       = null  # null means disk is not ephemeral
  }
}

variable "encryption_at_host_enabled" {
  description = "If true all disks  to the VM are encrypted at the host."
  type = bool
  default = false
}

variable "secure_boot_enabled" {
  description = <<-EOF
    Specifies whether secure boot should be enabled on the virtual machine.
    Changing this forces a new resource to be created.
  EOF
  type = bool
  default = false
}

variable "patch_mode" {
  description = <<-EOF
    Specifies the mode of in-guest patching to this Linux Virtual Machine.
    Possible values are {AutomaticByPlatform|ImageDefault}
  EOF
  type = string
  default = "ImageDefault"
}

variable "license_type" {
  description = <<-EOF
    Specifies the BYOL Type for this Virtual Machine.
    Possible values are `{RHEL_BYOS|SLES_BYOS}`
  EOF
  type = string
  default = null
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the resource."
  type        = map
  default     = {}
}