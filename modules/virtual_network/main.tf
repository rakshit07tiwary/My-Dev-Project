terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# The Azure provider requires a separate block to initialize its features

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.vnet_name
  address_space       = var.vnet.address_space
  location            = var.vnet.location
  resource_group_name = var.vnet.resource_group_name
}