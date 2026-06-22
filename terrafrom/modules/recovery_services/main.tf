resource "azurerm_recovery_services_vault" "vault" {
  name                = "rsv-${var.project_name}-${var.environment}-pra"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  soft_delete_enabled = true # Rétention de sécurité obligatoire anti-ransomware
  storage_mode_type   = "GeoRedundant" # GRS pour la réplication géographique des données
}