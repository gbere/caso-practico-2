output "vm1_pip" {
  value = azurerm_linux_virtual_machine.vm1.public_ip_address
}

output "aks1_pip" {
  value = data.azurerm_public_ip.aks1-pip.ip_address
}
