terraform {
   source = "../../modules/rg"
}

include {
  path = "../terragrunt.hcl"
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

inputs = {
  name = local.common_vars.locals.resource_group_name
  location = local.common_vars.locals.location
}