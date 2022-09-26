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

variable "tags" {
  type        = map(any)
  description = "value"
  default = {
    "project"     = "toba tf modules"
    "environment" = "sandbox"
  }
}

variable "security_groups" {
  type        = list(any)
  description = "value"
  default = [
    {
      nsg_name = "public_access"
      nsg_rules = [
        {
          name                       = "Allow80Access"
          priority                   = 101
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = 80
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "Allow443Access"
          priority                   = 102
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = 443
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    },
    {
      nsg_name = "private_access"
      nsg_rules = [
        {
          name                       = "Allow22RDP"
          priority                   = 200
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = 22
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "Allow3389RDP"
          priority                   = 201
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = 3389
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
  ]
}

variable "subnet_list" {
  type        = list(any) #object({ name = string, security_group = string, address_prefix = list(any) })
  description = "value"
  default = [
    {
      name             = "front-end"
      security_group   = "public"
      address_prefixes = "10.0.0.0/24"
    },
    {
      name             = "db"
      security_group   = "private"
      address_prefixes = "10.0.10.0/24"
    }
  ]
}