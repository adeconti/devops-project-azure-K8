variable "resource_group_name" {
  description = "The name of the resource group in which to create resources."
  type        = string
  default     = "devops-project-iac-rg"
}

variable "location" {
  description = "The Azure region to create resources in."
  type        = string
  default     = "brazilsouth"
}

variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
  default     = "devopsaccurateiac"
}