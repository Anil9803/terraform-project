variable "location" {
  description = "Azure region"
  default     = "canada central"
}

variable "resource_group_name" {
  description = "Resource group for common services"
}

variable "log_analytics_name" {
  description = "Log Analytics Workspace name"
  default     = "4928-LAW"
}

variable "rsv_name" {
  description = "Recovery Services Vault name"
  default     = "rsv-4928"
}

variable "storage_account_name" {
  description = "Storage account name for common services"
  default     = "sac4928common"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

