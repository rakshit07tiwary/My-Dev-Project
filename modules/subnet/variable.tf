variable "subnet" {
  type = object({
    resource_group_name = string
    vnet_name           = string
    subnet_name         = string
    address_prefixes    = list(string)
  })
}