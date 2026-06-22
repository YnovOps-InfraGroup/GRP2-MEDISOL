resource "azurerm_public_ip" "fw_pip" {
  name                = "pip-fw-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}