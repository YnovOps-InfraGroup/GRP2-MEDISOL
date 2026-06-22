# 🚀 Déploiement Terraform - Plan de Reprise d'Activité (PRA) MEDISOL

Ce dossier contient le code **Infrastructure as Code (IaC)** Terraform permettant de déployer la zone de secours (PRA) du projet **MEDISOL** sur le Cloud public Microsoft Azure. 

Ce socle permet d'accueillir les réplicats de notre cluster local Azure Stack HCI et d'établir un tunnel VPN IPsec sécurisé (Zero Trust) avec notre pare-feu OPNsense on-premise.

---

## 📋 Table des matières
1. [Architecture déployée](#-architecture-déployée)
2. [Prérequis](#-prérequis)
3. [Configuration initiale](#-configuration-initiale)
4. [Instructions de déploiement](#-instructions-de-déploiement)
5. [Actions Post-Déploiement (Côté OPNsense)](#-actions-post-déploiement-côté-opnsense)
6. [Destruction de l'environnement](#-destruction-de-lenvironnement)

---

## 🏗 Architecture déployée

L'exécution de ce code Terraform créera les ressources suivantes dans Azure :
* Un **Resource Group** dédié.
* Un **Virtual Network (VNet)** de secours avec ses sous-réseaux (GatewaySubnet, AzureFirewallSubnet, Secours).
* Un **Virtual Network Gateway (Passerelle VPN)** Azure avec une adresse IP publique statique.
* Un **Local Network Gateway** représentant notre site on-premise.
* Une **Connexion IPsec Site-à-Site (S2S)** entre Azure et OPNsense.
* Un **Recovery Services Vault** configuré avec stockage géo-redondant (GRS) et protection contre la suppression accidentelle (Soft Delete).

---

## ⚙️ Prérequis

Avant de commencer, assurez-vous de disposer de :
1. **Terraform** installé sur votre machine (version `>= 1.5.0`).
2. **Azure CLI** installé.
3. Un compte Microsoft Azure avec les droits de **Contributeur** sur l'abonnement cible.
4. L'**adresse IP publique** de votre firewall OPNsense de production.

---

## 🛠 Configuration initiale

1. Clonez le dépôt et naviguez dans le dossier `terraform` :
   ```bash
   cd GRP2-MEDISOL/terraform
   ```

2. Créez et remplissez le fichier des variables. Le fichier `terraform.tfvars` a été ajouté au `.gitignore` pour éviter de pousser des secrets (comme la PSK du VPN) sur le dépôt public.
   
   Créez un fichier nommé `terraform.tfvars` à la racine du dossier `terraform` avec le contenu suivant, puis adaptez les valeurs à votre environnement :

   ```hcl
   location              = "West Europe"
   environment           = "prod"
   project_name          = "medisol"
   onprem_public_ip      = "198.51.100.1" # [À REMPLACER] IP publique du OPNsense
   onprem_local_networks = [
     "10.10.10.0/24", # [À REMPLACER] Réseaux locaux à router dans le tunnel
     "10.10.20.0/24"
   ]
   vpn_shared_key        = "VOTRE_MOT_DE_PASSE_TRES_COMPLEXE_ICI!" # [À REMPLACER]
   ```

---

## 🚀 Instructions de déploiement

### 1. Authentification Azure
Connectez-vous à votre tenant Azure via la ligne de commande :
```bash
az login
```
*(Sélectionnez le bon abonnement si vous en avez plusieurs via `az account set --subscription <ID>`)*

### 2. Initialisation de Terraform
Téléchargez les dépendances et le provider `azurerm` :
```bash
terraform init
```

### 3. Planification (Validation)
Vérifiez ce que Terraform s'apprête à créer. Cela permet de valider la syntaxe et les valeurs des variables :
```bash
terraform plan
```

### 4. Application (Déploiement)
Lancez le déploiement sur l'infrastructure Azure (le déploiement de la passerelle VPN prend environ **25 à 45 minutes**) :
```bash
terraform apply
```
Validez par `yes` lorsque le terminal vous le demande.

---

## 🔗 Actions Post-Déploiement (Côté OPNsense)

À la fin de l'exécution, Terraform affichera un bloc `Outputs` dans votre terminal contenant l'IP publique générée pour Azure :

```text
Outputs:
resource_group_name = "rg-medisol-prod-pra"
vpn_gateway_public_ip = "X.X.X.X"
```

Vous devez maintenant configurer le firewall on-premise :
1. Connectez-vous à l'interface d'administration **OPNsense**.
2. Allez dans **VPN > IPsec > Tunnel Settings**.
3. Créez une nouvelle Phase 1 pointant vers l'adresse `vpn_gateway_public_ip` (X.X.X.X) fournie par Terraform.
4. Renseignez la **Pre-Shared Key** (`vpn_shared_key`) identique à celle de votre `terraform.tfvars`.
5. Configurez la Phase 2 pour router vos sous-réseaux locaux vers le VNet Azure (`172.16.0.0/16`).

---

## 🗑 Destruction de l'environnement

Pour des raisons de coûts, si vous souhaitez détruire cet environnement de secours (par exemple lors de tests ou en fin de projet) :

```bash
terraform destroy
```
Validez par `yes` pour supprimer définitivement toutes les ressources Azure gérées par ce code.