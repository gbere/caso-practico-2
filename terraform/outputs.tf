output "container_registry_login_server" {
  value = azurerm_container_registry.main.login_server
}

output "container_registry_admin_username" {
  value = azurerm_container_registry.main.admin_username
}

output "container_registry_admin_password" {
  value     = azurerm_container_registry.main.admin_password
  sensitive = true
}

output "vm1_pip" {
  value = azurerm_linux_virtual_machine.vm1.public_ip_address
}

output "akc_fqdn" {
  value = azurerm_kubernetes_cluster.main.fqdn
}

# TODO: move to an output file
output "aks1_pip" {
  value = data.azurerm_public_ip.aks1-pip.ip_address
}
