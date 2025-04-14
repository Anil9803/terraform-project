terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaterg-4928"
    storage_account_name = "tfstateaccount4928"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

