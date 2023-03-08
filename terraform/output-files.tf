# Creamos un archivo de variables para ansible que contiene las credenciales para
# el Azure container registry
resource "local_sensitive_file" "acr" {
  filename = "${path.module}/../ansible/vars/azurerm_container_registry_vars.yaml"
  content = yamlencode({
    acr_login_server : "${azurerm_container_registry.main.login_server}",
    acr_password : "${azurerm_container_registry.main.admin_password}",
  })
}
