# 🏥 Validation des Compétences - MEDISOL (Clinique Bien-Être)

> **Contexte** : Projet MSPR Virtualisation 2025-2026 — Clinique bien-être 32 employés
> **Requis** : HDS (Healthcare Data Hosting) + RGPD
> **Objectif** : Haute disponibilité (RTO 30-60min, RPO 1h, 99.9% availability)
> **Date Rendu** : 22 juin 2026 23h | **Soutenance** : 25 juin 2026

---

## 📋 Référence — 8 Objectifs Pédagogiques

Pour MEDISOL, valider ces 8 compétences :

| #   | Objectif                                                   | État | Deadline | Validation |
| --- | ---------------------------------------------------------- | ---- | -------- | ---------- |
| 1️⃣  | **Hyperviseur** (Proxmox/XCP-ng adapté HDS)                | ⚠️   | 15 juin  | [ ]        |
| 2️⃣  | **Ressources & Sécurité** (Segmentation VLAN 4 niveaux)    | ⚠️   | 15 juin  | [ ]        |
| 3️⃣  | **Hybride On-Prem / Cloud** (Backups AWS Glacier)          | ⚠️   | 18 juin  | [ ]        |
| 4️⃣  | **Supervision** (Zabbix/ELK monitoring services critiques) | ⚠️   | 18 juin  | [ ]        |
| 5️⃣  | **Sauvegardes & PRA** (Veeam 4x/jour incrémental)          | ⚠️   | 20 juin  | [ ]        |
| 6️⃣  | **VDI & Profils** (Accès distant médecins)                 | ⚠️   | 18 juin  | [ ]        |
| 7️⃣  | **Hyper-V & Résilience**                                   | ⚠️   | 20 juin  | [ ]        |
| 8️⃣  | **PRA / PCO** (Plan continuité + tests)                    | ⚠️   | 20 juin  | [ ]        |

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
│   │   ├── architecture-globale.md   ✅ Vue d'ensemble infra
│   │   ├── segmentation-vlans.md     ✅ VLAN Métier/Invités/Admin/Imagerie
│   │   ├── firewall-ha.md            ✅ Firewall redondance (Fortinet)
│   │   └── reseau.png / .svg         ✅ Diagramme réseau visuel
│   └── conformite-hds-rgpd.md        ✅ Mapping critères HDS/RGPD
│
├── 03-mise-en-oeuvre/
│   ├── 01-hyperviseur/
│   │   ├── selection-justification.md ✅ Proxmox vs XCP-ng (choix + raisons)
│   │   ├── config-proxmox.md          ✅ Installation, clustering, HA
│   │   └── logs-implementation.txt    ✅ Preuves configuration
│   │
│   ├── 02-vms/
│   │   ├── dimensionnement.md         ✅ Specs par service (RDS, NAS client, etc.)
│   │   ├── templates/
│   │   │   └── windows-server.sh      ✅ Script template VM
│   │   └── inventaire-vms.md          ✅ Liste VMs + specs
│   │
│   ├── 03-reseau/
│   │   ├── vlans-config.md            ✅ VLAN 100/200/300/400 détail
│   │   ├── firewall-rules.md          ✅ Règles Fortinet HA
│   │   ├── matrix-flux.md             ✅ Tableau flux réseau complet
│   │   └── vpn-client.md              ✅ Accès distant médecins sécurisé
│   │
│   ├── 04-stockage/
│   │   ├── nas-qnap-config.md         ✅ NAS RAID6 (4TB + 4TB) snapshots
│   │   ├── rds-storage.md             ✅ Profils utilisateurs RDS
│   │   └── backup-strategy.md         ✅ Rotation backups Veeam
│   │
│   ├── 05-backup-pra/
│   │   ├── plan-backup-detaille.md    ✅ Veeam : 4x/jour incrémental + 1x/nuit full
│   │   ├── pra-procedure.md           ✅ Steps restauration VM complète
│   │   ├── test-restauration.md       ✅ Rapport test : date, durée, résultats
│   │   └── rpo-rto-mesure.md          ✅ Métriques vs objectifs
│   │
│   ├── 06-supervision/
│   │   ├── zabbix-config.md           ✅ Installation + agents VMs
│   │   ├── dashboards.md              ✅ Alertes sur services critiques
│   │   ├── elk-stack.md               ✅ Logs centralisés (si applicable)
│   │   └── screenshots-alertes.txt    ✅ Preuves fonctionnement
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

- [ ] Dimensionner VMs : RDS HA (médecins), NAS client, services web, admin
- [ ] Documenter 4 VLANs : Métier(100) / Invités(200) / Admin(300) / Imagerie(400)
- [ ] Firewall rules : isoler Imagerie, patient data, services critiques
- [ ] Accès médecins : VPN 2FA, accès RDS chiffré, audit trail
- [ ] Chiffrement disques VM (patient data)

**Livrables :**

- [ ] Tableau dimensionnement VMs + justif ressources
- [ ] Matrice flux réseau (32 colonnes max : utilisateurs, services internes, externes)
- [ ] Schéma VLANs + tags 802.1Q
- [ ] Config firewall (permettre métier, bloquer inter-VLAN non-autorisés)
- [ ] Documentation accès médecins (VPN, 2FA, RDS)

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

