terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    # Will be configured via init -backend-config
  }
}

provider "azurerm" {
  subscription_id = "a98fede1-1e42-4751-961c-8b6aacdc3589"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}
