resource "azurerm_virtual_network_peering" "network_one" {
  name                      = join("-", [var.vnet_one_name, "to", vnet_two_name])
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.vnet_one_name
  remote_virtual_network_id = var.vnet_two_id
}

resource "azurerm_virtual_network_peering" "network_two" {
  name                      = join("-", [var.vnet_two_name, "to", vnet_one_name])
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.vnet_two_name
  remote_virtual_network_id = var.vnet_one_id
}