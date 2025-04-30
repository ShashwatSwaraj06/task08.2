variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "acr_name" {
  description = "ACR name"
  type        = string
}

variable "blob_url" {
  description = "Blob storage URL with SAS token"
  type        = string
}

variable "sas_token" {
  description = "SAS token for storage access"
  type        = string
  sensitive   = true
}

variable "acr_image_name" {
  description = "Name of the Docker image"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}