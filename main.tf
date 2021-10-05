###########################
#   TERRAFORM BACKEND     #
###########################
terraform {
    backend "azurerm" {
        
    }
}
###########################
#    RESOURCE GROUPS      #
###########################

module "oms_resource_group" {
    source = "./modules/resource-group"
    resource_group_name = var.oms_resource_group_name
    region = var.var_azure_region
    tags = merge(var.tags, {"PURPOSE" = "Resource Group for OMS"})
}

module "network_resource_group" {
    source = "./modules/resource-group"
    resource_group_name = var.network_resource_group_name
    region = var.var_azure_region
    tags = merge(var.tags, {"PURPOSE" = "Resource Group for Networking layer"})
}

module "aks_resource_group" {
    source = "./modules/resource-group"
    resource_group_name = var.aks_resource_group_name
    region = var.var_azure_region
    tags = merge(var.tags, {"PURPOSE" = "Resource Group for AKS"})
}

###########################
#    LOG ANALYTICS WS     #
###########################

module "aks_oms"{
    source = "./modules/log-analytics"
    oms_name = var.oms_name
    oms_location = module.oms_resource_group.location
    oms_resource_group = module.oms_resource_group.name
    tags = merge(var.tags, {"PURPOSE" = "OMS for AKS"})
    depends_on = [
       module.oms_resource_group
    ]
}

###########################
#  NETWORK SECURITY GROUP #
###########################

module "aks_network_security_group" {
    source = "./modules/network-security-group"
    network_security_group = var.network_security_group_name
    region = module.network_resource_group.location
    resource_group_name = module.network_resource_group.name
    tags = merge(var.tags, { "PURPOSE" = "Network Security Group for AKS Node Pool"})
    depends_on = [
      module.network_resource_group
    ]
}

###########################
#    VIRTUAL NETWORK      #
###########################

module "aks_networking" {
    source = "./modules/virtual-network"
    virtual_network_name = var.virtual_network_name
    region = module.network_resource_group.location
    resource_group_name = module.network_resource_group.name
    virtual_subnet_name = var.virtual_subnet_name
    network_security_group = module.aks_network_security_group.id
    tags = merge(var.tags, {"PURPOSE" = "Virtual Network for AKS Node Pools"})
    depends_on = [
      module.network_resource_group,
      module.aks_network_security_group
    ]
}

###########################
# AZURE KUBERNETES SERVICE#
###########################

module "aks_cluster" {
    source = "./modules/azure-kubernetes-service"
    cluster_name = var.aks_cluster_name
    location = module.aks_resource_group.location
    resourceGroup = module.aks_resource_group.name    
    oms_id = module.aks_oms.id
    tags = merge(var.tags, {"PURPOSE" = "Azure Kubernetes Service"})
    subnet_id = module.aks_networking.internal_subnet_id
    depends_on = [
      module.aks_networking,
      module.aks_oms
    ]
}