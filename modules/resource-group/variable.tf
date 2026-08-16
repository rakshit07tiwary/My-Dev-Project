variable "rg" {
  type = object({
    resource_group_name = string
    location            = string
  })
}