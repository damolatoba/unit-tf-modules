variable "resource_group_name" {
  type        = string
  description = "Name identifier for the resource group"
}

variable "location" {
  type        = string
  description = "Location/region where component will be hosted"
}

variable "network_name" {
  type        = string
  description = "Virtual network name"
}

variable "address_space" {
  type        = list(any)
  description = "Virtual network name"
}