terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">4.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

resource "azurerm_network_interface" "NIC" {
  name                = "${var.VM.prefix}-nic"
  location            = var.VM.location
  resource_group_name = var.VM.resource_group_name

  ip_configuration {
    name                          = "test-ip"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "virtual_machine" {
  name                  = var.VM.vm_name
  location              = var.VM.location
  resource_group_name   = var.VM.resource_group_name
  network_interface_ids = [azurerm_network_interface.NIC.id]
  vm_size               = var.VM.vm_size

 storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}