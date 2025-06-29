variable "resource_group_resource" {
  description = "Resource group resource object for AVM module."
  type = object({
    name     = string
    location = string
  })
}

variable "storage_account_resource" {
  description = "Storage account resource object for AVM module."
  type = object({
    name     = string
    location = string
    account_tier = string
    account_replication_type = string
  })
}

variable "key_vault_resource" {
  description = "Key vault resource object for AVM module."
  type = object({
    name     = string
    location = string
    tenant_id = string
    sku_name = string
    soft_delete_retention_days = number
    purge_protection_enabled = bool
  })
}

variable "app_service_plan_resource" {
  description = "App service plan resource object for AVM module."
  type = object({
    name     = string
    location = string
    os_type  = string
    sku_name = string
  })
}

variable "web_app_resource" {
  description = "Web app resource object for AVM module."
  type = object({
    name     = string
    location = string
    service_plan_id = string
  })
}
