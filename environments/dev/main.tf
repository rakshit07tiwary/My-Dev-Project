
module "resource_group" {
  source = "../../modules/resource-group"
  rg     = var.rg
}

module "vnet" {
  source = "../../modules/virtual_network"
  vnet = merge(var.vnet, {
    resource_group_name = module.rg.resource_group_name
    location            = module.rg.location
  })
}

module "subnet" {
  source = "../../modules/subnet"
  subnet = merge(var.subnet, {
    resource_group_name = module.rg.resource_group_name
    vnet_name           = module.vnet.name
  })
}

resource "azurerm_network_interface" "NIC" {
  name                = "${var.VM.prefix}-nic"
  location            = module.rg.location
  resource_group_name = module.rg.resource_group_name

  ip_configuration {
    name                          = "${var.VM.prefix}-ipconfig"
    subnet_id                     = module.subnet.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

module "VM" {
  source = "../../modules/virtual_machine"
  VM = merge(var.VM, {
    resource_group_name = module.rg.resource_group_name
    location            = module.rg.location
  })
  subnet_id = module.subnet.subnet_id
}

