# Define o provedor Azure
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.9.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "subscripton ID key secret"
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

# Crie o Azure Container Instance (ACI)
resource "azurerm_container_group" "aci" {
  name                = "curriculo-devops-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  dns_name_label      = "curriculo-devops-app-${random_string.suffix.result}"
  os_type             = "Linux"

  container {
    name   = "curriculo-app"
    image  = "${azurerm_container_registry.acr.login_server}/devops-app:latest"
    cpu    = 1
    memory = 1.5
    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  restart_policy = "Always"
}

# Gera um sufixo aleatório para o nome DNS
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}
