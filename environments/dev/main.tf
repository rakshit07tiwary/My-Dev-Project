
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
  name      = "${var.VM.prefix}-nic"
  subnet_id = module.subnet.subnet_id   # direct module output, no tfvars needed
}

module "VM" {
  source = "../../modules/virtual_machine"
  VM = var.VM
}

