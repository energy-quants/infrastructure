output "id" {
  description = "The ID of the key vault."
  value       = azurerm_key_vault.akv.id
}

output "name" {
  description = "The name assigned to the key vault."
  value = azurerm_key_vault.akv.name
}

output "location" {
  description = "The Azure region where the key vault was created."
  value = azurerm_key_vault.akv.location
}

output "resource_group_name" {
  description = "The name of the resource group in which the key vault was created."
  value = azurerm_key_vault.akv.location
}

output "vault_uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value = azurerm_key_vault.akv.vault_uri
}
