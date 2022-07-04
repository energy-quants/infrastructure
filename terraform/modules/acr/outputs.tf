output "id" {
  description = "The ID of the container registry."
  value       = azurerm_container_registry.acr.id
}

output "name" {
  description = "The name assigned to the container registry."
  value = azurerm_container_registry.acr.name
}

output "location" {
  description = "The Azure region where the container registry was created."
  value = azurerm_container_registry.acr.location
}

output "resource_group_name" {
  description = "The name of the resource group in which the registry was created."
  value = azurerm_container_registry.acr.location
}

output "login" {
  description = "Login details for the container registry."
  value = {
    server   = azurerm_container_registry.acr.login_server
    username = azurerm_container_registry.acr.admin_username
    password = azurerm_container_registry.acr.admin_password
  }
}

output "identity" {
  description = "The identity assigned to the container registry."
  value = azurerm_container_registry.acr.identity
}
