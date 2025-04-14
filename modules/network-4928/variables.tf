variable "location" {
  description = "Azure region"
  default     = "canada central"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "vnet_name" {
  description = "Virtual network name"
  default     = "4928-VNET"
}

variable "subnet_name" {
  description = "Subnet name"
  default     = "4928-SUBNET"
}

variable "nsg_name" {
  description = "NSG name"
  default     = "4928-NSG"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

