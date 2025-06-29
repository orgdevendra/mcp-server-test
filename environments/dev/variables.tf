variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region."
  type        = string
  default     = "eastus"
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "storage_account_tier" {
  description = "The tier of the storage account."
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "The replication type of the storage account."
  type        = string
  default     = "LRS"
}

variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "key_vault_tenant_id" {
  description = "The Azure AD tenant ID for the Key Vault."
  type        = string
}

variable "key_vault_sku_name" {
  description = "The SKU name for the Key Vault."
  type        = string
  default     = "standard"
}

variable "key_vault_soft_delete_retention_days" {
  description = "Soft delete retention days for Key Vault."
  type        = number
  default     = 7
}

variable "key_vault_purge_protection_enabled" {
  description = "Enable purge protection for Key Vault."
  type        = bool
  default     = true
}

variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
}
