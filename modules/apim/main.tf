variable "resource_group_name" {}
variable "location" {}
variable "tags" {}
variable "environment" {}

resource "azurerm_api_management" "apim" {
  name                = "meurh360-br-apim-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = "MeuRH360"
  publisher_email     = "admin@meurh360.com.br"

  sku_name = "Developer_1"

  tags = var.tags
}
