variable "resource_group_name" {}
variable "location" {}
variable "tags" {}
variable "environment" {}
variable "vnet_id" {}
variable "subnet_id" {}

resource "azurerm_postgresql_flexible_server" "psql" {
  name                   = "meurh360-br-psql-${var.environment}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = "13"
  delegated_subnet_id    = var.subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.postgres_dns.id
  administrator_login    = "psqladmin"
  administrator_password = "ChangeMe123!" # Use KeyVault in production
  zone                   = "1"

  storage_mb = 32768

  sku_name = "B_Standard_B1ms"
  tags     = var.tags

  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgres_link]
}

resource "azurerm_private_dns_zone" "postgres_dns" {
  name                = "meurh360.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres_link" {
  name                  = "postgres-link"
  private_dns_zone_name = azurerm_private_dns_zone.postgres_dns.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group_name
}
