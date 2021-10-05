output "id" {
  value = resource.azurerm_kubernetes_cluster.aks.id
}

output "kube_config" {
  value = resource.azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "client_key" {
  value = resource.azurerm_kubernetes_cluster.aks.kube_config.0.client_key
}

output "client_certificate" {
  value = resource.azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
}

output "cluster_ca_certificate" {
  value = resource.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
}

output "host" {
  value = resource.azurerm_kubernetes_cluster.aks.kube_config.0.host
}