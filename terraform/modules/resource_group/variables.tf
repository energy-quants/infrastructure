variable "name" {
  description = <<-EOF
    The Azure region where the resource group should exist.
    Changing this forces a new resource group to be created.
  EOF
  type = string
}

variable "location" {
  description = <<-EOF
    The Azure region where the resource group should exist.
    Changing this forces a new resource group to be created.
  EOF
  type = string
}

variable "append_uid" {
  description = "Whether or not to append a unique hash to the resource name"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the resource group."
  type        = map
  default     = {}
}
