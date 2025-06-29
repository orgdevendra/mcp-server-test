# Deploys an Azure Key Vault using AVM best practices

provider "azurerm" {
  features {}
  subscription_id = "7485d6a3-043a-490a-b165-e09680d695bc"
  tenant_id       = "188285f7-8f1e-4c0d-a0bc-797e3e38c5b3"
}

# Get current client/tenant config for tenant_id
# This is a secure way to reference the tenant_id for the Key Vault

data "azurerm_client_config" "current" {}

# Resource Group for the Key Vault
resource "azurerm_resource_group" "keyvault_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure Key Vault resource
resource "azurerm_key_vault" "prod" {
  name                        = var.key_vault_name
  location                    = azurerm_resource_group.keyvault_rg.location
  resource_group_name         = azurerm_resource_group.keyvault_rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.key_vault_sku
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = true
  # Add additional configuration as needed (e.g., access policies, network_acls)
}
