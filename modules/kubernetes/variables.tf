variable "kubernetes_cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "location" {
  description = "Location of the Kubernetes cluster"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the Kubernetes cluster"
  type        = string
}

variable "default_node_pool_subnet_id" {
  description = "ID of the subnet for the default node pool"
  type        = string
}

variable "kubernetes_version" {
  description = "Version of Kubernetes"
  type        = string
}

variable "extra_node_pools" {
  description = "A list of additional node pools"
  type = list(object({
    name       = string
    node_count = number
    vnet_subnet_id = string
    node_label = string
  }))
  default = []
}
