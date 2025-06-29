# Variables for Azure Key Vault deployment
variable "location" {
  description = "The Azure region to deploy resources into."
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "avm-prod-rg"
}

variable "key_vault_name" {
  description = "The name of the Azure Key Vault."
  type        = string
  default     = "avm-prod-keyvault"
}

variable "key_vault_sku" {
  description = "The SKU for the Key Vault."
  type        = string
  default     = "standard"
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain soft deleted items."
  type        = number
  default     = 90
}
