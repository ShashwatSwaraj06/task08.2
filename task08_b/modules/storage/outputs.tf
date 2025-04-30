output "blob_url" {
  description = "Blob URL"
  value       = azurerm_storage_blob.app.url
}

output "sas_token" {
  description = "SAS token for blob access"
  value       = data.azurerm_storage_account_blob_container_sas.app_content.sas
  sensitive   = true
}