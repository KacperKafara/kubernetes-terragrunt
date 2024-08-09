terraform {
  source = "../../../modules/vm"
}

include {
  path = "../../terragrunt.hcl"
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

dependency "proxy_subnet" {
  config_path = "../../networking/proxy_network"
  mock_outputs = {
    name = "proxy-subnet"
    id   = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue/subnets/proxy-subnet"
  }
}

inputs = {
  vm_name = "proxy_vm"
  resource_group_name = local.common_vars.locals.resource_group_name
  location = local.common_vars.locals.location
  admin_username = "admin"
  admin_password = "NDGlabpass123!"
  enable_identity = false
  public_ip_name = "proxy_vm-ip"
  network_interface_name = "proxy_vm-nic"
  subnet_id = dependency.proxy_subnet.outputs.id
  domain_name_label = "parkanizer-group1"
}