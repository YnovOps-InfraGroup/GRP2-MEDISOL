resource "azurerm_public_ip" "vpn_pip" {
  name                = "pip-vpngw-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_virtual_network_gateway" "vpngw" {
  name                = "vpngw-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1" # Idéal pour un équilibre performances / coûts PRA

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gateway_subnet_id
  }
}

resource "azurerm_local_network_gateway" "onprem" {
  name                = "lngw-${var.project_name}-onprem"
  location            = var.location
  resource_group_name = var.resource_group_name
  gateway_address     = var.onprem_public_ip
  address_space       = var.onprem_local_networks
}

resource "azurerm_virtual_network_gateway_connection" "s2s" {
  name                = "conn-${var.project_name}-s2s-to-opnsense"
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpngw.id
  local_network_gateway_id   = azurerm_local_network_gateway.onprem.id

  shared_key = var.vpn_shared_key
}