output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_postgres_id" {
  value = azurerm_subnet.postgres.id
}

output "subnet_aca_id" {
  value = azurerm_subnet.aca.id
}
