# ARCHITECTURE.md - MEDISOL Infrastructure Azure Cible

**Version :** 2.0 (Full Azure + Terraform)
**Last Updated :** 29 Mai 2026
**Décision :** Full Cloud Microsoft Azure — France Central (certifié HDS)
**IaC :** Terraform (provider `azurerm`)

> ⚠️ **IMPORTANT — Deux états distincts :**
>
> | | Infrastructure **actuelle** | Infrastructure **cible** (remédiation) |
> |-|---------------------------|----------------------------------------|
> | **État** | En place aujourd'hui chez MEDISOL | À déployer via Terraform (Phase 1–5) |
> | **Compute** | Simple PC Windows 4 ans | Azure VMs + Azure Virtual Desktop (AVD) |
> | **Identité** | Compte unique `Lyliandu33` partagé | Microsoft Entra ID P2 + MFA + CA |
> | **Réseau** | Réseau plat non segmenté | Azure VNet + NSG + Azure Firewall Premium |
> | **Stockage** | 2 To PC local (non sauvegardé fiablement) | Azure Files Premium + Azure NetApp Files |
> | **Backup** | Manuel, irrégulier, sur site | Azure Backup GRS + ASR (France Central → South) |
> | **Monitoring** | Aucun | Azure Monitor + Log Analytics + Sentinel |
> | **IaC** | Aucune (configuration manuelle) | **Terraform `azurerm` ≥ 4.x** |
>
> **Ce document décrit uniquement l'infrastructure cible.** L'état actuel est documenté dans [AUDIT_FINDINGS.md](./AUDIT_FINDINGS.md).

---

## 1️⃣ Décision Architecturale — Pourquoi Full Azure

| Critère                     | Justification                                                                         |
| --------------------------- | ------------------------------------------------------------------------------------- |
| **Certification HDS**       | Azure France Central est certifié HDS nativement — obligation légale données patients |
| **Souveraineté française**  | Datacenter France Central (Paris) + France South (Marseille)                          |
| **Zéro CAPEX**              | Pas d'investissement matériel — OPEX mensuel maîtrisé                                 |
| **HA natif**                | Availability Zones (3 zones) → RTO < 5 min sans infrastructure redondante dédiée      |
| **Disaster Recovery natif** | Azure Site Recovery France Central → France South                                     |
| **Identité unifiée**        | Microsoft Entra ID P2 remplace directement le compte partagé `Lyliandu33`             |
| **VDI managé**              | Azure Virtual Desktop pour logiciel patient — plus de client lourd local              |
| **Auditabilité**            | Terraform + Azure Policy + Microsoft Sentinel = traçabilité RGPD complète             |

### Contraintes Actuelles (à migrer)

- Infrastructure actuelle : simple PC Windows 4 ans, 2 To, compte unique partagé
- Réseau plat non segmenté — à remplacer par Azure VNet + Subnets + NSG
- Wi-Fi physique on-premises — reste local, supervisé via Azure Arc
- Logiciel patient (client lourd) — à qualifier compatibilité AVD

---

## 2️⃣ Azure Services Stack

| Domaine                    | Service Azure                           | SKU / Tier                         | Remplace                    |
| -------------------------- | --------------------------------------- | ---------------------------------- | --------------------------- |
| **Compute**                | Azure Virtual Machines                  | Standard_D4s_v3 (Availability Set) | VMware ESXi                 |
| **VDI / Logiciel patient** | Azure Virtual Desktop (AVD)             | Pooled + Personal                  | RDS on-prem + client lourd  |
| **Identité**               | Microsoft Entra ID P2                   | + MFA + Conditional Access         | Compte partagé `Lyliandu33` |
| **Réseau**                 | Azure Virtual Network                   | VNet + Subnets + NSG + UDR         | VLAN 802.1Q + switchs       |
| **Firewall**               | Azure Firewall Premium                  | IDPS + TLS inspection              | FortiGate hardware          |
| **Accès distant**          | Azure VPN Gateway (P2S) + Azure Bastion | VpnGw2                             | VPN IPSec on-prem           |
| **Stockage patients**      | Azure Files Premium                     | SMB 3.0 chiffré                    | QNAP NAS RAID6              |
| **Stockage imageries**     | Azure NetApp Files                      | Standard tier                      | NAS secondaire              |
| **Backup**                 | Azure Backup                            | GRS (geo-redundant)                | Veeam + disque externe      |
| **DR**                     | Azure Site Recovery                     | France Central → France South      | Réplication manuelle        |
| **Monitoring**             | Azure Monitor + Log Analytics           | Workspace dédié                    | Zabbix + ELK                |
| **SIEM / Audit trail**     | Microsoft Sentinel                      | + Healthcare workbook              | ELK / audit manuel          |
| **Alertes**                | Azure Monitor Alerts + Action Groups    | Email + SMS                        | Alertes Zabbix              |
| **Wi-Fi (on-prem)**        | Aruba / Ubiquiti AP Wi-Fi 6             | Géré via Azure Arc                 | Bornes actuelles            |
| **IaC**                    | Terraform (azurerm provider)            | ≥ 4.x                              | —                           |
| **Secrets**                | Azure Key Vault                         | Standard                           | Variables en clair          |
| **DNS**                    | Azure Private DNS Zone                  | + Azure DNS                        | DNS box Orange              |

