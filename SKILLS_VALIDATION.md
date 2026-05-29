# 🏥 Validation des Compétences - MEDISOL (Clinique Bien-Être)

> **Contexte** : Projet MSPR Virtualisation 2025-2026 — Clinique bien-être 32 employés
> **Requis** : HDS (Healthcare Data Hosting) + RGPD
> **Objectif** : Haute disponibilité (RTO 30-60min, RPO 1h, 99.9% availability)
> **Date Rendu** : 22 juin 2026 23h | **Soutenance** : 25 juin 2026

---

## 📋 Référence — 8 Objectifs Pédagogiques

Pour MEDISOL, valider ces 8 compétences :

| #   | Objectif                                                                   | État | Deadline | Validation |
| --- | -------------------------------------------------------------------------- | ---- | -------- | ---------- |
| 1️⃣  | **Hyperviseur / IaaS** (Azure VMs via Terraform — France Central HDS)      | ⚠️   | 15 juin  | [ ]        |
| 2️⃣  | **Ressources & Sécurité** (Entra ID P2 + NSG + Azure Firewall + Key Vault) | ⚠️   | 15 juin  | [ ]        |
| 3️⃣  | **Full Cloud Azure** (France Central HDS + Terraform IaC)                  | ⚠️   | 18 juin  | [ ]        |
| 4️⃣  | **Supervision** (Azure Monitor + Log Analytics + Microsoft Sentinel)       | ⚠️   | 18 juin  | [ ]        |
| 5️⃣  | **Sauvegardes & PRA** (Azure Backup GRS + Azure Site Recovery)             | ⚠️   | 20 juin  | [ ]        |
| 6️⃣  | **VDI & Profils** (Azure Virtual Desktop — logiciel patient + nomades)     | ⚠️   | 18 juin  | [ ]        |
| 7️⃣  | **Résilience & HA** (Availability Zones + ASR + Terraform state remote)    | ⚠️   | 20 juin  | [ ]        |
| 8️⃣  | **PRA / PCO** (Drill ASR + runbooks Azure Automation + mesure RTO/RPO)     | ⚠️   | 20 juin  | [ ]        |

---

## ✅ Checklist de Rendu MEDISOL

```
GRP2-MEDISOL/
├── 01-contexte-client/
│   ├── README.md                      ✅ Présentation clinique, enjeux HDS/RGPD
│   ├── fiche-entreprise.md           ✅ Reprise fiche + adaptation contexte
│   └── besoins-reformules.md         ✅ Analyse + synthèse besoins
│
├── 02-architecture/
│   ├── ARCHITECTURE.md               ✅ Justification hyperviseur, schémas VLANs
│   ├── schemas/
│   │   ├── architecture-globale.md   ✅ Vue d'ensemble Azure (VNet, subnets, services)
│   │   ├── azure-network.md          ✅ Subnets + NSG + Azure Firewall Premium
│   │   ├── avd-architecture.md       ✅ Azure Virtual Desktop topology
│   │   └── azure-architecture.png    ✅ Diagramme réseau visuel
│   └── conformite-hds-rgpd.md        ✅ Mapping critères HDS/RGPD → services Azure
│
├── 03-mise-en-oeuvre/
│   ├── 01-terraform/
│   │   ├── selection-justification.md ✅ Azure vs on-prem (justification + TCO 3 ans)
│   │   ├── terraform-structure.md     ✅ Modules Terraform (networking, avd, storage...)
│   │   └── terraform-apply-logs.txt   ✅ Preuves déploiement (terraform plan output)
│   │
│   ├── 02-identity/
│   │   ├── entra-id-config.md         ✅ Entra ID P2 : groupes, MFA, Conditional Access
│   │   ├── rbac-assignments.md        ✅ RBAC par rôle (Praticien / Admin / RH)
│   │   └── comptes-nominatifs.md      ✅ Remplacement compte Lyliandu33
│   │
│   ├── 03-reseau/
│   │   ├── vnet-subnets-config.md     ✅ VNet 10.0.0.0/16 + 4 subnets + NSG
│   │   ├── azure-firewall-rules.md    ✅ Règles Azure Firewall Premium (IDPS)
│   │   ├── matrix-flux.md             ✅ Tableau flux réseau complet
│   │   └── vpn-p2s.md                 ✅ Azure VPN Gateway P2S praticiens nomades
│   │
│   ├── 04-stockage/
│   │   ├── azure-files-config.md      ✅ Azure Files Premium (SMB 3.0, FSLogix)
│   │   ├── netapp-files-config.md     ✅ Azure NetApp Files (imageries médicales)
│   │   └── backup-strategy.md         ✅ Azure Backup GRS + soft delete 30j
│   │
│   ├── 05-backup-pra/
│   │   ├── azure-backup-policy.md     ✅ Recovery Services Vault + policies ASR
│   │   ├── asr-replication.md         ✅ ASR France Central → France South
│   │   ├── test-restauration.md       ✅ Rapport test : date, durée, RTO mesuré
│   │   └── rpo-rto-mesure.md          ✅ Métriques vs objectifs (Azure Backup report)
│   │
│   ├── 06-supervision/
│   │   ├── log-analytics-workspace.md ✅ Log Analytics + Diagnostic Settings
│   │   ├── sentinel-config.md         ✅ Microsoft Sentinel : règles HDS, audit trail
│   │   ├── azure-monitor-alerts.md    ✅ Alertes CPU/Disk/AVD + Action Groups
│   │   └── workbook-screenshots.txt   ✅ Preuves dashboards Azure Workbooks
│   │
│   ├── 07-vdi-acces-distant/
│   │   ├── rds-config.md              ✅ RDS Farm médecins (VDI personnalisée)
│   │   ├── templates-profiles.md      ✅ Profils médicaux (applis métier)
│   │   └── audit-trail.md             ✅ Traçabilité accès patient data
│   │
│   └── 08-scripts/
│       ├── provision-vms.sh           ✅ Automation création VMs
│       ├── backup-veeam.ps1           ✅ Scripts backups Veeam
│       └── monitoring-setup.sh        ✅ Déploiement Zabbix agents
│
├── 04-objectifs-pedagogiques.md       ✅ **MANDATORY** : Mappage 8 objectifs
├── 05-pra-pco-complet.md              ✅ Plan continuité détaillé + test
├── 06-entretien-2-evolutions.md       ✅ Feedback 16 juin intégré
└── README.md                          ✅ Sommaire + guide navigation

```

