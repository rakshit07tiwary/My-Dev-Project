
module "resource_group" {
  source = "../../modules/resource-group"
  rg  = var.rg
}

module "vnet" {
  source = "../../modules/virtual_network"
  vnet = var.vnet
}

module "subnet" {
  source = "../../modules/subnet"
  subnet = var.subnet
}

resource "azurerm_network_interface" "NIC" {
  name                = "${var.VM.prefix}-nic"
  location            = var.rg.location
  resource_group_name = var.rg.name

  ip_configuration {
    name                          = "${var.VM.prefix}-ipconfig"
    subnet_id                     = module.subnet.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

module "VM" {
  source    = "../../modules/virtual_machine"
  VM        = var.VM
  subnet_id = module.subnet.subnet_id
}

