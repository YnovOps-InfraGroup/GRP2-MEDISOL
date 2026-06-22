# 🏢 Déploiement Terraform - Infrastructure Locale (Azure Stack HCI) MEDISOL

Ce dossier contient le code **Infrastructure as Code (IaC)** Terraform dédié à la gestion de l'infrastructure physique locale (On-Premise) du projet **MEDISOL** via le prisme du Cloud Hybride.

L'objectif est d'utiliser **Azure Arc** pour déclarer, lier et manager nos serveurs physiques locaux, nos machines virtuelles (Identité, Fichiers) et notre cluster Kubernetes (AKS) directement depuis la console Azure.

---

## 📋 Table des matières
1. [Architecture gérée](#-architecture-gérée)
2. [Prérequis](#-prérequis)
3. [Processus de Déploiement Hybride (Important)](#-processus-de-déploiement-hybride-important)
4. [Détail de l'arborescence](#-détail-de-larborescence)
5. [Destruction](#-destruction)

---

## 🏗 Architecture gérée

L'exécution de ce code interagit avec l'infrastructure de production locale pour créer et gérer :
* Le **Cluster logique Azure Stack HCI** dans l'abonnement Azure (pont de management).
* Le **Réseau Logique (Logical Network)** reliant le VLAN physique `SERVEUR` au cloud.
* Les **Machines Virtuelles Locales** via l'Arc Resource Bridge :
  * Contrôleur de Domaine (Active Directory).
  * Serveur de Fichiers (Storage Spaces Direct).
* Un **Cluster AKS (Azure Kubernetes Service) local**, provisionné sur le matériel physique pour héberger les micro-services MEDISOL.

---

## ⚙️ Prérequis

1. **Matériel :** Serveurs physiques (ou nœuds virtuels nested) installés avec l'OS *Azure Stack HCI*.
2. **Outils :** Terraform (`>= 1.5.0`), Azure CLI, PowerShell.
3. **Droits :** Un compte Azure avec les permissions d'enregistrement de cluster HCI et Azure Arc.

---

## 🚀 Processus de Déploiement Hybride (Important)

Contrairement à un déploiement 100% Cloud, le provisionnement sur Azure Stack HCI nécessite une approche en **3 phases** pour faire le lien entre le Cloud et le matériel physique.

### Phase 1 : Déclaration des ressources logiques (Cloud)
Initialisez et appliquez le socle de base dans Azure :
```bash
terraform init
terraform apply -target=module.azure_stack_hci
```
*Note : Cette étape crée la coquille vide du cluster dans Azure.*

### Phase 2 : Enregistrement du matériel physique (On-Premise)
Connectez-vous sur l'un de vos nœuds physiques locaux via PowerShell et exécutez le script d'enregistrement Arc en utilisant le nom généré par Terraform lors de la Phase 1 :
```powershell
Register-AzStackHCI -SubscriptionId "<VOTRE_SUBSCRIPTION_ID>" -ResourceGroupName "rg-medisol-prod-onprem" -ClusterName "cl-hci-medisol-prod"
```
*Cette commande va générer une `custom_location_id` dans Azure, prouvant que vos serveurs sont prêts à recevoir des charges de travail.*

### Phase 3 : Déploiement des applicatifs locaux (Hybride)
Maintenant que le lien Arc est établi :
1. Dans les fichiers `modules/vms_local/main.tf` et `modules/aks_local/main.tf`, **décommentez** les lignes `custom_location_id` et `ip_configuration`.
2. Relancez Terraform pour déployer concrètement les VMs et le cluster Kubernetes sur vos serveurs locaux :
```bash
terraform apply
```

---

## 📂 Détail de l'arborescence

```text
/terraform-HCI
├── providers.tf           # Configuration AzureRM
├── variables.tf           # Variables globales
├── main.tf                # Orchestrateur des modules
├── outputs.tf             # ID et Noms nécessaires pour la Phase 2
├── terraform.tfvars       # Fichier d'environnement (Non versionné en Prod)
└── modules/
    ├── hci/               # Déclaration du Cluster et du Réseau Logique
    ├── vms_local/         # Déploiement des VMs AD et File Server
    └── aks_local/         # Déploiement du cluster Kubernetes sur HCI
```

---

## 🗑 Destruction

Pour supprimer les ressources gérées par Terraform :
```bash
terraform destroy
```
*⚠️ Attention : Cela supprimera les machines virtuelles locales et le cluster AKS hébergés sur vos serveurs physiques.*