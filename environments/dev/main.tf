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
  resource = var.resource_group_resource
}

module "storage_account" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = ">= 0.1.0"
  resource = merge(var.storage_account_resource, {
    resource_group_name = module.resource_group.resource.name
  })
}

module "key_vault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = ">= 0.1.0"
  resource = merge(var.key_vault_resource, {
    resource_group_name = module.resource_group.resource.name
  })
}

module "app_service_plan" {
  source  = "Azure/avm-res-web-serverfarm/azurerm"
  version = ">= 0.1.0"
  resource = merge(var.app_service_plan_resource, {
    resource_group_name = module.resource_group.resource.name
  })
}

module "web_app" {
  source  = "Azure/avm-res-web-site/azurerm"
  version = ">= 0.1.0"
  resource = merge(var.web_app_resource, {
    resource_group_name = module.resource_group.resource.name
  })
}
