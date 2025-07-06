data "azurerm_network_interface" "nic" {
  name                = var.nic_name
#   location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.size
  admin_username      = var.username
  admin_password      = var.admin_password
  network_interface_ids = [
    data.azurerm_network_interface.nic.id
  ]
disable_password_authentication = false


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}