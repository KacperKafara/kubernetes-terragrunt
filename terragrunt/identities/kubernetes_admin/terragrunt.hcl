terraform {
  source = "../../../modules/managed_identity"
}

include {
  path = "../../terragrunt.hcl"
}

locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

dependency "resource_group" {
  config_path = "../../rg"
  mock_outputs = {
    name = "example-resource-group"
    id   = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group"
  }
}

inputs = {
  location = local.common_vars.locals.location
  resource_group_name = local.common_vars.locals.resource_group_name
  name = "kubernetes-admin-managed-identity"
  scope_id = dependency.resource_group.outputs.resource_group_id
  role_definition_name = "Azure Kubernetes Service Cluster Admin Role"
}