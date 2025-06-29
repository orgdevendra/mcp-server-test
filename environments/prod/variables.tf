# Copy the dev/variables.tf and adjust values for prod as needed
variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "storage_account_name" { type = string }
variable "storage_account_tier" { type = string }
variable "storage_account_replication_type" { type = string }
variable "key_vault_name" { type = string }
variable "tenant_id" { type = string }
variable "key_vault_sku" { type = string }
variable "key_vault_soft_delete_retention_days" { type = number }
variable "key_vault_purge_protection_enabled" { type = bool }
variable "app_service_plan_name" { type = string }
variable "app_service_plan_os_type" { type = string }
variable "app_service_plan_sku" { type = string }
variable "web_app_name" { type = string }
