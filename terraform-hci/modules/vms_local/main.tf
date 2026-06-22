# 1. Contrôleur de Domaine (Identité Locale AD)
resource "azurerm_azure_stack_hci_virtual_machine" "ad_local" {
  name                = "vm-${var.project_name}-ad-01"
  resource_group_name = var.resource_group_name
  location            = var.location

  # Nécessite la Custom Location générée par Azure Arc
  # custom_location_id = var.custom_location_id

  network_interface {
    name = "nic-ad-01"
    # ip_configuration { subnet_id = var.logical_network_id }
  }

  os_profile {
    windows_configuration {
      provision_vm_agent = true
    }
  }

  tags = {
    Role = "ActiveDirectory"
    Zone = "On-Premise"
  }
}

# 2. Serveur de Fichiers (Storage Spaces Direct)
resource "azurerm_azure_stack_hci_virtual_machine" "fs_local" {
  name                = "vm-${var.project_name}-fs-01"
  resource_group_name = var.resource_group_name
  location            = var.location

  # custom_location_id = var.custom_location_id

  network_interface {
    name = "nic-fs-01"
    # ip_configuration { subnet_id = var.logical_network_id }
  }

  tags = {
    Role = "FileServer"
    Zone = "On-Premise"
  }
}