resource "azurerm_resource_group" "rg_medisol" {
  name     = "rg-${var.project_name}-${var.environment}-pra"
  location = var.location
  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg_medisol.name
  location            = azurerm_resource_group.rg_medisol.location
  project_name        = var.project_name
  environment         = var.environment
}

module "security" {
  source              = "./modules/security"
  resource_group_name = azurerm_resource_group.rg_medisol.name
  location            = azurerm_resource_group.rg_medisol.location
  project_name        = var.project_name
  environment         = var.environment
  vnet_id             = module.network.vnet_id
  vnet_name           = module.network.vnet_name
}

module "vpn_gateway" {
  source                = "./modules/vpn_gateway"
  resource_group_name   = azurerm_resource_group.rg_medisol.name
  location              = azurerm_resource_group.rg_medisol.location
  project_name          = var.project_name
  environment           = var.environment
  gateway_subnet_id     = module.network.gateway_subnet_id
  onprem_public_ip      = var.onprem_public_ip
  onprem_local_networks = var.onprem_local_networks
  vpn_shared_key        = var.vpn_shared_key
}

module "recovery_services" {
  source              = "./modules/recovery_services"
  resource_group_name = azurerm_resource_group.rg_medisol.name
  location            = azurerm_resource_group.rg_medisol.location
  project_name        = var.project_name
  environment         = var.environment
}