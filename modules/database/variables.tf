variable "postgres_server_name" {
  description = "The name of the PostgreSQL server"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Location of the PostgreSQL server"
  type        = string
}

variable "postgres_version" {
  description = "Version of the PostgreSQL server"
  type        = string
}

variable "delegated_subnet_id" {
  description = "Delegated subnet ID"
  type        = string
}

variable "private_dns_zone_id" {
  description = "Private DNS zone ID"
  type        = string
}

variable "public_network_access" {
  description = "Enable public network access"
  type        = bool
}

variable "admin_login" {
  description = "Administrator login name"
  type        = string
}

variable "admin_password" {
  description = "Administrator password"
  type        = string
}

variable "sku_name" {
  description = "SKU name"
  type        = string
}

variable "storage_mb" {
  description = "Storage in MB"
  type        = number
}

variable "backup_retention_days" {
  description = "Backup retention days"
  type        = number
}

variable "geo_redundant_backup" {
  description = "Enable geo-redundant backup"
  type        = bool
}

variable "auto_grow" {
  description = "Enable auto grow"
  type        = bool
}

variable "zone" {
  description = "Availability zone"
  type        = number
}

variable "database_name" {
  description = "Name of the database"
  type        = string
}
