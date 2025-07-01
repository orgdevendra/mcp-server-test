output "sql_server_id" {
  description = "The ID of the SQL Server."
  value       = azurerm_mssql_server.this.id
}

output "sql_database_id" {
  description = "The ID of the SQL Database."
  value       = azurerm_mssql_database.this.id
}
