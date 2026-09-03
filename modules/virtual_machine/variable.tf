variable "VM" {
  type = object({
    prefix              = string
    vm_name             = string
    resource_group_name = string
    location            = string
    vm_size             = string
    admin_username      = string
    ssh_public_key_path = string
  })
}
variable "subnet_id" {
  type = string
}