output "hci_cluster_id" {
  value       = module.azure_stack_hci.cluster_id
  description = "L'ID Azure du cluster HCI, nécessaire pour l'enregistrement Arc sur les serveurs physiques."
}

output "hci_cluster_name" {
  value       = module.azure_stack_hci.cluster_name
  description = "Le nom du cluster HCI tel que déclaré dans Azure."
}