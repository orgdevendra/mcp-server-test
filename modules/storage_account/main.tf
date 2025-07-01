resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  is_hns_enabled           = true
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_container" "rows" {
  name                  = "rows"
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "rows" {
  name               = azurerm_storage_container.rows.name
  storage_account_id = azurerm_storage_account.this.id
}

resource "azurerm_storage_data_lake_gen2_path" "bronze" {
  path               = "bronze"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.rows.name
  storage_account_id = azurerm_storage_account.this.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "silver" {
  path               = "silver"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.rows.name
  storage_account_id = azurerm_storage_account.this.id
  resource           = "directory"
}

resource "azurerm_storage_data_lake_gen2_path" "gold" {
  path               = "gold"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.rows.name
  storage_account_id = azurerm_storage_account.this.id
  resource           = "directory"
}

output "name" {
  value = azurerm_storage_account.this.name
}
output "id" {
  value = azurerm_storage_account.this.id
}
output "container_name" {
  value = azurerm_storage_container.rows.name
}
output "filesystem_name" {
  value = azurerm_storage_data_lake_gen2_filesystem.rows.name
}
