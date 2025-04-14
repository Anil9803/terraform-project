output "linux_vm_hostnames_map" {
  description = "Map of Linux VM hostnames keyed by instance name"
  value       = { for key, vm in azurerm_linux_virtual_machine.linux_vm : key => vm.name }
}

output "linux_vm_hostnames" {
  value = [for vm in azurerm_linux_virtual_machine.linux_vm : vm.name]
}

output "linux_vm_domain_names" {
  value = [for pip in azurerm_public_ip.linux_public_ip : pip.fqdn]
}

output "linux_vm_private_ips" {
  value = [for nic in azurerm_network_interface.linux_nic : nic.ip_configuration[0].private_ip_address]
}

output "linux_vm_public_ips" {
  value = [for pip in azurerm_public_ip.linux_public_ip : pip.ip_address]
  depends_on  = [azurerm_public_ip.linux_public_ip] 
}

output "linux_vm_ids" {
  value = [for vm in azurerm_linux_virtual_machine.linux_vm : vm.id]
}

