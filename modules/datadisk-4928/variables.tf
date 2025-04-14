variable "location" {
  description = "Azure region"
  default     = "canada central"
}

variable "resource_group_name" {
  description = "Resource group name"
}

variable "vm_ids" {
  description = "List of VM IDs to attach disks"
  type        = list(string)
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

