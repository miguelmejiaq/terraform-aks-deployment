resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resourceGroup
  dns_prefix          = var.cluster_name

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }
  addon_profile {
    oms_agent {
        enabled = true
        log_analytics_workspace_id = var.oms_id
    }
  }
  tags = var.tags
}