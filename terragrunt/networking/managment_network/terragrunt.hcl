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
  network_name = "managment-vnet"
  network_address_space = ["47.48.47.0/24"]
  subnets = [
    {
      name = "managment-subnet"
      address_prefixes = ["47.48.47.0/24"]
    },
  ]
}