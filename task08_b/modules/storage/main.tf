data "archive_file" "app" {
  type        = "tar.gz"
  source_dir  = "${path.root}/../application"
  output_path = "${path.root}/app.tar.gz"
}

resource "azurerm_storage_account" "main" {
  name                     = var.sa_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_storage_container" "app_content" {
  name                  = "app-content"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "app" {
  name                   = "app-${filesha256(data.archive_file.app.output_path)}.tar.gz"
  storage_account_name   = azurerm_storage_account.main.name
  storage_container_name = azurerm_storage_container.app_content.name
  type                   = "Block"
  source                 = data.archive_file.app.output_path
}

resource "time_offset" "sas_start" {
  offset_days = -1
}

resource "time_offset" "sas_expiry" {
  offset_days = 7
}

data "azurerm_storage_account_blob_container_sas" "app_content" {
  connection_string = azurerm_storage_account.main.primary_connection_string
  container_name    = azurerm_storage_container.app_content.name
  start             = time_offset.sas_start.rfc3339
  expiry            = time_offset.sas_expiry.rfc3339

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = false
  }
}