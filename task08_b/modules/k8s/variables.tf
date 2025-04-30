variable "aks_cluster" {
  description = "AKS cluster object"
}

variable "acr_login" {
  description = "ACR login server"
  type        = string
}

variable "app_image_name" {
  description = "Application image name"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "kv_name" {
  description = "Key Vault name"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}