### Points Obligatoires pour MEDISOL

- [ ] **Contexte clinique reformulé** — Besoin patient data protection, audit trail
- [ ] **Architecture HDS/RGPD** — Justification sécurité, segmentation, chiffrement
- [ ] **Hyperviseur choisi** — Proxmox vs XCP-ng + proof-of-concept on campus
- [ ] **Segmentation VLAN 4 niveaux** — Métier/Invités/Admin/Imagerie schéma + config
- [ ] **Firewall HA (Fortinet)** — Redondance, failover automatique documenté
- [ ] **NAS RAID6 + Snapshots** — QNAP specs, rotation snapshots, restauration testée
- [ ] **Veeam Backup** — 4x/jour incrémental, 1x/nuit full, rétention documentée
- [ ] **Supervision Zabbix** — Monitoring VMs/RDS/NAS, alertes services critiques
- [ ] **RDS (VDI clinique)** — Profils médecins, applis métier, audit trail
- [ ] **PRA/PCO complet** — Test restauration VM + RDS failover effectué
- [ ] **8 objectifs détaillés** — Fichier 04-objectifs-pedagogiques.md complet
- [ ] **Repo public** — Aucune IP patient, aucun credential en clair

---

## 📊 Grille Validation par Objectif — MEDISOL

### Objectif 1️⃣ — Hyperviseur Adapté HDS

**MEDISOL Spécifique :**

- [ ] Justifier Proxmox/XCP-ng pour compliance HDS (audit, isolation, stabilité)
- [ ] Comparer sur : coût licensing, support, community, certifications
- [ ] Documenter clustering HA (récupération sinistre < 30min)
- [ ] Valider isolation VM patient data / services externes
- [ ] Démontrer création VM template médicale

**Livrables :**

- [ ] Document justification hyperviseur (2-3 pages)
- [ ] Schéma architecture HA Proxmox
- [ ] Config clustering validée (ou proof-of-concept vidéo)
- [ ] Logs création VM template

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

### Objectif 2️⃣ — Ressources & Sécurité (Segmentation MEDISOL)

**MEDISOL Spécifique :**

- [ ] Justifier choix Azure (vs Proxmox on-prem) : HDS, zéro CAPEX, HA natif Availability Zones
- [ ] `terraform apply` module `avd` : déployer Azure Virtual Desktop Session Hosts
- [ ] Configurer Azure VMs Standard_D4s_v3 en Availability Set/Zone
- [ ] Documenter dimensionnement AVD (32 users, 3 Session Hosts)
- [ ] Tester logiciel patient dans AVD (latence, compatibilité)

