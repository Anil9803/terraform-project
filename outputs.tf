output "resource_group" {
  value = module.rgroup-4928.resource_group_name
}

output "vnet" {
  value = module.network-4928.vnet_name
}

output "subnet" {
  value = module.network-4928.subnet_name
}

output "log_analytics_workspace" {
  value = module.common-4928.log_analytics_workspace_name
}

output "recovery_services_vault" {
  value = module.common-4928.recovery_services_vault_name
}

output "common_storage_account" {
  value = module.common-4928.common_storage_account_name
}

output "linux_vm_hostnames_map" {
  value = module.vmlinux-4928.linux_vm_hostnames_map
}

output "linux_vm_hostnames" {
  value = module.vmlinux-4928.linux_vm_hostnames
}

output "linux_vm_domain_names" {
  value = module.vmlinux-4928.linux_vm_domain_names
}

output "linux_vm_private_ips" {
  value = module.vmlinux-4928.linux_vm_private_ips
}

output "linux_vm_public_ips" {
  value = module.vmlinux-4928.linux_vm_public_ips
}

output "windows_vm_hostname" {
  value = module.vmwindows-4928.windows_vm_hostname
}

output "windows_vm_domain_name" {
  value = module.vmwindows-4928.windows_vm_domain_name
}

output "windows_vm_private_ip" {
  value = module.vmwindows-4928.windows_vm_private_ip
}

output "windows_vm_public_ip" {
  value = module.vmwindows-4928.windows_vm_public_ip
}

output "load_balancer_name" {
  value = module.loadbalancer-4928.load_balancer_name
}

output "Database" {
  value = module.database-4928.db_name
}

