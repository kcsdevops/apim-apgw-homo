resource "azurerm_public_ip" "agw_pip" {
  name                = "meurh360-br-agw-${var.environment}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  domain_name_label   = "meurh360-homolog-agw" # DNS Label para CNAME
  tags                = var.tags
}

resource "azurerm_application_gateway" "agw" {
  name                = "meurh360-br-agw-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = "Standard_Medium"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "frontendPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontendIP"
    public_ip_address_id = azurerm_public_ip.agw_pip.id
  }

  backend_address_pool {
    name = "backendPool"
  }

  backend_address_pool {
    name  = "apim-backend-pool"
    fqdns = var.apim_hostname != "" ? [var.apim_hostname] : []
  }

  backend_http_settings {
    name                  = "httpSettings"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  backend_http_settings {
    name                                = "apim-http-settings"
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 60
    probe_name                          = "probe-apim"
    pick_host_name_from_backend_address = true
  }

  probe {
    name                                      = "probe-apim"
    protocol                                  = "Https"
    path                                      = "/status-0123456789abcdef"
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
  }

  http_listener {
    name                           = "listener"
    frontend_ip_configuration_name = "frontendIP"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "listener"
    backend_address_pool_name  = "backendPool"
    backend_http_settings_name = "httpSettings"
  }

  tags = var.tags
}
