# Document d'Architecture Technique (DAT)
## Projet MEDISOL - Architecture Cible Hybride

**Statut :** Version Finale 
**Technologies :** Azure Stack HCI, Microsoft Azure Cloud  
**Périmètre :** Datacenter Local & Plan de Continuité / Reprise d'Activité (PCA/PRA)  

---

## 1. Contexte et Objectifs de l'Architecture
Le présent Document d'Architecture Technique (DAT) détaille l'infrastructure cible du projet **MEDISOL**. Face aux exigences strictes inhérentes au traitement et à l'hébergement de données (notamment médicales), l'architecture s'oriente vers un modèle d'infrastructure hybride hautement résilient.

Le choix technologique se porte sur **Azure Stack HCI** pour l'infrastructure locale (on-premise), offrant les performances et la gouvernance nécessaires, couplé à un **Plan de Reprise d'Activité (PRA) dans le cloud Microsoft Azure**, garantissant la continuité de service en cas de sinistre majeur.

## 2. Cœur de Réseau et Sécurité Périmétrique
L'accès externe et la distribution interne sont structurés pour minimiser la surface d'attaque tout en assurant un flux optimal des données.
* **Arrivée Opérateur :** Connexion Internet / Fibre redondée aboutissant sur le périmètre de sécurité.
* **Firewall On-Premise :** Point d'entrée unique de l'infrastructure locale, responsable du filtrage des flux entrants/sortants et de l'établissement des tunnels VPN.
* **Cœur de Réseau (Core) :** Une "Stack de Switchs Core" assure la distribution à très haut débit vers l'ensemble des zones du système d'information.

## 3. Micro-Segmentation et VLANs
La sécurité par conception (*Secure by Design*) s'appuie sur une micro-segmentation stricte des flux locaux. L'architecture décline les réseaux virtuels (VLANs) suivants :

| Segment Réseau (VLAN) | Description & Usage | Niveau d'Isolation |
| :--- | :--- | :--- |
| **VLAN Admin** | Réseau de management dédié à l'administration des équipements (interfaces IPMI, iLO, administration de la stack HCI). | Critique (Isolé) |
| **VLAN SERVEUR** | Héberge l'infrastructure de production principale (Cluster Azure Stack HCI) et ses services transverses. | Élevé |
| **VLAN Médical** | Dédié aux équipements et terminaux médicaux nécessitant des politiques de conformité strictes. | Élevé |
| **VLAN Prod_Clients** | Zone de production dédiée aux interactions clients, segmentée avec un sous-réseau "VLAN High Ticket" pour les flux prioritaires/sensibles. | Moyen / Élevé |
| **VLAN Accueil** | Réseau affecté aux postes de travail de l'accueil administratif. | Standard |
| **VLANs Wi-Fi** | Séparation logique gérée par les bornes Wi-Fi entre le réseau "Wi-Fi Corporate" (collaborateurs) et "Wi-Fi Guest" (visiteurs, accès Internet pur). | Isolé (Guest) |

## 4. Infrastructure Locale (On-Premise) : Azure Stack HCI
Raccordée directement au **VLAN SERVEUR**, l'infrastructure de production est basée sur un cluster hyperconvergé **Azure Stack HCI**. Elle héberge les charges de travail critiques de MEDISOL :
* **Services d'Identité Locaux :** Contrôleurs de domaine (Active Directory) assurant l'authentification des utilisateurs locaux et nomades.
* **Serveurs de Fichiers :** Hébergement des données non structurées et des partages réseau, bénéficiant des technologies de stockage HCI (Storage Spaces Direct).
* **Cluster AKS Local (Web & Portail) :** Déploiement d'Azure Kubernetes Service en local pour héberger les micro-services, l'application web et le portail MEDISOL de manière conteneurisée et scalable.
* **Appliance de Supervision :** Centralisation de la télémétrie, des alertes matérielles et applicatives.

## 5. Plan de Continuité d'Activité (PCA) et Résilience Locale
Afin de garantir une haute disponibilité des services avant même d'invoquer un basculement complet vers le cloud, l'architecture locale intègre des mécanismes de continuité d'activité (PCA) à tous les niveaux, éliminant les points de défaillance uniques (SPOF).

