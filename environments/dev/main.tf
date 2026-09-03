
module "resource_group" {
  source = "../../modules/resource-group"
  rg     = var.rg
}

module "vnet" {
  source = "../../modules/virtual_network"
  vnet   = var.vnet

  depends_on = [module.resource_group]
}

module "subnet" {
  source = "../../modules/subnet"
  subnet = var.subnet

  depends_on = [module.resource_group, module.vnet]
}

resource "azurerm_network_interface" "NIC" {
  name                = "${var.VM.prefix}-nic"
  location            = var.rg.location
  resource_group_name = var.rg.resource_group_name

  depends_on = [module.resource_group, module.subnet]

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

  depends_on = [module.resource_group, module.subnet]
}

