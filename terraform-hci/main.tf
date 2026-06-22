# Création d'un Resource Group dédié pour l'infra On-Premise
resource "azurerm_resource_group" "rg_hci" {
  name     = "rg-${var.project_name}-${var.environment}-onprem"
  location = var.location
  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Zone        = "On-Premise"
  }
}

# 1. Déclaration du Cluster HCI et du Réseau Logique
module "azure_stack_hci" {
  source              = "./modules/hci"
  resource_group_name = azurerm_resource_group.rg_hci.name
  location            = azurerm_resource_group.rg_hci.location
  project_name        = var.project_name
  environment         = var.environment
}

# 2. Déploiement des VMs Locales (AD et Serveur de Fichiers)
module "vms_local" {
  source              = "./modules/vms_local"
  resource_group_name = azurerm_resource_group.rg_hci.name
  location            = azurerm_resource_group.rg_hci.location
  project_name        = var.project_name
  environment         = var.environment

  # L'ID du réseau logique local généré par le module HCI
  logical_network_id  = module.azure_stack_hci.logical_network_id
}

# 3. Déploiement du cluster AKS local (Micro-services MEDISOL)
module "aks_local" {
  source              = "./modules/aks_local"
  resource_group_name = azurerm_resource_group.rg_hci.name
  location            = azurerm_resource_group.rg_hci.location
  project_name        = var.project_name
  environment         = var.environment

  # L'ID du réseau logique local
  logical_network_id  = module.azure_stack_hci.logical_network_id
}