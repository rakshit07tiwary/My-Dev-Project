rg= {
    resource_group_name = "rakshit_rg"
    location = "eastus"
}

subnet = {
   subnet_name         = "subnet-myproject-dev"
   resource_group_name = "rakshit_rg"
   vnet_name           = "vnet-myproject-dev"  # Changed from virtual_network_name to vnet_name
   address_prefixes    = ["10.0.1.0/24"]
}

vnet = {
  vnet_name           = "vnet-myproject-dev"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = "rakshit_rg"
}


  
VM = {
  vm_name             = "vm-myproject-dev"
  resource_group_name = "rakshit_rg"
  location            = "eastus"
  vm_size             = "Standard_B1s"
  admin_username      = "adminuser"
  ssh_public_key_path = "~/.ssh/id_rsa.pub"
  prefix              = "myproject-dev"
}