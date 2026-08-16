variable "rg" {
  type = object({
    resource_group_name = string
    location            = string
  })
}
variable "vnet" {
  type = object({
    vnet_name           = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
  })
}

variable "subnet" {
  type = object({
    subnet_name          = string
    resource_group_name  = string
    vnet_name = string
    address_prefixes     = list(string)
  })
}

variable "VM" {
  type = object({
    vm_name             = string
    resource_group_name = string
    location            = string
    vm_size             = string
    admin_username      = string
    ssh_public_key_path = string
    prefix              = string
  })
}