### Régions Azure

| Région                       | Usage                 | HDS             |
| ---------------------------- | --------------------- | --------------- |
| **France Central** (Paris)   | Production principale | ✅ Certifié HDS |
| **France South** (Marseille) | DR / réplication ASR  | ✅ Certifié HDS |

---

## 3️⃣ Architecture Azure (Vue d'ensemble)

```
┌──────────────────────────────────────────────────────────────────────┐
│                    AZURE – France Central (HDS)                      │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐    │
│  │                  VNet: 10.0.0.0/16                          │    │
│  │                                                              │    │
│  │  AzureFirewallSubnet (10.0.0.0/26)                          │    │
│  │  ┌──────────────────────────────┐                           │    │
│  │  │   Azure Firewall Premium     │◄── Internet               │    │
│  │  │   (IDPS + TLS inspection)    │                           │    │
│  │  └──────────────┬───────────────┘                           │    │
│  │                 │  (UDR force-tunnel)                       │    │
│  │  ┌──────────────┴────────────────────────────────────┐      │    │
│  │  │  subnet-avd  (10.0.1.0/24)                        │      │    │
│  │  │  Azure Virtual Desktop — Session Hosts (AVD)      │      │    │
│  │  │  Logiciel patient (32 users) + praticiens nomades │      │    │
│  │  └───────────────────────────────────────────────────┘      │    │
│  │                                                              │    │
│  │  ┌───────────────────────────────────────────────────┐      │    │
│  │  │  subnet-storage  (10.0.2.0/24)                    │      │    │
│  │  │  Azure Files Premium (dossiers patients, SMB 3.0) │      │    │
│  │  │  Azure NetApp Files (imageries médicales)         │      │    │
│  │  └───────────────────────────────────────────────────┘      │    │
│  │                                                              │    │
│  │  ┌───────────────────────────────────────────────────┐      │    │
│  │  │  subnet-mgmt  (10.0.3.0/24)                       │      │    │
│  │  │  Azure Bastion (accès admin sécurisé)             │      │    │
│  │  │  Azure Monitor + Log Analytics Workspace          │      │    │
│  │  │  Microsoft Sentinel (SIEM + audit trail HDS)      │      │    │
│  │  └───────────────────────────────────────────────────┘      │    │
│  │                                                              │    │
│  │  ┌───────────────────────────────────────────────────┐      │    │
│  │  │  subnet-vpn  (10.0.4.0/24)                        │      │    │
│  │  │  Azure VPN Gateway P2S (praticiens nomades)       │      │    │
│  │  │  Tunnel site-to-site → on-prem Wi-Fi (box Orange) │      │    │
│  │  └───────────────────────────────────────────────────┘      │    │
│  └─────────────────────────────────────────────────────────────┘    │
│                                                                      │
│  ┌─────────────────────────────────────────────────────────────┐    │
│  │  Azure Backup Vault (GRS)   Azure Site Recovery             │    │
│  │  RPO : 1h    RTO : <30 min  Réplication → France South      │    │
│  └─────────────────────────────────────────────────────────────┘    │
└──────────────────────────────────────────────────────────────────────┘
         │ VPN S2S
┌────────┴──────────────────────────────────────┐
│  ON-PREMISES MEDISOL (1 000 m²)               │
│  Box Orange Fibre Pro + AP Wi-Fi 6 (Aruba)    │
│  SSID Clients 4K  |  SSID Métier  |  SSID Admin│
│  Caméras Hikvision PoE (VLAN local isolé)     │
│  → Supervisés via Azure Arc                   │
└───────────────────────────────────────────────┘
```

