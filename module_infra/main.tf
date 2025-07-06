module "rg" {
  source   = "../module/rg_azurerm"
  rg_name  = "bablu_rg"
  location = "centralindia"
}
module "rg" {
  source   = "../module/rg_azurerm"
  rg_name  = "praveen_rg"
  location = "East US"
}
module "rg1" {
  source   = "../module/rg_azurerm"
  rg_name  = "praveen_rg1"
  location = "East US"
}

module "vnet" {
  depends_on    = [module.rg]
  source        = "../module/vnet_azurerm"
  vnet_name     = "bablu_vnet"
  rg_name       = "bablu_rg"
  location      = "centralindia"
  address_space = ["10.0.0.0/16"]
}

module "subnet" {
  depends_on       = [module.vnet]
  source           = "../module/subnet_azurerm"
  subnet_name      = "bablu_subnet"
  rg_name          = "bablu_rg"
  vnet_name        = "bablu_vnet"
  address_prefixes = ["10.0.1.0/24"]

}

module "pip" {
  depends_on = [module.subnet]
  source     = "../module/pip_azurerm"
  pip_name   = "bablu_pip"
  location   = "centralindia"
  rg_name    = "bablu_rg"
}

module "nic" {
  depends_on  = [module.pip]
  source      = "../module/nic_azurerm"
  subnet_name = "bablu_subnet"
  vnet_name   = "bablu_vnet"
  rg_name     = "bablu_rg"
  pip_name    = "bablu_pip"
  nic_name    = "bablu_nic"
  location    = "centralindia"
  ip_name     = "bablu_ip"
}


module "vm" {
  depends_on     = [module.nic]
  source         = "../module/vm_azurerm"
  nic_name       = "bablu_nic"
  location       = "centralindia"
  rg_name        = "bablu_rg"
  vm_name        = "babluvmm"
  size           = "Standard_B1s"
  username       = "parasbhai"
  admin_password = "Bablu@12345678"
}

module "sql_server" {
  depends_on = [module.rg]
  source     = "../module/sql_server_azurerm"
  sql_name   = "bablusql"
  rg_name    = "bablu_rg"
  location   = "centralindia"
  # version        = "12.0"
  login          = "bablusql"
  login_password = "Bablu@3599"
}

module "sql_database" {
  depends_on = [module.sql_server]
  source     = "../module/sql_db_azurerm"
  sql_name   = "bablusql"
  rg_name    = "bablu_rg"
  sqldb_name = "bablu-sqldatabase"
  gb_size    = "2"
  sku_name   = "S0"
}
