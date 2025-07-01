variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL Database."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region for the resources."
  type        = string
}

variable "administrator_login" {
  description = "The administrator login name for the SQL Server."
  type        = string
}

variable "administrator_login_password" {
  description = "The administrator login password for the SQL Server."
  type        = string
  sensitive   = true
}

variable "collation" {
  description = "The collation for the database."
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "sku_name" {
  description = "The SKU name for the database."
  type        = string
  default     = "S0"
}

variable "max_size_gb" {
  description = "The max size of the database in GB."
  type        = number
  default     = 5
}

variable "read_scale" {
  description = "Enable read scale-out on the database."
  type        = bool
  default     = false
}

variable "zone_redundant" {
  description = "Whether the database is zone redundant."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
