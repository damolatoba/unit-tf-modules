variable "resource_group_name" {
  type        = string
  description = "Name identifier for the resource group"
}

variable "location" {
  type        = string
  description = "Location/region where component will be hosted"
}

variable "tags" {
  type        = map(any)
  description = "value"
}

variable "virtual_network_name" {
  type        = string
  description = "value"
}

variable "nsg_name" {
  type        = string
  description = "value"
}

variable "nsg_rules" {
  type        = list(any)
  description = "value"
}

variable "subnet_names" {
  type        = list(any)
  description = "value"
}