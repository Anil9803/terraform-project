output "db_server_name" {
  value = azurerm_postgresql_server.db_server.name
}

output "db_name" {
  value = azurerm_postgresql_database.db.name
}

