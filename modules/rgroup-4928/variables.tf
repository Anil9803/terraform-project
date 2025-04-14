variable "location" {
  description = "Azure region"
  default     = "canada central"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "4928-RG"
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
  default = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "anil.budhathoki"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

