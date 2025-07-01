output "sql_server_id" {
  description = "The ID of the SQL Server."
  value       = module.sql_server.id
}

output "sql_database_id" {
  description = "The ID of the SQL Database."
  value       = azurerm_mssql_database.this.id
}
