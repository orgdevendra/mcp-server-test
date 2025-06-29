# Variables for Azure Key Vault deployment
# NOTE: The resource group 'rg-avm-290625' must be imported into Terraform state before apply.
# This is handled in the GitHub Actions workflow. Do not attempt to create it directly.
variable "location" {
  description = "The Azure region to deploy resources into."
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create resources."
  type        = string
  default     = "rg-avm-290625"
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
