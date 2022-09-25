resource "azurerm_virtual_network" "main" {
  name                = var.network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}