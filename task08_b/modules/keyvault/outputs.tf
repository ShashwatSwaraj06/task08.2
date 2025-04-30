output "kv_id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault.main.id
}

output "kv_name" {
  description = "Key Vault name"
  value       = azurerm_key_vault.main.name
}

output "redis_password_secret_id" {
  description = "Redis password secret ID"
  value       = "${azurerm_key_vault.main.id}/secrets/redis-password"
}

output "redis_hostname_secret_id" {
  description = "Redis hostname secret ID"
  value       = "${azurerm_key_vault.main.id}/secrets/redis-hostname"
}