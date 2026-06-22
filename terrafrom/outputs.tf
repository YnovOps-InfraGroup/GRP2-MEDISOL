output "resource_group_name" {
  value       = azurerm_resource_group.rg_medisol.name
  description = "Nom du Resource Group créé dans Azure"
}

output "vpn_gateway_public_ip" {
  value       = module.vpn_gateway.public_ip
  description = "IP publique de la passerelle Azure à configurer sur votre OPNsense local"
}