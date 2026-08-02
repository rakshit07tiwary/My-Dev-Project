terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "1.15.8"
    }
  }
}

# The Azure provider requires a separate block to initialize its features
provider "azurerm" {
  features {}
}

module "resource_group" {
  source = "../../modules/resource-group"
  rg = {
    resource_group_name = var.rg_name
    location             = var.location
  }
}

module "vnet" {
  source = "../../modules/virtual_network"
  vnet = {
    resource_group_name = module.resource_group.resource_group_name
    location             = module.resource_group.location
    vnet_name            = var.vnet_name
    address_space        = var.address_space
  }

  depends_on = [module.resource_group]
}

module "subnet" {
  source = "../../modules/subnet"
  subnet = {
    resource_group_name = module.resource_group.resource_group_name
    vnet_name            = module.vnet.vnet_name
    subnet_name          = var.subnet_name
    address_prefixes     = var.address_prefixes
  }

  depends_on = [module.resource_group, module.vnet]
}