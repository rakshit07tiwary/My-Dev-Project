terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# The Azure provider requires a separate block to initialize its features

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet.subnet_name
  resource_group_name  = var.subnet.resource_group_name
  virtual_network_name = var.subnet.vnet_name
  address_prefixes     = var.subnet.address_prefixes
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}