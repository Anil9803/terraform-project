variable "location" {
  description = "Azure region"
  default     = "canada central"
}

variable "resource_group_name" {
  description = "Resource group name"
}

variable "subnet_id" {
  description = "Subnet ID for the VM"
}

variable "admin_username" {
  description = "Admin username for Windows VM"
}

variable "admin_password" {
  description = "Admin password for Windows VM"
  sensitive   = true
}

variable "common_storage_account_uri" {
  description = "URI for boot diagnostics from common storage account"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

