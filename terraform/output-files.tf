# Creamos un archivo de variables para ansible que contiene las credenciales para
# el Azure container registry con permisos de 0700
resource "local_sensitive_file" "acr" {
  filename = "${path.module}/../ansible/vars/azure_container_registry_vars.yaml"
  content = yamlencode({
    cr_registry : "${azurerm_container_registry.main.login_server}",
    cr_username : "${azurerm_container_registry.main.admin_username}",
    cr_password : "${azurerm_container_registry.main.admin_password}",
  })
}
