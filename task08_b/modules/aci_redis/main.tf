resource "random_password" "redis" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_container_group" "redis" {
  name                = var.redis_aci_name
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = "Linux"
  ip_address_type     = "Public"
  dns_name_label      = var.redis_aci_name

  container {
    name   = "redis"
    image  = "mcr.microsoft.com/oss/bitnami/redis:6.2"
    cpu    = "1.0"
    memory = "1.5"

    ports {
      port     = 6379
      protocol = "TCP"
    }

    commands = [
      "redis-server",
      "--protected-mode", "no",
      "--requirepass", random_password.redis.result
    ]
  }
  tags = var.tags
}

resource "azurerm_key_vault_secret" "redis_password" {
  name         = "redis-password"
  value        = random_password.redis.result
  key_vault_id = var.kv_id
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = "redis-hostname"
  value        = azurerm_container_group.redis.fqdn
  key_vault_id = var.kv_id
}