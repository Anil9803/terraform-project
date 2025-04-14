locals {
  linux_vms = {
    "linux1" = { dns_label = "linux1-n01714928" },
    "linux2" = { dns_label = "linux2-n01714928" },
    "linux3" = { dns_label = "linux3-n01714928" }

  }
}

resource "azurerm_availability_set" "linux_avset" {
  name                = "4928-linux-avset"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}


resource "azurerm_public_ip" "linux_public_ip" {
  for_each            = local.linux_vms
  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = each.value.dns_label
  tags                = var.tags
}

resource "azurerm_network_interface" "linux_nic" {
  for_each            = local.linux_vms
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.linux_public_ip[each.key].id
  }
  tags = var.tags
  depends_on = [azurerm_public_ip.linux_public_ip]
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each                 = local.linux_vms
  name                     = each.value.dns_label
  resource_group_name      = var.resource_group_name
  location                 = var.location
  size                     = "Standard_B1ms"
  availability_set_id      = azurerm_availability_set.linux_avset.id
  admin_username           = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  network_interface_ids = [azurerm_network_interface.linux_nic[each.key].id]  #  Reference the NIC here
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.common_storage_account_uri
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each             = local.linux_vms
  name                 = "${each.key}-nw-ext"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux_vm[each.key].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
  tags                 = var.tags
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each             = local.linux_vms
  name                 = "${each.key}-am-ext"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux_vm[each.key].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.33"
  tags                 = var.tags
}

