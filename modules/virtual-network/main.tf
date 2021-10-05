resource "azurerm_virtual_network" "networking" {
  name                = var.virtual_network_name
  location            = var.region
  resource_group_name = var.resource_group_name
  address_space       = ["172.16.0.0/24"]

  tags = var.tags
}

resource "azurerm_subnet" "internal" {
  name                 = var.virtual_subnet_name
  virtual_network_name = azurerm_virtual_network.networking.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["172.16.0.0/24"]
  depends_on = [
    azurerm_virtual_network.networking
  ]
}

resource "azurerm_subnet_network_security_group_association" "nsg" {
  subnet_id                 = azurerm_subnet.internal.id
  network_security_group_id = var.network_security_group
  depends_on = [
    azurerm_subnet.internal
  ]
}