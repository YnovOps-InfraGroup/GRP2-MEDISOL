# Déploiement du cluster Kubernetes directement sur l'infrastructure physique
resource "azurerm_kubernetes_cluster" "aks_hci" {
  name                = "aks-${var.project_name}-${var.environment}-local"
  location            = var.location
  resource_group_name = var.resource_group_name

  # custom_location_id  = var.custom_location_id

  dns_prefix          = "${var.project_name}aks"

  default_node_pool {
    name       = "default"
    node_count = 3 # Redondance pour les applications critiques
    vm_size    = "Standard_D4s_v3"
    # vnet_subnet_id = var.logical_network_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico" # Sécurité réseau des pods
  }

  tags = {
    Role      = "AKS-Local"
    Zone      = "On-Premise"
    ManagedBy = "Azure-Arc"
  }
}