### Objectif 3️⃣ — Hybride On-Prem / Cloud (Backups AWS)

**MEDISOL Spécifique :**

- [ ] Justifier : on-prem pour données patient (latence basse, compliance HDS), cloud pour backups off-site
- [ ] Configurer backups Veeam → AWS Glacier (immuable, résilience)
- [ ] Documenter connectivité : site serveur campus → AWS (ou Equinix)
- [ ] Expliquer avantages : redondance géographique, conformité archivage
- [ ] Tester restauration depuis backup AWS

**Livrables :**

- [ ] Decision document hybrid (on-prem + AWS)
- [ ] Architecture connectivité on-prem ↔ cloud
- [ ] Config Veeam AWS Glacier
- [ ] Test restauration from cloud backup (rapport)

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

### Objectif 4️⃣ — Supervision VMs / Services Critiques

**MEDISOL Spécifique :**

- [ ] Zabbix/ELK/Grafana : monitorer RDS, NAS, Firewall, services métier
- [ ] Alertes seuils : CPU > 80%, RAM > 85%, Disk > 90%, RTO objectif breach
- [ ] Dashboard : état services critiques, incident trend
- [ ] Audit trail : accès patient data, logins RDS, changes firewall
- [ ] SLA monitoring : uptime RDS, latence réseau Métier VLAN

**Livrables :**

- [ ] Zabbix install guide + agent deployment
- [ ] Alert rules + thresholds documentation
- [ ] Screenshots dashboards supervision (live ou video)
- [ ] Audit logs exports (ex: RDS logins last week)

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

### Objectif 5️⃣ — Sauvegardes & PRA (Veeam MEDISOL)

**MEDISOL Spécifique :**

- [ ] Stratégie Veeam : 4x/jour incrémental + 1x/nuit full
- [ ] Rétention : 2 semaines on-site (NAS local), 3 mois off-site (AWS Glacier)
- [ ] RPO/RTO cibles : RPO 1h (accepté par clinique), RTO 30-60min
- [ ] Procédure restauration : VM patient data, RDS profil médecin, fichiers métier
- [ ] Effectuer drill PRA : restauration VM complète mesurée

**Livrables :**

- [ ] Backup policy document (Veeam settings)
- [ ] Rétention matrix (on-site vs off-site)
- [ ] Restore procedure (step-by-step avec screenshots)
- [ ] PRA test report (date, VMs testées, durée restauration, succès/fails)
- [ ] RPO/RTO calculated vs objectifs SLA

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

### Objectif 6️⃣ — VDI & Accès Distant (Médecins MEDISOL)

**MEDISOL Spécifique :**

- [ ] RDS Farm médecins : accès distant chiffré, 2FA, audit trail
- [ ] Profils utilisateurs : applis métier clinique (dossiers patients, agenda)
- [ ] Workspaces persistants (VDI personnalisée par médecin)
- [ ] Imprimantes clinique : redirection USB (lecteur smartcard), sécurisation
- [ ] Tester connexion RDS médecin + appli patient métier

**Livrables :**

- [ ] RDS architecture + security
- [ ] Template VM RDS + applis métier installées
- [ ] User profile documentation
- [ ] Test connexion RDS (log+screenshot médecin accessing app)
- [ ] Périphériques redirection (printer, smartcard reader)

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

### Objectif 7️⃣ — Hyper-V & Résilience (Lien Atelier Windows)

**MEDISOL Spécifique :**

- [ ] Lien atelier résilience Windows : failover clustering applicables MEDISOL ?
- [ ] Comparer Hyper-V vs Proxmox pour résilience : HA, live migration, SANs
- [ ] MEDISOL decision : Proxmox clustering HA OU Hyper-V SANs (justifier)
- [ ] Scénarios failover : défaillance nœud hyperviseur → RDS bascule < 1min
- [ ] Documenter test failover (arrêt VM, basculement, vérification services)

**Livrables :**

- [ ] Comparatif Hyper-V vs Proxmox pour MEDISOL
- [ ] Architecture résilience (failover, redondance, clustering)
- [ ] Failover test report (date, scénario, temps basculement)
- [ ] Lien explicite atelier Windows (ex: AD replication, WSFC concepts)

**État :** ❌ / ⚠️ / ✅ | **Notes :**

---

### Objectif 8️⃣ — PRA / PCO Complet (MEDISOL)

**MEDISOL Spécifique :**

- [ ] PRA documenté : procédure activation (quoi, qui, quand, comment)
- [ ] Services critiques : RDS, NAS patient data, Firewall, Zabbix
- [ ] RTO/RPO par service : RDS 30min, patient data 1h, admin services 4h
- [ ] Checklist PRA : contact manager, test backups, restore practice, comms
- [ ] Drill PRA effectué : test restauration ≥1 VM, vérification service, timing mesuré
- [ ] Post-drill : lessons learned, améliorations documentation

**Livrables :**

- [ ] PRA document complet (1-2 pages)
- [ ] Services critiques matrix (criticité, RTO/RPO cible)
- [ ] Activation checklist + responsabilités
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
