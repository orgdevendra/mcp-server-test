# AVM-compliant Azure SQL Database module

resource "azurerm_mssql_server" "this" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  tags                         = var.tags
}

resource "azurerm_mssql_database" "this" {
  name                = var.sql_database_name
  server_id           = azurerm_mssql_server.this.id
  collation           = var.collation
  sku_name            = var.sku_name
  max_size_gb         = var.max_size_gb
  read_scale          = var.read_scale
  zone_redundant      = var.zone_redundant
  tags                = var.tags
}
