resource "azurerm_availability_set" "windows_avset" {
  name                = "4928-windows-avset"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_public_ip" "windows_public_ip" {
  count               = 1
  name                = "4928-windows-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "wind4928" 
  tags                = var.tags
}


resource "azurerm_network_interface" "windows_nic" {
  count               = 1
  name                = "4928-windows-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_public_ip[0].id
  }
  tags = var.tags
  depends_on = [azurerm_public_ip.windows_public_ip]
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count                = 1
  name                 = "4928-windows-vm"
  resource_group_name  = var.resource_group_name
  location             = var.location
  size                 = "Standard_B1ms"
  availability_set_id  = azurerm_availability_set.windows_avset.id
  admin_username       = var.admin_username
  admin_password       = var.admin_password
  network_interface_ids = [azurerm_network_interface.windows_nic[0].id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  boot_diagnostics {
    storage_account_uri = var.common_storage_account_uri
  }
  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count                = 1
  name                 = "4928-antimalware"
  virtual_machine_id   = azurerm_windows_virtual_machine.windows_vm[0].id
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.3"
  settings             = jsonencode({
    AntimalwareEnabled = true
  })
  tags                 = var.tags
}

