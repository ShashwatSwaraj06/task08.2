variable "name" {
  description = "Container App name"
  type        = string
}

variable "env_name" {
  description = "Container App Environment name"
  type        = string
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "acr_id" {
  description = "ACR resource ID"
  type        = string
}

variable "kv_id" {
  description = "Key Vault ID"
  type        = string
}

variable "redis_secrets" {
  description = "Redis secret references"
  type = object({
    url = string
    pwd = string
  })
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

variable "acr_login_server" {
  description = "ACR login server URL"
  type        = string
}

variable "image_name" {
  description = "Docker image name"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
}