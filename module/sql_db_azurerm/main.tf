data "azurerm_mssql_server" "sqlsv" {
  name                         = var.sql_name
  resource_group_name          = var.rg_name
}

resource "azurerm_mssql_database" "sqldb" {
  name         = var.sqldb_name
  server_id    = data.azurerm_mssql_server.sqlsv.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = var.gb_size
  sku_name     = var.sku_name
  enclave_type = "VBS"
}