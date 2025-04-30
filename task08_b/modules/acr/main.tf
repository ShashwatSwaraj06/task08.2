resource "azurerm_container_registry" "main" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false
  tags                = var.tags
}

resource "azurerm_container_registry_task" "build" {
  name                  = "build-app-image"
  container_registry_id = azurerm_container_registry.main.id
  platform {
    os = "Linux"
  }

  docker_step {
    context_path    = "${var.blob_url}${var.sas_token}"
    dockerfile_path = "Dockerfile"
    image_names     = ["${var.acr_image_name}:${var.image_tag}"]
  }
}