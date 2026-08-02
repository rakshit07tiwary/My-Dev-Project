terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# The Azure provider requires a separate block to initialize its features


resource "azurerm_resource_group" "rgs" {
  name     = var.rg.resource_group_name
  location = var.rg.location
}