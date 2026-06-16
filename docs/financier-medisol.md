# Synthèse Financière et Stratégique : Modernisation Infrastructure "Metalis Network"

Cette synthèse récapitule les coûts d'investissement (CapEx) et d'exploitation mensuels (OpEx) pour le projet de modernisation du système d'information médical. Trois scénarios de performance ont été modélisés pour le cluster Azure Stack HCI : **Gold**, **Platine** et **Titanium**.

---

## 💰 1. Investissement Initial (CapEx)

Les coûts initiaux sont divisés entre le socle serveur (qui évolue selon le niveau de performance attendu) et le socle commun (Réseau, Sécurité et Prestations) qui reste la base incompressible de la nouvelle architecture.

### A. Comparatif des Socles Serveurs (Cluster 3 Nœuds)

| Scénario | Prix du Cluster (HT) | Caractéristiques Matérielles |
| :--- | :--- | :--- |
| **🥇 Gold** | **57 306 €** | **HPE DL180 Gen10** (2x Intel Xeon Silver 4215R - 96 cœurs au total). <br>*Entrée de gamme performante, stockage hybride, adaptée pour des workloads standards.* |
| **💍 Platine** | **111 567 €** | **HPE DL380 Gen11** (2x Intel Xeon Gold 6542Y - 144 cœurs au total, 6x SSD 3.84TB). <br>*Hautes performances, architecture All-NVMe pour virtualisation dense.* |
| **💎 Titanium**| **183 666 €** | **HPE DL380 Gen11** (2x Intel Xeon Gold 6542Y - 144 cœurs au total, 16x SSD 3.84TB). <br>*Puissance et capacité maximales pour absorber sans latence les bases de données critiques et le VDI.* |

### B. Socle Commun (Réseau, Sécurité & Services)

Ces coûts s'appliquent quel que soit le scénario serveur retenu afin de garantir la résilience et la sécurité du réseau médical.

| Composant / Prestation | Budget Estimé (HT) | Justification Stratégique |
| :--- | :--- | :--- |
| **Stack Switchs HPE Aruba CX 6300M (x2)** | 14 000 € | Cœur de réseau empilé en 10/25 GbE pour garantir la bande passante inter-serveurs. |
| **Firewalls Fortinet 100F (x2)** | 12 000 € | Cluster HA avec accélération matérielle pour la micro-segmentation et les tunnels VPN. |
| **Prestation : Delivery Standard** | 52 200 € | Déploiement de bout en bout et automatisation de l'infrastructure (Terraform). |
| **Prestation : Delivery HNO (Migration)** | 21 600 € | Bascules de nuit/week-end (Heures Non Ouvrées) indispensables pour ne pas impacter le médical. |
| **Prestation : Intégration Monitoring** | 9 900 € | Déploiement des sondes spécifiques S2D / Matériel et création des tableaux de bord. |
| **Prestation : Chefferie de Projet** | 7 200 € | Pilotage global, gestion des plannings HNO et coordination technique. |
| **Prestation : Audit Initial** | 1 800 € | Cartographie Wi-Fi et conception de l'architecture détaillée (HLD/LLD). |
| **Sous-total Socle Commun** | **118 700 €** | **Base fixe pour la sécurité et l'intégration.** |

### C. Budget Total CapEx par Scénario

| Scénario | Socle Serveur | Socle Commun | **TOTAL CAPEX ESTIMÉ (HT)** |
| :--- | :--- | :--- | :--- |
| **🥇 Gold** | 57 306 € | 118 700 € | **176 006 €** |
| **💍 Platine** | 111 567 € | 118 700 € | **230 267 €** |
| **💎 Titanium** | 183 666 € | 118 700 € | **302 366 €** |

---

## 🔄 2. Frais d'Exploitation Mensuels (OpEx)

Les frais récurrents couvrent la sécurisation des données dans le Cloud Microsoft (PRA + Sauvegarde) et la licence d'exploitation du système d'hyperconvergence.

| Service Cloud / Licence | Gold (96 cœurs) | Platine & Titanium (144 cœurs) | Justification |
| :--- | :--- | :--- | :--- |
| **Licence Azure Stack HCI** | 960 € / mois | 1 440 € / mois | Modèle hybride Microsoft facturé à l'usage par cœur physique (~10 € / cœur). |
| **PRA Azure (Site Recovery)** | ~ 550 € / mois | ~ 550 € / mois | Réplication continue pour ~10 VMs critiques (redémarrage cloud en cas de sinistre). |
| **Sauvegarde Azure Backup** | ~ 250 € / mois | ~ 250 € / mois | Rétention froide et immuable des données (5 To), vitale contre les ransomwares. |
| **TOTAL OPEX MENSUEL** | **1 760 € / mois** | **2 240 € / mois** | *(Soit entre 21 K€ et 26,8 K€ / an selon l'option)* |

---

## 📊 3. Bilan Stratégique au regard de l'Enveloppe

Sur l'enveloppe budgétaire prévisionnelle de **2 Millions d'Euros** allouée à la modernisation, l'investissement matériel et humain représente entre **8,8 % (Gold)** et **15,1 % (Titanium)** du budget global. 

Ce reliquat financier très confortable permet d'aborder la suite de la modernisation sereinement, en assurant le financement :
* Des licences logicielles métiers et abonnements Microsoft 365.
* Du dimensionnement et déploiement de l'infrastructure VDI pour les praticiens.
* De l'acquisition des équipements nomades et de la refonte des services patients (portail Web).