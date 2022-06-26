# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "vm" {
  byte_length = 3
  keepers = {
    name     = "${var.name}"
    location = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    disk_storage = "${var.os_disk.storage_account_type}"
    ephemeral_disk = "${var.os_disk.ephemeral_disk}"
    admin_username = "${var.admin_username}"
    secure_boot_enabled = "${var.secure_boot_enabled}"
    source_image_id = "${var.source_image_id}"
    source_image_reference = "${var.source_image_reference}"
  }
}


# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id
resource "random_id" "disk" {
  byte_length = 3
  keepers = {
    vm_hash = random_id.vm.hex
  }
}


# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
resource "random_password" "admin" {
  length  = 16
  special = true
}


# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "${local.name_prefix}-${random_id.vm.hex}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.size
  admin_username                  = var.admin_username
  admin_password                  = random_password.admin.result
  disable_password_authentication = false

  source_image_id = var.source_image_id
  dynamic source_image_reference {
    for_each = var.source_image_id == null ? var.source_image_reference[*] : []
    content {
      publisher = var.source_image_reference.publisher
      offer     = var.source_image_reference.offer
      sku       = var.source_image_reference.sku
      version   = var.source_image_reference.version
    }
  }

  os_disk {
    name                 = "${local.name_prefix}-${random_id.vm.hex}-${random_id.disk.hex}"
    storage_account_type = var.os_disk.storage_account_type
    caching              = var.os_disk.caching

    # Requires caching is None and account type is Premium_LRS
    write_accelerator_enabled = var.os_disk.write_accelerator_enabled

    dynamic diff_disk_settings {
      for_each = var.os_disk.ephemeral_disk[*]
      content {
        option    = "Local"
        placement = each.key
      }
    }
  }

  encryption_at_host_enabled = var.encryption_at_host_enabled

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  secure_boot_enabled = var.secure_boot_enabled
  boot_diagnostics {
    storage_account_uri = null
  }

  allow_extension_operations = true
  patch_mode                 = var.patch_mode
  license_type               = var.license_type

  tags = local.tags
  lifecycle {
    create_before_destroy = true
  }
}
