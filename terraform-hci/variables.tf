variable "location" {
  type        = string
  description = "Région Azure pour l'enregistrement du cluster (ex: West Europe)"
  default     = "West Europe"
}

variable "environment" {
  type        = string
  description = "Environnement cible (prod, dev, lab)"
  default     = "prod"
}

variable "project_name" {
  type        = string
  description = "Nom du projet"
  default     = "medisol"
}