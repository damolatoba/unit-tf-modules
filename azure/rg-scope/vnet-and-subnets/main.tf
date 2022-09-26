resource "azurerm_virtual_network" "main" {
  name                = var.network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  dynamic "subnet" {
    for_each = var.subnet_list
    content {
      name           = subnet.value["name"]
      address_prefix = subnet.value["address_prefixes"]
      security_group = subnet.value["security_group"] == "public" ? var.public_nsg : var.private_nsg
    }
  }

  tags = var.tags
}