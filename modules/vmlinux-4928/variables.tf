variable "location" {
  description = "Azure region"
  default     = "canada central"
}

variable "resource_group_name" {
  description = "Resource group name"
}

variable "subnet_id" {
  description = "ID of the subnet for VMs"
}

variable "admin_username" {
  description = "Admin username for Linux VMs"
}

variable "admin_password" {
  description = "Admin password for Linux VMs"
  sensitive   = true
}

variable "common_storage_account_uri" {
  description = "URI for boot diagnostics from common storage account"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}


