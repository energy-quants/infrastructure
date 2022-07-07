output "id" {
  description = "The ID of the key vault."
  value       = azurerm_postgresql_flexible_server.svr.id
}

output "name" {
  description = "The name assigned to the key vault."
  value = azurerm_postgresql_flexible_server.svr.name
}

output "location" {
  description = "The Azure region where the key vault was created."
  value = azurerm_postgresql_flexible_server.svr.location
}

output "resource_group_name" {
  description = "The name of the resource group in which the registry was created."
  value = azurerm_postgresql_flexible_server.svr.location
}
