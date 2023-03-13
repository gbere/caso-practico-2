resource "azurerm_resource_group" "main" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_container_registry" "main" {
  name                = "gbere"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
  admin_enabled       = true
}

# Virtual Machine Linux

resource "azurerm_virtual_network" "vm1-main" {
  name                = "network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "vm1-internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vm1-main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "vm1-pip" {
  name                = "pip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "vm1-main" {
  name                = "vm1-nic1"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.vm1-internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm1-pip.id
  }
}

resource "azurerm_network_interface" "vm1-internal" {
  name                = "vm1-nic2"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm1-internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "webserver" {
  name                = "tls_webserver"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "tls"
    priority                   = 100
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "443"
    destination_address_prefix = azurerm_network_interface.vm1-main.private_ip_address
  }
}

resource "azurerm_network_interface_security_group_association" "vm1-main" {
  network_interface_id      = azurerm_network_interface.vm1-internal.id
  network_security_group_id = azurerm_network_security_group.webserver.id
}

resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "vm1"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_B1s"
  admin_username      = var.ssh_user
  network_interface_ids = [
    azurerm_network_interface.vm1-main.id,
    azurerm_network_interface.vm1-internal.id,
  ]

  admin_ssh_key {
    username   = var.ssh_user
    public_key = file("${var.public_key_path}")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  plan {
    name      = "8_5"
    product   = "almalinux"
    publisher = "almalinux"
  }

  source_image_reference {
    publisher = "almalinux"
    offer     = "almalinux"
    sku       = "8_5"
    version   = "8.5.20220311"
  }
}

# Azure Kubernetes Cluster

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.akc_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = var.akc_name

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

