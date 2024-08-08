resource "azurerm_virtual_network_peering" "network_peering_source_to_dest" {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.source_virtual_network_name
  remote_virtual_network_id = var.dest_virtual_network_id
}

resource "azurerm_virtual_network_peering" "network_peering_dest_to_source" {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.dest_virtual_network_name
  remote_virtual_network_id = var.source_virtual_network_id
}
