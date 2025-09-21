# Configure the Azure backend to store the state file
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "devops-project-rg-k8"
    storage_account_name = "tfstateaccuk8" # Replace with your name
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Define the Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "ee640504-f313-4805-a728-74596e0d6714"
}

# Create the Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create the Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Create the Azure Kubernetes Service (AKS) cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.aks_name

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s" 
  }

  identity {
    type = "SystemAssigned"
  }
}

# Generate a Kubernetes Config file for local use
resource "local_file" "kubeconfig" {
  content  = azurerm_kubernetes_cluster.aks.kube_config_raw
  filename = "kubeconfig"
}