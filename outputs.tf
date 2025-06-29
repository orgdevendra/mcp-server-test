# Outputs for Azure Key Vault deployment

output "key_vault_id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.prod.id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault."
  value       = azurerm_key_vault.prod.vault_uri
}

output "resource_group_id" {
  description = "The ID of the resource group."
  value       = module.resource_group.resource_id
}
