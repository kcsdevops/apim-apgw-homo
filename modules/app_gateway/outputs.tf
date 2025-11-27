output "appgw_id" {
  value       = azurerm_application_gateway.agw.id
  description = "ID do Application Gateway"
}

output "public_ip_address" {
  value       = azurerm_public_ip.agw_pip.ip_address
  description = "Endereço IP público do Application Gateway"
}
