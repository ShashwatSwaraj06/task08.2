variable "name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "acr_image_name" {
  description = "Name of the Docker image to build"
  type        = string
}

variable "image_tag" {
  description = "Tag for the Docker image"
  type        = string
}

variable "blob_url" {
  description = "URL of the blob containing application code"
  type        = string
}

variable "sas_token" {
  description = "SAS token for accessing the blob"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}