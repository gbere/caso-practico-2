output "container_registry_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "container_registry_admin_password" {
  value = azurerm_container_registry.acr.admin_password
  sensitive = true
}
