variable "location" {
  description = "Azure region"
  default     = "canada central"
}

variable "resource_group_name" {
  description = "Resource group name"
}

variable "subnet_id" {
  description = "Subnet ID to host the internal load balancer"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

