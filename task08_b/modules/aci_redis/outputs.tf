output "redis_fqdn" {
  description = "Redis ACI FQDN"
  value       = azurerm_container_group.redis.fqdn
}

output "password_secret_id" {
  description = "Redis password secret ID"
  value       = azurerm_key_vault_secret.redis_password.id
}

output "hostname_secret_id" {
  description = "Redis hostname secret ID"
  value       = azurerm_key_vault_secret.redis_hostname.id
}