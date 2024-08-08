variable "network_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "network_address_space" {
  description = "The address space that is used the virtual network"
  type        = list(string)
}

variable "location" {
  description = "The location of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnets" {
  description = "The subnets that are part of the virtual network"
  type        = list(object({
    name             = string
    address_prefixes = list(string)
    delegation_name  = optional(string)
    delegated_service_name = optional(string)
    delegated_service_actions = optional(list(string))
  }))
}