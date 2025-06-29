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
  source  = "Azure/avm-res-group/azurerm"
  version = ">= 0.1.0"
  name     = var.resource_group_name
  location = var.location
}

module "storage_account" {
  source  = "Azure/avm-res-storageaccount/azurerm"
  version = ">= 0.1.0"
  name                = var.storage_account_name
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  account_tier        = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}

module "key_vault" {
  source  = "Azure/avm-res-keyvault/azurerm"
  version = ">= 0.1.0"
  name                = var.key_vault_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tenant_id           = var.tenant_id
  sku_name            = var.key_vault_sku
  soft_delete_retention_days = var.key_vault_soft_delete_retention_days
  purge_protection_enabled   = var.key_vault_purge_protection_enabled
}

module "app_service_plan" {
  source  = "Azure/avm-res-appserviceplan/azurerm"
  version = ">= 0.1.0"
  name                = var.app_service_plan_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  os_type             = var.app_service_plan_os_type
  sku_name            = var.app_service_plan_sku
}

module "web_app" {
  source  = "Azure/avm-res-webapp/azurerm"
  version = ">= 0.1.0"
  name                = var.web_app_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  service_plan_id     = module.app_service_plan.id
}