---

## 4️⃣ Composants Détaillés

### A. Identité & Accès (Entra ID P2)

| Composant                      | Configuration                                | Remplace                    |
| ------------------------------ | -------------------------------------------- | --------------------------- |
| Microsoft Entra ID P2          | Tenant dédié MEDISOL                         | Compte partagé `Lyliandu33` |
| 32 comptes nominatifs          | Rôles RBAC (Praticien / Admin / RH / Compta) | Un seul compte              |
| Conditional Access             | MFA obligatoire + device compliance          | Aucun                       |
| Privileged Identity Management | Just-in-time admin access                    | Accès permanent root        |
| Entra ID Password Protection   | Politique MDP + rotation 90j                 | Jamais modifié              |
| Azure AD Connect (optionnel)   | Sync si AD local conservé                    | —                           |

### B. Azure Virtual Desktop (VDI)

| Composant                  | Configuration                                     | Notes                            |
| -------------------------- | ------------------------------------------------- | -------------------------------- |
| Host Pool                  | Pooled (32 users) + Personal (praticiens nomades) | Logiciel patient virtualisé      |
| Session Hosts              | Standard_D4s_v3 × 3                               | Availability Zone 1/2/3          |
| FSLogix Profile Containers | Azure Files Premium                               | Profils utilisateurs persistants |
| MSI / Intune               | Déploiement logiciel patient automatisé           | Version centralisée unique       |
| Accès praticiens nomades   | Via navigateur ou client RD (HTTPS)               | Pas de VPN obligatoire           |

### C. Stockage Azure

| Composant           | Service                          | Capacité      | Rétention                       |
| ------------------- | -------------------------------- | ------------- | ------------------------------- |
| Dossiers patients   | Azure Files Premium (SMB 3.0)    | 1 To scalable | Snapshot daily 30j              |
| Imageries médicales | Azure NetApp Files               | 2 To standard | Snapshot horaire                |
| Backup vault        | Azure Backup (GRS)               | Illimité      | 30j opérationnel + 1 an archive |
| Soft delete         | Activé sur tous les comptes      | 30j           | Protection ransomware           |
| Chiffrement         | Azure Storage Service Encryption | AES-256       | Transparent, géré Azure         |

### D. Sécurité Réseau

