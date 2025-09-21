variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy to."
  type        = string
}

variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}

variable "aks_name" {
  description = "The name of the AKS cluster."
  type        = string
}