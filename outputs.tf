output "website_url" {
  description = "URL of the static website"
  value       = azurerm_storage_account.web_storage.primary_web_endpoint
}
