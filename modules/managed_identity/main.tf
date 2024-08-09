resource "azurerm_user_assigned_identity" "managed_identity" {
  location            = var.location
  resource_group_name = var.resource_group_name
  name                = var.name
}

resource "azurerm_role_assignment" "role_assigment" {
  scope                = var.scope_id
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_user_assigned_identity.managed_identity.principal_id
}
