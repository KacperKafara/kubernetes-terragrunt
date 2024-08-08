terraform {
  source = "../../../modules/networking/network"
}

include {
  path = "../../terragrunt.hcl"
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

dependencies {
  paths = ["../../rg"]
}

inputs = {
  # RG
  resource_group_name = local.common_vars.locals.resource_group_name
  location = local.common_vars.locals.location

  # VNET
  network_name = "group1-vnet"
  network_address_space = ["47.47.0.0/16"]
  subnets = [
    {
      name = "k8s-subnet"
      address_prefixes = ["47.47.20.0/24"]
    },
    {
      name = "db-subnet"
      address_prefixes = ["47.47.10.0/24"]
      delegation_name = "db-delegation"
      delegated_service_name = "Microsoft.DBforPostgreSQL/flexibleServers"
      delegated_service_actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    },
    {
      name = "app-subnet"
      address_prefixes = ["47.47.47.0/24"]
    },
  ]
}