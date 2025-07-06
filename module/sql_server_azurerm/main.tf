resource "azurerm_mssql_server" "bablusql" {
  name                         = var.sql_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.login
  administrator_login_password = var.login_password
}

