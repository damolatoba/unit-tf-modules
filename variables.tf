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
      nsg_name = "allow-inbound-all-public-web-access"
      nsg_rules = [
        {
          name                       = "HTTP-InboundAllow"
          priority                   = 400
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = 80
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "HTTPS-InboundAllow"
          priority                   = 401
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = 443
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
      subnet_names = ["all-web-access-public"]
    },
    {
      nsg_name = "allow-inbound-only-secure-public-web-access"
      nsg_rules = [
        {
          name                       = "HTTPS-InboundAllow"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = 443
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "HTTP-InboundDeny"
          priority                   = 101
          direction                  = "Inbound"
          access                     = "Deny"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = 80
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
      subnet_names = ["only-secure-web-access-public"]
    },
    {
      nsg_name = "allow-inbound-only-unsecure-public-web-access"
      nsg_rules = [
        {
          name                       = "HTTPS-InboundAllow"
          priority                   = 200
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = 80
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "HTTP-InboundDeny"
          priority                   = 201
          direction                  = "Inbound"
          access                     = "Deny"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = 443
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
      subnet_names = ["only-unsecure-web-access-public"]
    },
    {
      nsg_name = "allow-inbound-public-remote-ssh"
      nsg_rules = [
        {
          name                       = "SSH-InboundAllow"
          priority                   = 300
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = 22
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
      subnet_names = ["public-ssh-access-to-ec2-instance"]
    },
    {
      nsg_name = "deny-inbound-public-remote-ssh"
      nsg_rules = [
        {
          name                       = "SSH-InboundAllow"
          priority                   = 400
          direction                  = "Inbound"
          access                     = "Deny"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = 22
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
      subnet_names = []
    }
  ]
}

variable "subnet_list" {
  type        = list(any) #object({ name = string, security_group = string, address_prefix = list(any) })
  description = "value"
  default = [
    # public web access info
    {
      name             = "all-web-access-public"
      address_prefixes = "10.0.0.0/24"
    },
    {
      name             = "only-secure-web-access-public"
      address_prefixes = "10.0.10.0/24"
    },
    {
      name             = "only-unsecure-web-access-public"
      address_prefixes = "10.0.20.0/24"
    },
    {
      name             = "public-ssh-access-to-ec2-instance"
      address_prefixes = "10.0.30.0/24"
    }
  ]
}