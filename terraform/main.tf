# Define o provedor Azure
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.9.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "ee640504-f313-4805-a728-74596e0d6714"
}

# Crie o grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Crie o Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Gera um sufixo aleatório para o nome DNS
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}