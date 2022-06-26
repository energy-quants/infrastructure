terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.10.0"
    }
  }
}


locals{
  name_prefix = "eq"
  tags = merge(var.tags, {"Name" = "var.name"})
}
