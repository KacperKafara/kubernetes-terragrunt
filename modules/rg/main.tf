resource "azurerm_resource_group" "resource_group_kubernetes_group1" {
  name     = var.name
  location = var.location
}

output "resource_group_name" {
  value = azurerm_resource_group.resource_group_kubernetes_group1.name
}

output "resource_group_location" {
  value = azurerm_resource_group.resource_group_kubernetes_group1.location
}

output "resource_group_id" {
  value = azurerm_resource_group.resource_group_kubernetes_group1.id
}