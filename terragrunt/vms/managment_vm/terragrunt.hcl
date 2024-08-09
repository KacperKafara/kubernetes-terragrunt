terraform {
  source = "../../../modules/vm"
}

include {
  path = "../../terragrunt.hcl"
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

dependency "managment_subnet" {
  config_path = "../../networking/managment_network"
  mock_outputs = {
    name = "managment-subnet"
    id   = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue/subnets/managment-subnet"
  }
}

dependency "managed_identity" {
  config_path = "../../identities/kubernetes_admin"
  mock_outputs = {
    name = "kubernetes-admin-managed-identity"
    id   = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.ManagedIdentity/userAssignedIdentities/kubernetes-admin-managed-identity"
  }
}

inputs = {
  vm_name = "managment_vm"
  resource_group_name = local.common_vars.locals.resource_group_name
  location = local.common_vars.locals.location
  admin_username = "admin"
  admin_password = "NDGlabpass123!"
  enable_identity = true
  identity_ids = [dependency.managed_identity.outputs.id]
  public_ip_name = "managment_vm-ip"
  network_interface_name = "managment_vm-nic"
  subnet_id = dependency.managment_subnet.outputs.subnets["managment-subnet"].id
}