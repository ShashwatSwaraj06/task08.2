resource "azurerm_container_app_environment" "main" {
  name                = var.env_name
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags
}

resource "azurerm_user_assigned_identity" "aca" {
  name                = "${var.name}-identity"
  resource_group_name = var.rg_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_user_assigned_identity.aca.principal_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}

resource "azurerm_key_vault_access_policy" "aca" {
  key_vault_id = var.kv_id
  tenant_id    = azurerm_user_assigned_identity.aca.tenant_id
  object_id    = azurerm_user_assigned_identity.aca.principal_id

  secret_permissions = ["Get"]
}

resource "azurerm_container_app" "main" {
  name                         = var.name
  container_app_environment_id = azurerm_container_app_environment.main.id
  resource_group_name          = var.rg_name
  revision_mode                = "Single"
  tags                         = var.tags

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aca.id]
  }

  template {
    container {
      name   = "app"
      image  = "${var.acr_login_server}/${var.image_name}:${var.image_tag}"
      cpu    = 0.25
      memory = "0.5Gi"

      env {
        name  = "CREATOR"
        value = "ACA"
      }
      env {
        name  = "REDIS_PORT"
        value = "6379"
      }
      env {
        name        = "REDIS_URL"
        secret_name = "redis-url"
      }
      env {
        name        = "REDIS_PWD"
        secret_name = "redis-key"
      }
    }
  }

  secret {
    name  = "redis-url"
    value = var.redis_secrets.url
  }

  secret {
    name  = "redis-key"
    value = var.redis_secrets.pwd
  }

  ingress {
    external_enabled = true
    target_port      = 8080
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}