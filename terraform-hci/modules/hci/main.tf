# 1. Déclaration du cluster Azure Stack HCI
resource "azurerm_azure_stack_hci_cluster" "hci_cluster" {
  name                = "cl-hci-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location

  # L'identité SystemAssigned est obligatoire pour Azure Arc
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Type = "HyperConverged"
  }
}

# 2. Déclaration du réseau logique (Lien entre le VLAN SERVEUR physique et Azure)
resource "azurerm_azure_stack_hci_logical_network" "vlan_serveur" {
  name                = "lnet-${var.project_name}-vlan-serveur"
  resource_group_name = var.resource_group_name
  location            = var.location

  # Note : En production, l'attribut 'custom_location_id' est requis.
  # Il ne peut être renseigné qu'APRÈS avoir exécuté Register-AzStackHCI sur vos serveurs physiques.
  # custom_location_id = "/subscriptions/.../resourceGroups/.../providers/Microsoft.ExtendedLocation/customLocations/..."

  tags = {
    VLAN = "SERVEUR"
  }
}