| Composant                     | Configuration                             | Remplace           |
| ----------------------------- | ----------------------------------------- | ------------------ |
| Azure Firewall Premium        | IDPS, TLS inspection, FQDN filtering      | FortiGate hardware |
| NSG (Network Security Groups) | Règles par subnet (Deny-All + allow-list) | ACL VLAN           |
| Azure Private Endpoints       | Azure Files + NetApp (pas d'accès public) | —                  |
| Azure Bastion                 | Accès admin SSH/RDP sans IP publique      | Jump server        |
| DDoS Protection Basic         | Inclus nativement                         | —                  |
| Azure Policy                  | Enforce HDS-compliant settings            | Audit manuel       |

### E. Backup & Disaster Recovery

| Composant            | Service                                       | RPO           | RTO                        |
| -------------------- | --------------------------------------------- | ------------- | -------------------------- |
| Azure Backup — VMs   | Recovery Services Vault (GRS)                 | 1h            | < 30 min                   |
| Azure Backup — Files | Azure Files snapshots                         | 1h (schedule) | < 5 min (restore snapshot) |
| Azure Site Recovery  | Réplication FR Central → FR South             | < 15 min      | < 30 min                   |
| Soft Delete          | Comptes stockage + Backup vault               | —             | 30j de protection          |
| Runbooks             | Azure Automation (failover automatique)       | —             | Déclenchement automatique  |
| Test DR              | Mensuel (non-disruptif via ASR Test Failover) | —             | Documenté                  |

### F. Monitoring & SIEM

| Composant               | Service                                             | Usage                   |
| ----------------------- | --------------------------------------------------- | ----------------------- |
| Azure Monitor           | Métriques CPU/RAM/Disk/Réseau toutes ressources     | Remplace Zabbix         |
| Log Analytics Workspace | Centralisation tous les logs (AVD, Firewall, Entra) | Remplace ELK            |
| Microsoft Sentinel      | SIEM — détection anomalies, audit trail HDS         | Audit RGPD              |
| Azure Monitor Alerts    | Alertes email + SMS + webhook                       | Remplace alertes Zabbix |
| Azure Workbooks         | Dashboards métier (uptime, activité patients)       | Remplace Grafana        |
| Diagnostic Settings     | Activés sur toutes les ressources critiques         | —                       |

---

## 5️⃣ Structure Terraform

```
infrastructure/terraform/
├── main.tf                    # Provider azurerm + versions
├── variables.tf               # Variables (région, tags, tailles)
├── terraform.tfvars           # Valeurs (hors secrets → Key Vault)
├── terraform.tfvars.example   # Template versionné
├── outputs.tf                 # IDs ressources exportés
├── backend.tf                 # Remote state → Azure Storage (chiffré)
│
├── modules/
│   ├── networking/            # VNet, Subnets, NSG, UDR, Firewall
│   ├── identity/              # Entra ID, groupes, RBAC assignments
│   ├── avd/                   # Azure Virtual Desktop (Host Pool, App Group)
│   ├── storage/               # Azure Files, NetApp Files, Key Vault
│   ├── backup/                # Recovery Services Vault, Backup policies
│   ├── monitoring/            # Log Analytics, Sentinel, Monitor alerts
│   └── vpn/                   # VPN Gateway P2S + Bastion
│
└── environments/
    ├── staging/               # Environnement test (avant entretien 2)
    └── production/            # Production post-validation client
```

> **Remote state :** Azure Storage Account (chiffré, accès via Managed Identity)
> **Secrets :** Azure Key Vault — jamais de credentials en clair dans les `.tf`
> **CI/CD :** GitHub Actions (plan + apply sur merge sur `main`)

---

## 6️⃣ Conformité HDS / RGPD

| Exigence                     | Solution Azure                                   | Statut                       |
| ---------------------------- | ------------------------------------------------ | ---------------------------- |
| Hébergement certifié HDS     | Azure France Central (certifié HDS 2019-2026)    | ✅ Natif                     |
| Données en France uniquement | Région `francecentral` + `francesouth`           | ✅ Enforced via Azure Policy |
| Chiffrement repos            | Azure SSE AES-256                                | ✅ Natif                     |
| Chiffrement transit          | TLS 1.2+ (Azure enforced)                        | ✅ Natif                     |
| Audit trail accès patients   | Microsoft Sentinel + Log Analytics               | ✅ À configurer              |
| Rétention logs               | Log Analytics — 2 ans minimum                    | ✅ Configurable              |
| RGPD — droit à l'oubli       | Azure Policy + lifecycle management              | ⚠️ À documenter              |
| DPO                          | Entra ID — rôle Privacy Reader à désigner        | ⚠️ À nommer                  |
| AIPD                         | À réaliser avec données Azure Defender for Cloud | ⚠️ Planifié entretien 2      |

---

## 7️⃣ Plan de Déploiement Terraform

### Phase 1 — Foundation (Semaines 1–2)

- [ ] Créer subscription Azure dédiée MEDISOL (isolation HDS)
- [ ] Configurer Terraform remote state (Azure Storage)
- [ ] `terraform apply` module `networking` (VNet, Subnets, NSG, Firewall)
- [ ] `terraform apply` module `identity` (Entra ID, groupes, MFA)
- [ ] Créer Azure Key Vault + importer secrets

### Phase 2 — Services Coeur (Semaines 3–4)

- [ ] `terraform apply` module `avd` (Host Pool, Session Hosts)
- [ ] `terraform apply` module `storage` (Azure Files + NetApp Files)
- [ ] Tester accès logiciel patient depuis AVD
- [ ] `terraform apply` module `vpn` (P2S Gateway + Bastion)

### Phase 3 — Backup & Monitoring (Semaines 5–6)

- [ ] `terraform apply` module `backup` (Recovery Services Vault + policies)
- [ ] `terraform apply` module `monitoring` (Log Analytics + Sentinel + alertes)
- [ ] Configurer ASR réplication France Central → France South
- [ ] Activer Microsoft Defender for Cloud (HDS compliance)

### Phase 4 — Migration & Validation (Semaines 7–8)

- [ ] Migration données PC Windows → Azure Files (AzCopy)
- [ ] Basculer logiciel patient vers AVD (test 5 users pilotes)
- [ ] Test Failover ASR (non-disruptif, en staging)
- [ ] Drill PRA complet (mesurer RTO/RPO réels)
- [ ] Validation conformité HDS avec checklist Sentinel

### Phase 5 — Cutover & MCO (Semaine 9+)

- [ ] Basculement complet (32 users sur AVD)
- [ ] Mise hors service PC Windows existant
- [ ] Support J+30 inclus
- [ ] Documentation finale + remise accès Terraform au client

---

│ │
│ ┌──────────────┐ ┌─────────────────────┐ │
│ │ Firewall HA │◄────────┤ Internet (Fibre Box)│ │
│ └──────────────┘ └─────────────────────┘ │
│ │ │
│ ┌──────┴──────────────────────────────────┐ │
│ │ Réseau Cœur (Switchs HA) │ │
│ └──────┬──────────────────────────────────┘ │
│ │ │
│ ┌──────┴────────────────────────────────────────┐ │
│ │ VLAN Segmentation │ │
│ ├──────────────────────────────────────────────┤ │
│ │ VLAN 100 (Métier) → Logiciel Patient + RDS │ │
│ │ VLAN 200 (Invités) → Wi-Fi Patients │ │
│ │ VLAN 300 (Admin) → Gestion + Accès Sécurisé │ │
│ │ VLAN 400 (Imagerie) → Serveur Stockage │ │
│ └──────┬───────────────────────────────────────┘ │
│ │ │
│ ┌──────┴──────────────┬──────────────┬──────────────┐ │
│ │ │ │ │ │
│ ▼ ▼ ▼ ▼ │
│ ┌─────────────┐ ┌─────────────┐ ┌─────────┐ ┌──────┐ │
│ │ RDS/VDI │ │ NAS │ │ Backup │ │ Wi-Fi│ │
│ │ Logiciel │ │ Imagerie │ │ Externe │ │ HA │ │
│ │ Patient │ │ 4To │ │ Immuable│ │ │ │
│ │ HA/Scaling │ │ Snapshots │ │ Off-Site│ │ Mesh │ │
│ └─────────────┘ └─────────────┘ └─────────┘ └──────┘ │
│ │
│ ┌──────────────────────────────────────────────┐ │
│ │ Monitoring & Alertes (Zabbix/Prometheus) │ │
│ │ - CPU/Mémoire/Stockage │ │
│ │ - Disponibilité RDS/NAS │ │
│ │ - Compliance HDS │ │
│ └──────────────────────────────────────────────┘ │
│ │
└─────────────────────────────────────────────────────────────┘

```

---

## 3️⃣ Composants Détaillés

### A. **Réseau & Sécurité**

| Composant    | Solution                     | Spec       | Notes                    |
| ------------ | ---------------------------- | ---------- | ------------------------ |
| Firewall     | Fortinet FortiGate 500D (HA) | Dual WAN   | Haute disponibilité      |
| Switch Cœur  | Cisco C9300                  | L3 Managed | Redondance spanning-tree |
| Switch Accès | Cisco C9200L x4              | 48 ports   | 1 par zone               |
| Wi-Fi        | Aruba 6100 Instant On        | PoE+       | Mesh + VLAN separate     |
| VPN          | IPSec + MFA                  | AzureAD    | Praticiens nomades       |

### B. **Calcul & RDS**

| Composant           | Solution              | Spec           | Notes            |
| ------------------- | --------------------- | -------------- | ---------------- |
| RDS Host Primaire   | VMware ESXi 7         | 2 CPU 16GB RAM | Logiciel patient |
| RDS Host Secondaire | VMware ESXi 7         | Réplica HA     | Failover auto    |
| Licenses RDS        | Microsoft RDS CAL     | 35 users       | Extensible       |
| Connection Broker   | RDS Connection Broker | HA             | Load balancing   |

### C. **Stockage & Imagerie**

| Composant      | Solution                | Spec               | Notes                |
| -------------- | ----------------------- | ------------------ | -------------------- |
| NAS Primaire   | QNAP TS-1664c2u         | 4TB + 4TB (RAID 6) | Imageries + dossiers |
| NAS Secondaire | QNAP TS-434             | Réplication iSCSI  | Failover manuel      |
| Snapshots      | QNAP Snapshot           | Toutes les 6h      | Immuable 30 jours    |
| Backup Cloud   | AWS Glacier (Région EU) | Réplication        | HDS compliant        |

### D. **Sauvegarde & Disaster Recovery**

| Composant       | Solution                   | Spec                      | Notes             |
| --------------- | -------------------------- | ------------------------- | ----------------- |
| Logiciel Backup | Veeam Backup & Replication | v12                       | RDS + NAS         |
| Fréquence       | Incrémental                | 4x/jour + complet 1x/nuit | RPO 6h            |
| Rétention       | 30j local + 90j cloud      | Tiered                    | Compliance légale |
| Test Restore    | Mensuel                    | 1er samedi mois           | Documentation     |

### E. **Monitoring & Observabilité**

| Composant         | Solution                  | Spec                    | Notes               |
| ----------------- | ------------------------- | ----------------------- | ------------------- |
| Monitoring        | Zabbix (On-Prem)          | Agents RDS/NAS/Firewall | Alertes SMS/Mail    |
| Logs              | ELK Stack (Elasticsearch) | Centralized syslog      | Audit trail         |
| Uptime Monitoring | Uptime Robot              | Endpoint checking       | SLA external        |
| Rapports          | Grafana                   | Dashboards métier       | KPIs pour direction |

---

## 4️⃣ Plan de Déploiement

### Phase 1 : Préparation (Semaines 1-2)

- [ ] Audit infrastructure existante
- [ ] Valider architecture avec client
- [ ] Commander équipements (lead time)
- [ ] Préparer environnement de test

### Phase 2 : Déploiement Infrastructure (Semaines 3-6)

- [ ] Installer Firewall HA + Switchs
- [ ] Configurer VLAN segmentation
- [ ] Déployer hyperviseur + RDS
- [ ] Installer NAS + Snapshots

### Phase 3 : Migration Services (Semaines 7-8)

- [ ] Migrate logiciel patient vers RDS
- [ ] Migrate données imagerie vers NAS
- [ ] Configurer Backup + Restore
- [ ] Setup Monitoring

### Phase 4 : Validation & Tests (Semaines 9-10)

- [ ] Tests PRA complets
- [ ] Exercice failover Firewall/RDS/NAS
- [ ] Validation conformité HDS
- [ ] Documentation finale

### Phase 5 : Mise en Production (Semaine 11+)

- [ ] Basculement progressif trafic
- [ ] Maintien en condition opérationnelle
- [ ] Support 24/7 premier mois

---

## 5️⃣ Coûts Estimés

| Catégorie         | Description                   | Budget      |
| ----------------- | ----------------------------- | ----------- |
| **Equipements**   | Firewall, Switchs, NAS, WiFi  | 25 000€     |
| **Licensing**     | VMware, Windows Server, QNAP  | 8 000€      |
| **Services**      | Intégration, tests, formation | 12 000€     |
| **Support (1an)** | SLA 4h réaction               | 5 000€      |
| **TOTAL**         |                               | **50 000€** |

---

## 6️⃣ Risques & Mitigation

| Risque                 | Impact      | Probabilité | Mitigation                  |
| ---------------------- | ----------- | ----------- | --------------------------- |
| Perte données imagerie | 🔴 Critique | Basse       | Snapshots + Cloud backup    |
| Indisponibilité RDS    | 🔴 Critique | Basse       | Dual RDS HA + Failover auto |
| Cyber-attaque          | 🟠 Haute    | Moyenne     | Segmentation + Firewall HA  |
| Perte conformité HDS   | 🟠 Haute    | Basse       | Audit mensuel + DPO         |

---

## 7️⃣ Points à Clarifier avec Client

- [ ] RTO exact acceptable ? (30min, 1h, 2h)
- [ ] Budget flexibilité ?
- [ ] Timeline impératif ?
- [ ] Praticiens nomades : VPN obligatoire ?
- [ ] Quel éditeur logiciel patient ? (Compatibilité RDS?)
- [ ] Volume imagerie/mois croissance ?
- [ ] Qui maintient post-déploiement ? (interne/prestataire)

---

**Prochaine Étape:** Valider architecture avec client → Créer REQUIREMENTS.md détaillé
```
