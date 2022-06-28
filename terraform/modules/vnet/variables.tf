variable "name" {
  description = <<-EOF
    Specifies the name of the resource.
    Changing this forces a new resource to be created.
  EOF
  type = string
}

variable "location" {
  description = <<-EOF
    Specifies the supported Azure location where the resource exists.
    Changing this forces a new resource to be created.
  EOF
  type = string
}

variable "resource_group_name" {
  description = <<-EOF
    The name of the resource group in which to create the resource.
  EOF
  type = string
}

variable "address_space" {
  description = "The address spaces used for the virtual network."
  type        = list(string)
}

variable "dns_servers" {
  description = "List of IP addresses of DNS servers to be used."
  type        = optional(list(string))
  default     = null
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the Resource Group."
  type        = map
  default     = {}
}