**Livrables :**

- [ ] `infrastructure/terraform/modules/avd/` : code Terraform versionné
- [ ] Capture d'écran Azure Portal : VMs déployées + AVD Host Pool actif
- [ ] Justification Azure vs on-prem (tableau TCO 3 ans)
- [ ] Comparatif AVD vs RDS on-prem (coût, HA, conformité HDS)

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

### Objectif 3️⃣ — Full Cloud Azure (France Central HDS + Terraform IaC)

**MEDISOL Spécifique :**

- [ ] Justifier Full Cloud Azure : HDS certifié, souveraineté France, zéro CAPEX
- [ ] Démontrer données en France uniquement : Azure Policy `allowedLocations = [francecentral, francesouth]`
- [ ] Configurer remote state Terraform : Azure Storage Account chiffré + Managed Identity
- [ ] Démontrer reproductibilité IaC : `terraform destroy` + `terraform apply` = même résultat
- [ ] Prouver clés de chiffrement gérées par Azure Key Vault

**Livrables :**

- [ ] `infrastructure/terraform/` : code complet versionné (modules structurés)
- [ ] `terraform plan` output : zéro ressource hors France
- [ ] Azure Policy assignment : capture + rapport conformité
- [ ] README Terraform avec instructions `init` / `plan` / `apply`

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

### Objectif 4️⃣ — Supervision VMs / Services Critiques

**MEDISOL Spécifique :**

- [ ] Déployer Log Analytics Workspace (Terraform `module monitoring`)
- [ ] Activer Diagnostic Settings sur toutes les ressources Azure
- [ ] Configurer Microsoft Sentinel : détection anoméalies + audit trail HDS
- [ ] Alertes Azure Monitor : CPU > 80%, espace disque > 90%, AVD sessions
- [ ] Dashboard Azure Workbook : uptime AVD, activité patients, inc. sécurité

**Livrables :**

- [ ] `infrastructure/terraform/modules/monitoring/` : code Terraform
- [ ] Capture Log Analytics : requête KQL audit accès patients
- [ ] Capture Sentinel : dashboard incidents HDS
- [ ] Azure Monitor alert rules : définitions + tests

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

### Objectif 5️⃣ — Sauvegardes & PRA (Azure Backup + ASR)

**MEDISOL Spécifique :**

- [ ] Configurer Recovery Services Vault (Terraform) avec réplication GRS
- [ ] Politique backup : AVD Session Hosts + Azure Files (RPO 1h)
- [ ] Activer soft delete 30j (protection ransomware)
- [ ] Configurer Azure Site Recovery : réplication France Central → France South
- [ ] Tester restauration (Azure Backup) : mesurer RTO effectif
- [ ] Test Failover ASR (non-disruptif) : démontrer continuité

**Livrables :**

- [ ] `infrastructure/terraform/modules/backup/` : code Terraform
- [ ] Rapport test restauration : date, durée, RTO mesuré vs objectif
- [ ] Capture ASR replication status (Healthy)
- [ ] Rapport Test Failover ASR (objectif RTO < 30 min)

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

### Objectif 6️⃣ — VDI & Profils (Azure Virtual Desktop)

**MEDISOL Spécifique :**

- [ ] Déployer AVD Host Pool (pooled 32 users + personal pour praticiens nomades)
- [ ] Configurer FSLogix Profile Containers sur Azure Files Premium
- [ ] Tester logiciel patient dans session AVD (latence, compatibilité)
- [ ] Accès praticiens nomades via navigateur (HTTPS) sans VPN supplémentaire
- [ ] MFA Entra ID obligé pour toute session AVD

**Livrables :**

- [ ] Capture AVD : session active logiciel patient
- [ ] Rapport performance : temps réponse < 2s objectif
- [ ] Documentation accès nomade (fiche onboarding praticien)
- [ ] Entra ID Conditional Access policy : capture

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

### Objectif 7️⃣ — Résilience & HA (Availability Zones + ASR + Terraform)

**MEDISOL Spécifique :**

