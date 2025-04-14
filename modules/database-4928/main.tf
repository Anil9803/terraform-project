resource "azurerm_postgresql_server" "db_server" {
  name                = "pgserver-4928"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name            = "B_Gen5_1"
  storage_mb          = 5120
  administrator_login = var.admin_login
  administrator_login_password = var.admin_password
  version             = "11"

  ssl_enforcement_enabled = true
}

resource "azurerm_postgresql_database" "db" {
  name                = "pgdatabase-4928"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.db_server.name
  charset            = "UTF8"
  collation          = "en_US.utf8"
}

