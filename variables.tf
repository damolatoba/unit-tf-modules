variable "resource_group_name" {
  type        = string
  description = "Name identifier for the resource group"
  default     = "double-o"
}

variable "location" {
  type        = string
  description = "Location/region where component will be hosted"
  default     = "west us"
}