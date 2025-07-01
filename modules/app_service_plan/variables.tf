# AVM-compliant variables for Azure Linux App Service Plan
# All variable names are uppercase for workflow/secret alignment

variable "APP_SERVICE_PLAN_NAME" {
  description = "The name of the App Service Plan."
  type        = string
}

variable "APP_SERVICE_PLAN_LOCATION" {
  description = "The Azure region for the App Service Plan."
  type        = string
}

variable "RESOURCE_GROUP_NAME" {
  description = "The name of the resource group."
  type        = string
}

variable "APP_SERVICE_PLAN_SKU_TIER" {
  description = "The pricing tier for the App Service Plan (e.g., 'PremiumV2')."
  type        = string
}

variable "APP_SERVICE_PLAN_SKU_SIZE" {
  description = "The size of the App Service Plan (e.g., 'P1v2')."
  type        = string
}

variable "TAGS" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
