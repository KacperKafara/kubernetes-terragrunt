terraform {
  source = "../../../modules/dns"
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
  resource_group_name = local.common_vars.locals.resource_group_name
  private_dns_zone_name = "group1.postgres.database.azure.com"
}