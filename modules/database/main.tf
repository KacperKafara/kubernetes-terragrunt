resource "azurerm_postgresql_flexible_server" "postgres_server_group1" {
  name                          = var.postgres_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.postgres_version
  delegated_subnet_id           = var.delegated_subnet_id
  private_dns_zone_id           = var.private_dns_zone_id
  public_network_access_enabled = var.public_network_access
  administrator_login           = var.admin_login
  administrator_password        = var.admin_password
  sku_name                      = var.sku_name
  storage_mb                    = var.storage_mb
  backup_retention_days         = var.backup_retention_days
  geo_redundant_backup_enabled  = var.geo_redundant_backup
  auto_grow_enabled             = var.auto_grow
  zone                          = var.zone
}

resource "azurerm_postgresql_flexible_server_database" "parkanizer_database" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.postgres_server_group1.id
  charset   = "UTF8"
}