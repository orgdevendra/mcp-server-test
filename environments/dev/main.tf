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
  subscription_id = var.SUBSCRIPTION_ID
}

module "resource_group" {
  source   = "../../modules/resource_group"
  name     = var.RESOURCE_GROUP_NAME
  location = var.LOCATION
}

module "storage_account" {
  source              = "../../modules/storage_account"
  name                = var.STORAGE_ACCOUNT_NAME
  location            = var.LOCATION
  resource_group_name = module.resource_group.name
  account_tier        = var.STORAGE_ACCOUNT_TIER
  account_replication_type = var.STORAGE_ACCOUNT_REPLICATION_TYPE
}

module "key_vault" {
  source              = "../../modules/key_vault"
  name                = var.KEY_VAULT_NAME
  location            = var.LOCATION
  resource_group_name = module.resource_group.name
  tenant_id           = var.KEY_VAULT_TENANT_ID
  sku_name            = var.KEY_VAULT_SKU_NAME
  soft_delete_retention_days = var.KEY_VAULT_SOFT_DELETE_RETENTION_DAYS
  purge_protection_enabled   = var.KEY_VAULT_PURGE_PROTECTION_ENABLED
}

module "azure_sql_database" {
  source                  = "../../modules/azure_sql_database"
  sql_server_name         = var.SQL_SERVER_NAME
  sql_database_name       = var.SQL_DATABASE_NAME
  resource_group_name     = module.resource_group.name
  location                = var.SQL_LOCATION
  administrator_login     = var.SQL_ADMINISTRATOR_LOGIN
  administrator_login_password = var.SQL_ADMINISTRATOR_LOGIN_PASSWORD
  collation               = var.SQL_COLLATION
  sku_name                = var.SQL_SKU_NAME
  max_size_gb             = var.SQL_MAX_SIZE_GB
  read_scale              = var.SQL_READ_SCALE
  zone_redundant          = var.SQL_ZONE_REDUNDANT
  tags                    = var.TAGS
}
