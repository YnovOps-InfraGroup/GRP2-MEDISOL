output "cluster_id" {
  value = azurerm_azure_stack_hci_cluster.hci_cluster.id
}

output "cluster_name" {
  value = azurerm_azure_stack_hci_cluster.hci_cluster.name
}

output "logical_network_id" {
  value = azurerm_azure_stack_hci_logical_network.vlan_serveur.id
}