terraform {
  source = "../../../../modules/networking/peering"
}

include {
  path = "../../../terragrunt.hcl"
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

dependency "proxy_vnet" {
  config_path = "../../proxy_network"

  mock_outputs = {
    name = "proxy-vnet"
    id   = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue"
  }
}

dependency "k8s_vnet" {
  config_path = "../../kubernetes_network"

  mock_outputs = {
    name = "k8s-vnet"
    id   = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue"
  }
}

inputs = {
  name                        = "k8s_managment_peering"
  resource_group_name         = local.common_vars.locals.resource_group_name
  source_virtual_network_name = dependency.proxy_vnet.outputs.name
  source_virtual_network_id   = dependency.proxy_vnet.outputs.id
  dest_virtual_network_name   = dependency.k8s_vnet.outputs.name
  dest_virtual_network_id     = dependency.k8s_vnet.outputs.id
}