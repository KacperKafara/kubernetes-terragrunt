terraform {
  source = "../../../modules/database"
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

dependency "networking" {
  config_path = "../../networking"

  mock_outputs = {
    subnets = {
      db-subnet = {
        name = "db-subnet"
        id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue/subnets/subnet"
      }
    }
  }
}

dependency "dns" {
  config_path = "../dns"

  mock_outputs = {
    id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/privateDnsZones/private-dns-zone-database"
  }
}

inputs = {
  # RG
  resource_group_name = local.common_vars.locals.resource_group_name
  location = local.common_vars.locals.location

  # Server
  postgres_server_name = "group1-postgres"
  postgres_version = "13"
  delegated_subnet_id = dependency.networking.outputs.subnets["db-subnet"].id
  private_dns_zone_id = dependency.dns.outputs.id
  public_network_access = false
  admin_login = "postgreDBAdmin"
  admin_password = "P@ssw0rd"
  sku_name = "B_Standard_B1ms"
  storage_mb = 32768
  backup_retention_days = 7
  geo_redundant_backup = false
  auto_grow = false
  zone = 1

  # Database
  database_name = "parkanizer"
}