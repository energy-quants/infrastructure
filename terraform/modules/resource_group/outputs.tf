output "id" {
  description = "The ID of the Resource Group."
  value       = azurerm_resource_group.rg.id
}

output "name" {
  description = "The name assigned to the resource group."
  value = azurerm_resource_group.rg.name
}

output "location" {
  description = "The Azure region where the resource group was created."
  value = azurerm_resource_group.rg.location
}
