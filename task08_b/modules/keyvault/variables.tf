variable "name" {
  description = "Name of the Key Vault"
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

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

variable "current_user_object_id" {
  description = "Object ID of current user"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}