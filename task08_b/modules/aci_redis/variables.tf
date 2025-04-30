variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "kv_id" {
  description = "Key Vault ID"
  type        = string
}

variable "redis_aci_name" {
  description = "Redis ACI name"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}