variable "resource_group_name" {
  description = "Nome do grupo de recursos"
}
variable "location" {
  description = "Localização dos recursos"
}
variable "tags" {
  description = "Tags para os recursos"
}
variable "environment" {
  description = "Ambiente de implantação"
}

resource "azurerm_api_management" "apim" {
  name                = "meurh360-br-apim-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = "MeuRH360"
  publisher_email     = "admin@meurh360.com.br"

  sku_name = "Developer_1"

  tags = var.tags
}
