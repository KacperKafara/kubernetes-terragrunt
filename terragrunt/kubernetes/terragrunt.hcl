terraform {
  source = "../../modules/kubernetes"
}

include {
  path = "../terragrunt.hcl"
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

dependencies {
  paths = ["../rg"]
}

dependency "networking" {
  config_path = "../networking/kubernetes_network"

  mock_outputs = {
    subnets = {
      k8s-subnet = {
        name = "k8s-subnet"
        id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue/subnets/subnet"
      }
    }
  }
}

inputs = {
  # RG
  resource_group_name = local.common_vars.locals.resource_group_name
  location = local.common_vars.locals.location

  # AKS
  kubernetes_cluster_name = "group1-aks"
  dns_prefix = "group1-aks"
  kubernetes_version = "1.28.9"
  default_node_pool_subnet_id = dependency.networking.outputs.subnets["k8s-subnet"].id
  extra_node_pools = [
    {
      name = "backendpool"
      node_count = 2
      vnet_subnet_id = dependency.networking.outputs.subnets["k8s-subnet"].id
      node_label = "backend"
    },
    {
      name = "frontendpool"
      node_count = 1
      vnet_subnet_id = dependency.networking.outputs.subnets["k8s-subnet"].id
      node_label = "frontend"
    },
  ]
}