variable "resource_group_name" {}
variable "location" {}
variable "tags" {}
variable "environment" {}

resource "azurerm_storage_account" "st" {
  name                     = "stmeurh360${var.environment}" # Must be unique globally
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}
