
module "resource_group" {
  source = "../../modules/resource-group"
  rg     = var.rg
}

module "vnet" {
  source = "../../modules/virtual_network"
  vnet = merge(var.vnet, {
    resource_group_name = module.resource_group.name
    location            = module.resource_group.location
  })
}

module "subnet" {
  source = "../../modules/subnet"
  subnet = merge(var.subnet, {
    resource_group_name = module.resource_group.name
    vnet_name           = module.vnet.name
  })
}

resource "azurerm_network_interface" "NIC" {
  name                = "${var.VM.prefix}-nic"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  ip_configuration {
    name                          = "${var.VM.prefix}-ipconfig"
    subnet_id                     = module.subnet.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

module "VM" {
  source = "../../modules/virtual_machine"
  VM = merge(var.VM, {
    resource_group_name = module.resource_group.name
    location            = module.resource_group.location
  })
  subnet_id = module.subnet.subnet_id
}

