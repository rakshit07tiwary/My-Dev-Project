variable "vnet" {
  type = object({
    resource_group_name = string
    location            = string
    vnet_name           = string
    address_space       = list(string)
  })
}