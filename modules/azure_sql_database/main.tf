# AVM-compliant Azure SQL Database module

module "sql_server" {
  source  = "Azure/avm-res-mssqlserver/azurerm"
  version = ">= 0.1.0"

  # Required variables
  name                = var.sql_server_name
  resource_group_name = var.resource_group_name
  location            = var.location
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  # Optional: Add more parameters as needed
}

resource "azurerm_mssql_database" "this" {
  name                = var.sql_database_name
  server_id           = module.sql_server.id
  collation           = var.collation
  sku_name            = var.sku_name
  max_size_gb         = var.max_size_gb
  read_scale          = var.read_scale
  zone_redundant      = var.zone_redundant
  tags                = var.tags
}

output "sql_server_id" {
  value = module.sql_server.id
}

output "sql_database_id" {
  value = azurerm_mssql_database.this.id
}
