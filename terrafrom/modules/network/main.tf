resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project_name}-${var.environment}-pra"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["172.16.0.0/16"] # Espace IP de la zone de secours Azure
}

resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet" # Nom requis par Azure pour la passerelle VPN
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["172.16.0.0/24"]
}

resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet" # Nom requis pour Azure Firewall
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["172.16.1.0/24"]
}

resource "azurerm_subnet" "secours" {
  name                 = "snet-${var.project_name}-secours"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["172.16.10.0/24"]
}