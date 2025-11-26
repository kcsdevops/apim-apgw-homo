variable "resource_group_name" {}
variable "location" {}
variable "tags" {}
variable "environment" {}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "meurh360-br-log-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_application_insights" "appi" {
  name                = "meurh360-br-appi-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.law.id
  application_type    = "web"
  tags                = var.tags
}
