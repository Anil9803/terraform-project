module "rgroup-4928" {
  source   = "./modules/rgroup-4928"
  location = "canada central"
}
  
module "network-4928" {
  source              = "./modules/network-4928"
  location            = "canada central"  
  resource_group_name = module.rgroup-4928.resource_group_name
  tags                = module.rgroup-4928.tags
}
 
module "common-4928" {
  source              = "./modules/common-4928"
  location            = "canada central"
  resource_group_name = module.rgroup-4928.resource_group_name
  tags                = module.rgroup-4928.tags
}
  
module "vmlinux-4928" {
  source              = "./modules/vmlinux-4928"
  location            = "canada central"
  resource_group_name = module.rgroup-4928.resource_group_name
  subnet_id           = module.network-4928.subnet_id
  admin_username      = "azureuser"
  admin_password      = "Password4928!"
  common_storage_account_uri = "https://${module.common-4928.common_storage_account_name}.blob.core.windows.net/"
  tags                = module.rgroup-4928.tags
}
  
module "vmwindows-4928" {
  source                     = "./modules/vmwindows-4928"
  location                   = "canada central"
  resource_group_name        = module.rgroup-4928.resource_group_name
  subnet_id                  = module.network-4928.subnet_id
  admin_username             = "azureuser"
  admin_password             = "Password4928!"
  common_storage_account_uri = "https://${module.common-4928.common_storage_account_name}.blob.core.windows.net/"
  tags                       = module.rgroup-4928.tags
}
 
locals {
  vm_ids = concat(module.vmlinux-4928.linux_vm_ids, [module.vmwindows-4928.windows_vm_id])
}

module "datadisk-4928" {
  source              = "./modules/datadisk-4928"
  location            = "canada central"
  resource_group_name = module.rgroup-4928.resource_group_name
  vm_ids              = local.vm_ids
  tags                = module.rgroup-4928.tags
}

module "loadbalancer-4928" {
  source              = "./modules/loadbalancer-4928"
  location            = "canada central"
  resource_group_name = module.rgroup-4928.resource_group_name
  subnet_id           = module.network-4928.subnet_id
  tags                = module.rgroup-4928.tags
}
  
module "database-4928" {
  source              = "./modules/database-4928"
  location            = "canada central"  
  resource_group_name = module.rgroup-4928.resource_group_name
  admin_login         = "pgadmin"
  admin_password      = "Password4928!"
  tags                = module.rgroup-4928.tags
}


resource "null_resource" "ansible_provision" {
  triggers = {
    linux_vm_ids = join(",", module.vmlinux-4928.linux_vm_ids)
  }

  provisioner "local-exec" {
    command     = "ansible-playbook -i ansible/inventory.ini ansible/4928-playbook.yml"
    working_dir = "${path.module}"
  }
}

