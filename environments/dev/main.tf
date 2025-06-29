terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "resource_group" {
  source   = "../../modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

module "storage_account" {
  source              = "../../modules/storage_account"
  name                = var.storage_account_name
  location            = var.location
  resource_group_name = module.resource_group.name
  account_tier        = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}

module "key_vault" {
  source              = "../../modules/key_vault"
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = module.resource_group.name
  tenant_id           = var.key_vault_tenant_id
  sku_name            = var.key_vault_sku_name
  soft_delete_retention_days = var.key_vault_soft_delete_retention_days
  purge_protection_enabled   = var.key_vault_purge_protection_enabled
}
