variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sa_name" {
  description = "Storage account name"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}