variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account."
  type        = string
}

variable "storage_account_tier" {
  description = "Storage account tier."
  type        = string
}

variable "storage_account_replication_type" {
  description = "Storage account replication type."
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Key Vault."
  type        = string
}

variable "key_vault_tenant_id" {
  description = "Tenant ID for the Key Vault."
  type        = string
}

variable "key_vault_sku_name" {
  description = "SKU name for the Key Vault."
  type        = string
}

variable "key_vault_soft_delete_retention_days" {
  description = "Soft delete retention days for Key Vault."
  type        = number
}

variable "key_vault_purge_protection_enabled" {
  description = "Enable purge protection for Key Vault."
  type        = bool
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan."
  type        = string
}

variable "app_service_plan_os_type" {
  description = "OS type for the App Service Plan."
  type        = string
}

variable "app_service_plan_sku_name" {
  description = "SKU name for the App Service Plan."
  type        = string
}

variable "web_app_name" {
  description = "Name of the Web App."
  type        = string
}

variable "web_app_kind" {
  description = "The kind of the Web App (e.g., app, functionapp)."
  type        = string
}

variable "web_app_os_type" {
  description = "The OS type for the Web App (e.g., Linux, Windows)."
  type        = string
}
