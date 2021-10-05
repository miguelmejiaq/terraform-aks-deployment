resource "azurerm_network_security_group" "nsg" {
  name                = var.network_security_group
  location            = var.region
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = "AllowInternetTraffic"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  tags                = var.tags
}
