variable "rg" {}

variable "vnet" {}

variable "subnet" {}

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