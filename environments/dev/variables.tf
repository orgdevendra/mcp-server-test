variable "RESOURCE_GROUP_NAME" {
  description = "The name of the resource group."
  type        = string
}

variable "LOCATION" {
  description = "The Azure region."
  type        = string
  default     = "eastus"
}

variable "STORAGE_ACCOUNT_NAME" {
  description = "The name of the storage account."
  type        = string
}

variable "STORAGE_ACCOUNT_TIER" {
  description = "The tier of the storage account."
  type        = string
  default     = "Standard"
}

variable "STORAGE_ACCOUNT_REPLICATION_TYPE" {
  description = "The replication type of the storage account."
  type        = string
  default     = "LRS"
}

variable "KEY_VAULT_NAME" {
  description = "The name of the Key Vault."
  type        = string
}

variable "KEY_VAULT_TENANT_ID" {
  description = "The Azure AD tenant ID for the Key Vault."
  type        = string
}

variable "KEY_VAULT_SKU_NAME" {
  description = "The SKU name for the Key Vault."
  type        = string
  default     = "standard"
}

variable "KEY_VAULT_SOFT_DELETE_RETENTION_DAYS" {
  description = "Soft delete retention days for Key Vault."
  type        = number
  default     = 7
}

variable "KEY_VAULT_PURGE_PROTECTION_ENABLED" {
  description = "Enable purge protection for Key Vault."
  type        = bool
  default     = true
}

variable "SUBSCRIPTION_ID" {
  description = "The Azure subscription ID."
  type        = string
}

variable "SQL_SERVER_NAME" {
  description = "The name of the SQL Server."
  type        = string
}

variable "SQL_DATABASE_NAME" {
  description = "The name of the SQL Database."
  type        = string
}

variable "SQL_ADMINISTRATOR_LOGIN" {
  description = "The administrator login name for the SQL Server."
  type        = string
}

variable "SQL_ADMINISTRATOR_LOGIN_PASSWORD" {
  description = "The administrator login password for the SQL Server."
  type        = string
  sensitive   = true
}

variable "SQL_COLLATION" {
  description = "The collation for the SQL Database."
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "SQL_SKU_NAME" {
  description = "The SKU name for the SQL Database."
  type        = string
  default     = "S0"
}

variable "SQL_MAX_SIZE_GB" {
  description = "The max size of the SQL Database in GB."
  type        = number
  default     = 5
}

variable "SQL_READ_SCALE" {
  description = "Enable read scale-out on the SQL Database."
  type        = bool
  default     = false
}

variable "SQL_ZONE_REDUNDANT" {
  description = "Whether the SQL Database is zone redundant."
  type        = bool
  default     = false
}

variable "SQL_LOCATION" {
  description = "The Azure region for SQL resources."
  type        = string
  default     = "uksouth"
}

variable "TAGS" {
  description = "A map of tags to assign to the SQL resources."
  type        = map(string)
  default     = {}
}

variable "APP_SERVICE_PLAN_NAME" {
  description = "The name of the App Service Plan."
  type        = string
}

variable "APP_SERVICE_PLAN_LOCATION" {
  description = "The Azure region for the App Service Plan."
  type        = string
  default     = "eastus"
}

variable "APP_SERVICE_PLAN_SKU_TIER" {
  description = "The pricing tier for the App Service Plan (e.g., 'PremiumV2')."
  type        = string
  default     = "PremiumV2"
}

variable "APP_SERVICE_PLAN_SKU_SIZE" {
  description = "The size of the App Service Plan (e.g., 'P1v2')."
  type        = string
  default     = "P1v2"
}
