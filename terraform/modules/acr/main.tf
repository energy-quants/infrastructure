terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.12.0"
    }
  }
}


locals{
  name_prefix = "eq"
  tags = merge(var.tags, {"name" = "var.name"})
}
