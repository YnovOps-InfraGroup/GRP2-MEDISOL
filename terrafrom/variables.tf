variable "location" {
  type        = string
  description = "Région Azure cible pour le déploiement du PRA"
  default     = "West Europe"
}

variable "environment" {
  type        = string
  description = "Environnement cible (prod, dev, pra)"
  default     = "prod"
}

variable "project_name" {
  type        = string
  description = "Nom du projet"
  default     = "medisol"
}

variable "onprem_public_ip" {
  type        = string
  description = "Adresse IP publique du Firewall OPNsense local pour le tunnel VPN S2S"
}

variable "onprem_local_networks" {
  type        = list(string)
  description = "Liste des sous-réseaux locaux (VLANs de l'infra Azure Stack HCI) à router"
  default     = ["10.10.0.0/16"]
}

variable "vpn_shared_key" {
  type        = string
  description = "Clé pré-partagée (PSK) pour le tunnel VPN de secours"
  sensitive   = true
}