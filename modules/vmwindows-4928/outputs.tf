output "windows_vm_hostname" {
  value = azurerm_windows_virtual_machine.windows_vm[0].name
}

output "windows_vm_domain_name" {
  value = azurerm_public_ip.windows_public_ip[0].domain_name_label
}

output "windows_vm_private_ip" {
  value = azurerm_network_interface.windows_nic[0].ip_configuration[0].private_ip_address
}

output "windows_vm_public_ip" {
  value = azurerm_public_ip.windows_public_ip[0].ip_address
  depends_on  = [azurerm_public_ip.windows_public_ip]
}

output "windows_vm_id" {
  value = azurerm_windows_virtual_machine.windows_vm[0].id
}

