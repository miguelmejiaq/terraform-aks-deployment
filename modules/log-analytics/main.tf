resource "azurerm_log_analytics_workspace" "oms" {
  name                = var.oms_name
  location            = var.oms_location
  resource_group_name = var.oms_resource_group
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_log_analytics_solution" "containers_solution" {
  solution_name         = "Containers"
  workspace_resource_id = azurerm_log_analytics_workspace.oms.id
  workspace_name        = azurerm_log_analytics_workspace.oms.name
  location              = var.oms_location
  resource_group_name   = var.oms_resource_group

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Containers"
  }
}