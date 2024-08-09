variable "vm_name" {
  description = "Virtual machine name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Location"
  type        = string
}

variable "admin_username" {
  description = "Admin username"
  type        = string
}

variable "admin_password" {
  description = "Admin password"
  type        = string
}

variable "enable_identity" {
  description = "Enable user managed identity"
  type        = bool
}

variable "identity_ids" {
  description = "User managed identity ids"
  type        = list(string)
}

variable "domain_name_label" {
  description = "Domain name label"
  type        = string
}

variable "public_ip_name" {
  description = "Public IP name"
  type        = string
}

variable "network_interface_name" {
  description = "Network interface name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "user_data" {
  description = "User data"
  type        = string
}
