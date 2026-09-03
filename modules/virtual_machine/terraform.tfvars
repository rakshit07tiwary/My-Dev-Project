VM = {
  vm_name             = "vm-myproject-dev"
  resource_group_name = "rakshit_rg"
  location            = "eastus"
  vm_size             = "Standard_B1s"
  admin_username      = "adminuser"
  ssh_public_key_path = "~/.ssh/id_rsa.pub"
}