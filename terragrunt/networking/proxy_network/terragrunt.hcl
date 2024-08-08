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
  network_name = "proxy-vnet"
  network_address_space = ["47.48.49.0/24"]
  subnets = [
    {
      name = "k8s-subnet"
      address_prefixes = ["47.48.49.0/24"]
    },
  ]
}