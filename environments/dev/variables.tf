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

variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL Database."
  type        = string
}

variable "administrator_login" {
  description = "The administrator login name for the SQL Server."
  type        = string
}

variable "administrator_login_password" {
  description = "The administrator login password for the SQL Server."
  type        = string
  sensitive   = true
}

variable "sql_collation" {
  description = "The collation for the SQL Database."
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "sql_sku_name" {
  description = "The SKU name for the SQL Database."
  type        = string
  default     = "S0"
}

variable "sql_max_size_gb" {
  description = "The max size of the SQL Database in GB."
  type        = number
  default     = 5
}

variable "sql_read_scale" {
  description = "Enable read scale-out on the SQL Database."
  type        = bool
  default     = false
}

variable "sql_zone_redundant" {
  description = "Whether the SQL Database is zone redundant."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the SQL resources."
  type        = map(string)
  default     = {}
}
