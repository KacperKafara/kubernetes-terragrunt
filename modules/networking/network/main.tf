resource "azurerm_virtual_network" "system_access_network" {
  name                = var.network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.network_address_space
}

resource "azurerm_subnet" "subnet_access" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  resource_group_name  = azurerm_virtual_network.system_access_network.resource_group_name
  virtual_network_name = azurerm_virtual_network.system_access_network.name
  address_prefixes     = var.subnets[count.index].address_prefixes
  dynamic "delegation" {
    for_each = var.subnets[count.index].delegation_name != null && var.subnets[count.index].delegated_service_name != null ? [1] : []
    content {
      name = var.subnets[count.index].delegation_name
      service_delegation {
        name    = var.subnets[count.index].delegated_service_name
        actions = var.subnets[count.index].delegated_service_actions
      }
    }
  }
}

output "vnet_id" {
  value = azurerm_virtual_network.system_access_network.id
}

output "subnets" {
  value = { for subnet in azurerm_subnet.subnet_access : subnet.name => subnet }
}
