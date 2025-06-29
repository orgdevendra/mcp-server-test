# Deploys an Azure Key Vault using AVM best practices

provider "azurerm" {
  features {}
  subscription_id = "7485d6a3-043a-490a-b165-e09680d695bc"
  tenant_id       = "188285f7-8f1e-4c0d-a0bc-797e3e38c5b3"
}

# Get current client/tenant config for tenant_id
# This is a secure way to reference the tenant_id for the Key Vault

data "azurerm_client_config" "current" {}

# Azure Key Vault resource
resource "azurerm_key_vault" "prod" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.key_vault_sku
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = true
  # Add additional configuration as needed (e.g., access policies, network_acls)
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestorage${random_integer.suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true # Enable Hierarchical Namespace (Data Lake Storage Gen2)
}

resource "azurerm_storage_container" "rows" {
  name                  = "rows"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "rows" {
  name               = azurerm_storage_container.rows.name
  storage_account_id = azurerm_storage_account.example.id
}

resource "azurerm_storage_data_lake_gen2_path" "raw" {
  path               = "RAW"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.rows.name
  storage_account_id = azurerm_storage_account.example.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "silver" {
  path               = "SILVER"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.rows.name
  storage_account_id = azurerm_storage_account.example.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "gold" {
  path               = "GOLD"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.rows.name
  storage_account_id = azurerm_storage_account.example.id
  resource           = "directory"
}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}

# resource "azurerm_resource_group" "keyvault_rg" {
#   name     = var.resource_group_name
#   location = var.location
# }