- [ ] Déployer VMs Azure en Availability Zone 1/2/3 (Terraform `zones`)
- [ ] Configurer Azure Site Recovery (ASR) : réplication France Central → France South
- [ ] Scénario failover zone : défaillance AZ 1 → AVD bascule AZ 2 automatiquement
- [ ] Remote state Terraform en HA (Azure Storage redondant LRS)
- [ ] Documenter test failover : métrique RTO mesurée

**Livrables :**

- [ ] Terraform plan output : `zone` paramètre visible sur toutes les VMs
- [ ] ASR replication topology diagram (France Central → France South)
- [ ] Failover test report (date, scénario, RTO < 30 min)
- [ ] Comparatif HA Azure vs Hyper-V on-prem (justification choix Azure)

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

### Objectif 8️⃣ — PRA / PCO Complet (Azure Automation + Runbooks)

**MEDISOL Spécifique :**

- [ ] PRA documenté : procédure activation Azure (quoi, qui, quand, comment)
- [ ] Services critiques : AVD, Azure Files, ASR, Entra ID, VPN Gateway
- [ ] RTO/RPO par service : AVD < 30min, Azure Files < 5min (snapshot), admin 1h
- [ ] Azure Automation Runbook : déclenchement failover automatique
- [ ] Drill PRA effectué : ASR Test Failover + restauration Azure Backup mesurée
- [ ] Post-drill : lessons learned, améliorations Terraform

**Livrables :**

- [ ] PRA document complet (procédure Azure Failover)
- [ ] Services critiques matrix (criticité, RTO/RPO cible vs mesuré)
- [ ] Azure Automation Runbook : code + capture exécution
- [ ] Drill report (date, VMs testées, timing, issues, resolutions)
- [ ] Lessons learned + amélioration recommendations

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

## 📅 Timeline Validation MEDISOL

| Semaine         | Tâches                                             | Status | Blocage? |
| --------------- | -------------------------------------------------- | ------ | -------- |
| **Sem 1**       | Repo public ✅; entretien 1 ✅; architecture draft | ✅     | Non      |
| **Sem 2**       | Hyperviseur sélectionné; VLANs schéma              | ⚠️     |          |
| **Sem 3**       | Proxmox install salle campus; VMs base             | ⚠️     |          |
| **16 juin AM**  | **Entretien 2** — Feedback formateur intégré       | ⏳     | —        |
| **Sem 4**       | NAS RAID6 setup; Veeam backup; supervision         | ⚠️     |          |
| **20 juin**     | **Drill PRA** — Test restauration + timing         | ⚠️     |          |
| **21 juin**     | Finalize docs; 8 objectifs complétés               | ⚠️     |          |
| **22 juin 23h** | **Rendu final** — Email + repo verrouillé          | ⏳     | —        |
| **23 juin**     | Annonce cas soutenance (MEDISOL ou autre)          | ⏳     | —        |
| **25 juin PM**  | **Soutenance** (si MEDISOL annoncé)                | ⏳     | —        |

---

## ⚠️ Risques Identifiés MEDISOL

| Risque                     | Impact                 | Mitigation                                    | Status |
| -------------------------- | ---------------------- | --------------------------------------------- | ------ |
| Accès salle serveur limité | Proxy delays           | Planifier sessions accès; doc de salle campus | 🔴     |
| Compliance HDS complexe    | Retard validation arch | Valider avec formateur sem 2                  | 🟡     |
| Veeam licensing            | Coût setup             | Utiliser trial Veeam 30j; documenter          | 🟡     |
| Test PRA timing            | Manquer RPO/RTO cibles | Dry-run sur test VMs 18 juin                  | 🟡     |
| RDS setup long             | Retard soutenance prep | Automatiser template VM week 4                | 🟡     |

---

## ✏️ Notes Équipe MEDISOL

_À remplir au fur et à mesure par le groupe._

```
Décisions d'architecture :
- [DATE] Choix Proxmox (vs XCP-ng) : Razones : community support, UI, clustering.
- [DATE] VLAN segmentation 4 niveaux : Métier(100) isolé firewall strict.
- [DATE] Backups AWS : décidé immuable pour compliance archivage RGPD 7ans.

Blocages rencontrés :
- [DATE] Salle serveur accès : résolu planning sessions.
- [DATE] Veeam trial limit : étendu 15j extra.

Feedback entretien 2 (16 juin) :
- [À REMPLIR POST-ENTRETIEN]
```

---

**Dernier update :** [À remplir]
**Groupe:** [À remplir : 3 noms]
**État global :** ❌ En démarrage | ⚠️ En cours | ✅ Complété
