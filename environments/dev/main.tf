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
}

module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = ">= 0.1.0"
  name     = var.resource_group_name
  location = var.location
}

module "storage_account" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = ">= 0.1.0"
  name                = var.storage_account_name
  location            = var.location
  resource_group_name = module.resource_group.name
  account_tier        = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}

module "key_vault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = ">= 0.1.0"
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = module.resource_group.name
  tenant_id           = var.key_vault_tenant_id
  sku_name            = var.key_vault_sku_name
  soft_delete_retention_days = var.key_vault_soft_delete_retention_days
  purge_protection_enabled   = var.key_vault_purge_protection_enabled
}

module "app_service_plan" {
  source  = "Azure/avm-res-web-serverfarm/azurerm"
  version = ">= 0.1.0"
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = module.resource_group.name
  os_type             = var.app_service_plan_os_type
  sku_name            = var.app_service_plan_sku_name
}

module "web_app" {
  source  = "Azure/avm-res-web-site/azurerm"
  version = ">= 0.1.0"
  name                = var.web_app_name
  location            = var.location
  resource_group_name = module.resource_group.name
  kind                = var.web_app_kind
  os_type             = var.web_app_os_type
  service_plan_resource_id = module.app_service_plan.resource_id
}
