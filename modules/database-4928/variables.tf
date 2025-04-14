variable "location" {
  description = "Azure region"
  default     = "canada central"
}

variable "resource_group_name" {
  description = "Resource group name"
}

variable "admin_login" {
  description = "PostgreSQL admin login"
}

variable "admin_password" {
  description = "PostgreSQL admin password"
  sensitive   = true
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

