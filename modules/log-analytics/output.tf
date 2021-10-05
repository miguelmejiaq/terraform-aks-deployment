output "id" {
    value = resource.azurerm_log_analytics_workspace.oms.id
}

output "shared_key" {
    value = resource.azurerm_log_analytics_workspace.oms.primary_shared_key
}

output "workspace_id" {
    value = resource.azurerm_log_analytics_workspace.oms.workspace_id  
}