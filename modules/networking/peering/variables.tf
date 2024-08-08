variable "name" {
  description = "Virtual network peering name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "source_virtual_network_name" {
  description = "Source virtual network name"
  type        = string
}

variable "dest_virtual_network_name" {
  description = "Destination virtual network name"
  type        = string
}

variable "source_virtual_network_id" {
  description = "Source virtual network id"
  type        = string
}

variable "dest_virtual_network_id" {
  description = "Destination virtual network id"
  type        = string
}
