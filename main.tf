terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

locals {

}

module "resource_group" {
  source              = "./azure/sub-scope/resource-group"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

module "network_security_group" {
  source              = "./azure/rg-scope/nsg-and-rules"
  count               = length(var.security_groups)
  resource_group_name = module.resource_group.name
  location            = var.location
  nsg_name            = var.security_groups[count.index].nsg_name
  nsg_rules           = var.security_groups[count.index].nsg_rules
  tags                = var.tags
  depends_on = [
    module.resource_group.name
  ]
}

data "azurerm_network_security_group" "public" {
  name                = "public_access"
  resource_group_name = var.resource_group_name
}

data "azurerm_network_security_group" "private" {
  name                = "private_access"
  resource_group_name = var.resource_group_name
}

module "virtual_network" {
  source              = "./azure/rg-scope/vnet-and-subnets"
  resource_group_name = module.resource_group.name
  location            = var.location
  network_name        = "main-network"
  address_space       = ["10.0.0.0/16"]
  subnet_list         = var.subnet_list
  public_nsg          = data.azurerm_network_security_group.public.id
  private_nsg         = data.azurerm_network_security_group.private.id
  tags                = var.tags
  depends_on = [
    module.resource_group.name
  ]
}