variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

variable "current_user_object_id" {
  description = "Object ID of current user"
  type        = string
}

variable "acr_image_name" {
  description = "Name of the Docker image in ACR"
  type        = string
  default     = "cmtr-57d8b090-mod8b-app"
}

variable "image_tag" {
  description = "Tag for the Docker image"
  type        = string
  default     = "latest"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}