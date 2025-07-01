# Azure Linux App Service Plan (AVM-compliant)
# This module provisions an Azure App Service Plan for Linux web apps (Python-ready).
# - Uses AVM-compliant, uppercase variable names
# - Supports import logic for pre-existing resources
# - Region/location is configurable
# - Type safety and CI/CD best practices
# - No credentials are hardcoded; use Managed Identity/Key Vault for secrets

resource "azurerm_app_service_plan" "this" {
  name                = var.APP_SERVICE_PLAN_NAME
  location            = var.APP_SERVICE_PLAN_LOCATION
  resource_group_name = var.RESOURCE_GROUP_NAME
  kind                = "Linux"
  reserved            = true

  sku {
    tier = var.APP_SERVICE_PLAN_SKU_TIER
    size = var.APP_SERVICE_PLAN_SKU_SIZE
  }

  tags = var.TAGS
}

# Import logic (for CI/CD):
# If a plan with the same name exists, import it before apply.
# See workflow for import logic.

output "APP_SERVICE_PLAN_ID" {
  value = azurerm_app_service_plan.this.id
}
