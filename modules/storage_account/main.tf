resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}
resource "azurerm_storage_account" "this" {
  name                     = "${var.name}${random_integer.suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}
