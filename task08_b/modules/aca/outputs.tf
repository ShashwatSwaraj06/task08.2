output "aca_fqdn" {
  description = "ACA FQDN"
  value       = azurerm_container_app.main.ingress[0].fqdn
}