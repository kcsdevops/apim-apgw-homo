variable "resource_group_name" {}
variable "location" {}
variable "tags" {}
variable "environment" {}
variable "subnet_id" {}
variable "law_id" {}

resource "azurerm_container_registry" "acr" {
  name                = "meurh360bracr${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = var.tags
}

resource "azurerm_container_app_environment" "cae" {
  name                       = "meurh360-br-cae-${var.environment}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = var.law_id
  infrastructure_subnet_id   = var.subnet_id

  tags = var.tags
}

resource "azurerm_container_app" "app" {
  name                         = "meurh360-br-app-${var.environment}"
  container_app_environment_id = azurerm_container_app_environment.cae.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  template {
    container {
      name   = "example-container"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  tags = var.tags
}
