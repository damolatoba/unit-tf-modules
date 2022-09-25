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
  resource_group_name = "double-o"
  location            = "west us"
}

module "virtual_network" {
  source              = "./azure/rg-scope/vnet"
  resource_group_name = "double-o"
  location            = "west us"
  network_name        = "main-network"
  address_space       = ["10.0.0.0/16"]
}

