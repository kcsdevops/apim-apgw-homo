output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "ID da rede virtual"
}

output "subnet_postgres_id" {
  value       = azurerm_subnet.postgres.id
  description = "ID da subnet do PostgreSQL"
}

output "subnet_aca_id" {
  value       = azurerm_subnet.aca.id
  description = "ID da subnet do Container Apps"
}

output "subnet_appgw_id" {
  value       = azurerm_subnet.appgw.id
  description = "ID da subnet do Application Gateway"
}
