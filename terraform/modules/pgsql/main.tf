terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.12.0"
    }
  }
}


locals{
  location_code = {
    australiaeast = "ae",
  }
  name_prefix = "eq${local.location_code[var.location]}"
  tags = merge(var.tags, {"name" = "${var.name}"})
}