### 5.1. Résilience Matérielle (Hardware)
L'infrastructure physique est conçue pour maintenir le service malgré des pannes d'équipements :
* **Tolérance aux pannes du Cluster HCI :** Le cluster Azure Stack HCI est dimensionné pour tolérer la perte simultanée de plusieurs disques ou d'un nœud physique complet sans interruption de service, grâce au mirroring des données via Storage Spaces Direct (S2D).
* **Redondance Réseau :** La "Stack de Switchs Core" utilise des technologies d'empilage (type M-LAG/vPC). Chaque nœud HCI est connecté via des cartes réseau redondées (NIC Teaming / LACP), garantissant la continuité même en cas de perte d'un switch ou d'un câble d'interconnexion.
* **Alimentation redondée :** Double alimentation sur l'ensemble des équipements critiques (serveurs, firewall, switchs) connectés à des onduleurs (UPS) et des circuits électriques distincts.

### 5.2. Résilience Logicielle (Software)
La couche applicative et l'hyperviseur s'appuient sur des mécanismes d'auto-réparation et de répartition de charge :
* **Haute Disponibilité des VMs (Failover Clustering) :** En cas de perte inopinée d'un hyperviseur physique, les machines virtuelles critiques (comme les contrôleurs de domaine ou les serveurs de fichiers) redémarrent automatiquement et rapidement sur un nœud sain du cluster.
* **Résilience Conteneurisée (AKS) :** Le cluster Azure Kubernetes Service local assure le *Self-Healing* des micro-services. Si un conteneur (Pod) hébergeant l'application Web MEDISOL tombe en panne, l'orchestrateur le recrée instantanément pour maintenir la capacité de traitement souhaitée.
* **Services d'Identité :** Le déploiement de multiples contrôleurs de domaine (Active Directory) assure qu'une défaillance logicielle locale n'impacte pas l'authentification des utilisateurs, des praticiens ou des services tiers.

## 6. Architecture Cloud & PRA (Microsoft Azure)
La résilience globale du système d'information MEDISOL repose sur une extension directe vers le cloud public Azure, formant la **Zone de Réplication / PRA**. Ce plan de secours intervient si le PCA local est dépassé (perte totale de la salle serveur, par exemple).

> **💡 Mécanisme de Reprise (PRA) :** Une réplication asynchrone sécurisée est configurée nativement depuis le cluster Azure Stack HCI local vers le Cloud Azure. En cas de perte totale du site physique, les "Réplicats des Services Locaux" peuvent être instanciés rapidement dans Azure pour reprendre la production.

### 6.1. Composants Azure
* **Passerelle VPN Azure :** Terminaison cloud du tunnel IPsec "Site-to-Site" interconnectant le Firewall local au Virtual Network (VNet) Azure.
* **Firewall Azure :** Filtrage et inspection des flux transitant au sein de la zone de secours cloud.
* **Espace de Sauvegarde Azure :** Utilisation d'un coffre de récupération (Recovery Services Vault) pour le stockage externalisé et immuable des sauvegardes, répondant à la règle du 3-2-1.

### 6.2. Mobilité et Télétravail
L'accès des **Praticiens Nomades** est géré par une architecture "Zero Trust" décentralisée. Les utilisateurs distants montent un tunnel VPN Client aboutissant sur la passerelle VPN Azure. Le flux est ensuite inspecté par le Firewall Azure avant d'être redirigé vers les services appropriés, garantissant que les terminaux non maîtrisés n'ont pas d'accès direct non filtré au cœur de réseau on-premise.

## 7. Synthèse de Conformité
Cette architecture hybride répond en tous points aux exigences modernes des SI de santé/critiques : segmentation profonde (Zoning), infrastructure locale tolérante aux pannes (PCA grâce à Azure Stack HCI), approche conteneurisée auto-réparatrice (AKS), et un PRA robuste et transparent grâce à l'écosystème unifié Microsoft Azure.