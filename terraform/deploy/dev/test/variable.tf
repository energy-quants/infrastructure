variable "subscription_id" {
  description = "The ID of the Azure subscription to deploy to."
  type        = string
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the resources."
  type        = map
  default     = {}
}

