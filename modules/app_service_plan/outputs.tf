# Outputs for Azure Linux App Service Plan

output "APP_SERVICE_PLAN_ID" {
  description = "The ID of the App Service Plan."
  value       = azurerm_app_service_plan.this.id
}

output "APP_SERVICE_PLAN_NAME" {
  description = "The name of the App Service Plan."
  value       = azurerm_app_service_plan.this.name
}

output "APP_SERVICE_PLAN_LOCATION" {
  description = "The region of the App Service Plan."
  value       = azurerm_app_service_plan.this.location
}
