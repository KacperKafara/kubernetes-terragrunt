resource "azurerm_kubernetes_cluster" "kubernetes_cluster_group1" {
  name                    = var.kubernetes_cluster_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  dns_prefix              = var.dns_prefix
  kubernetes_version      = var.kubernetes_version
  private_cluster_enabled = true
  sku_tier                = "Free"

  network_profile {
    network_plugin = "azure"
  }

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_B2ms"
    os_disk_size_gb = 30
    vnet_subnet_id  = var.default_node_pool_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "extra_node_pool" {
  count                 = length(var.extra_node_pools)
  name                  = var.extra_node_pools[count.index].name
  vm_size               = "Standard_B2ms"
  node_count            = var.extra_node_pools[count.index].node_count
  vnet_subnet_id        = var.extra_node_pools[count.index].vnet_subnet_id
  kubernetes_cluster_id = azurerm_kubernetes_cluster.kubernetes_cluster_group1.id

  node_labels = {
    "nodepool" = var.extra_node_pools[count.index].node_label
  }
}
