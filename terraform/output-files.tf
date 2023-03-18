# Creamos un archivo de variables para ansible que contiene las credenciales para
# el Azure container registry con permisos de 0700
resource "local_sensitive_file" "acr" {
  filename = "${path.module}/../ansible/vars/private_vars.yaml"
  content = yamlencode({
    "cr_registry" : "${azurerm_container_registry.main.login_server}",
    "cr_username" : "${azurerm_container_registry.main.admin_username}",
    "cr_password" : "${azurerm_container_registry.main.admin_password}",
    "aks1_pip" : "${data.azurerm_public_ip.aks1-pip.ip_address}",
  })
}

# Creamos el archivo para la configuración de acceso al cluster de Kubernetes 
# con permisos de 0700
resource "local_sensitive_file" "akc" {
  filename = "${path.module}/../ansible/vars/.kubeconfig"
  content  = azurerm_kubernetes_cluster.main.kube_config_raw
}

# Creamos el archivo hosts.yaml para ansible
resource "local_file" "hosts" {
  filename = "${path.module}/../ansible/hosts.yaml"
  content = yamlencode({
    "vm1" : {
      "hosts" : "${azurerm_linux_virtual_machine.vm1.public_ip_address}",
    },
    "k8s" : {
      "hosts" : "${azurerm_kubernetes_cluster.main.fqdn}",
    },
  })
}
