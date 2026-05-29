# 🏥 MEDISOL - Modernisation Infrastructure

**Groupe 2 — RMI (Run My Infra)** | Sujet 4 — Clinique bien-être | Virtualisation M1 INFRA 2025-2026

> **Équipe :** Gregory M. _(Chef de projet / Auditeur PRA)_ · Lylian C. _(RSSI)_ · Thibaut D. _(Architecte Infra)_
> **Client :** MEDISOL (Floriane) — Clinique médecine douce, ~200 patients/mois, 32 employés
> **Entretien 1 :** ✅ 26 mai 2026 | **Entretien 2 :** ⏳ 16 juin 2026 matin | **Rendu :** 22 juin 23h

## 📋 Contexte du Projet

**MEDISOL** est une clinique de médecine chinoise en forte croissance (CA × 3 en 4 ans, clientèle high-ticket). L'infrastructure actuelle est décrite par la gérante elle-même comme _"un gruyère"_ — aucune redondance, compte utilisateur unique partagé, backups manuels irréguliers. Ce projet vise à moderniser de fond en comble cette infrastructure tout en assurant conformité HDS/RGPD.

### Enjeux Clés (confirmés entretien 1)

- 🔴 **Sécurité critique** — Compte unique `Lyliandu33` partagé par 32 employés, jamais modifié
- 🔴 **Infrastructure fragile** — "Serveur" = simple PC Windows 4 ans, 2 To, aucune redondance
- 🔴 **Aucune sauvegarde fiable** — Backup manuel irrégulier, disque sur site, aucun PRA
- 🔴 **Réseau plat** — Caméras, patients et métier sur le même réseau, zéro segmentation
- 🔒 **Conformité HDS/RGPD** — Souveraineté française exigée, aucun DPO en place
- ⚡ **Disponibilité** — Exigence "zéro panne" 8h–19h (maintenance soirs/week-ends OK)
- 🌐 **Mobilité** — Praticiens nomades, accès distant à sécuriser
- 📶 **Wi-Fi** — Couverture inégale, clients souhaitent streaming 4K

---

## 📚 Validation des Compétences

**IMPORTANT** : Consulter [SKILLS_VALIDATION.md](./SKILLS_VALIDATION.md) pour :

- ✅ Grille de validation des **8 objectifs pédagogiques** (Hyperviseur, Ressources, Hybride, Supervision, PRA/Backups, VDI, Hyper-V, PRA/PCO)
- 📋 Checklists de rendu (22 juin 23h)
- 📊 Matrices d'auto-évaluation par objectif
- ⚠️ Risques identifiés et mitigations
- 📅 Timeline validation semaine par semaine

---

## 🎯 Objectifs du Projet

| Objectif                                                     | Priorité    | Statut        |
| ------------------------------------------------------------ | ----------- | ------------- |
| Migrer vers Azure (PC → Full Cloud Azure France Central HDS) | 🔴 Critique | En cours      |
| Implémenter PRA/PCA + tests                                  | 🔴 Critique | Planification |
| Sécuriser accès (comptes individuels, 2FA, politique MDP)    | 🔴 Critique | Planification |
| Segmenter le réseau (VLAN 4 niveaux)                         | 🔴 Critique | Planification |
| Backup automatisé, off-site, immuable                        | 🔴 Critique | Planification |
| Conformité HDS + RGPD (souveraineté FR)                      | 🟠 Haute    | À auditer     |
| Accès distant praticiens nomades (AVD + P2S VPN)             | 🟠 Haute    | À qualifier   |
| Wi-Fi segmenté + couverture 4K clients (on-prem, Azure Arc)  | 🟠 Haute    | À déployer    |

---

## 📦 Structure du Projet

```
GRP2-MEDISOL/
├── docs/
│   ├── ARCHITECTURE.md          # Architecture cible
│   ├── AUDIT_FINDINGS.md        # Résultats audit initial
│   ├── REQUIREMENTS.md          # Exigences détaillées
│   ├── PRA_PCA_PLAN.md          # Plan de reprise d'activité
│   └── CONFORMITE_HDS.md        # Checklist conformité
├── infrastructure/
│   └── terraform/               # IaC Terraform (azurerm)
│       ├── modules/
│       │   ├── networking/      # VNet, NSG, Azure Firewall
│       │   ├── identity/        # Entra ID, RBAC, MFA
│       │   ├── avd/             # Azure Virtual Desktop
│       │   ├── storage/         # Azure Files, NetApp Files
│       │   ├── backup/          # Recovery Services Vault
│       │   ├── monitoring/      # Log Analytics, Sentinel
│       │   └── vpn/             # VPN Gateway P2S + Bastion
│       └── environments/
│           ├── staging/
│           └── production/
├── scripts/
│   ├── backup/                  # Runbooks Azure Automation
│   ├── restore/                 # Procédures ASR + restore
│   └── deploy/                  # Scripts AzCopy migration
├── tests/
│   ├── pra_tests/               # Tests PRA réguliers
│   └── security_tests/          # Tests de sécurité
├── README.md
├── CONTRIBUTING.md
└── .gitignore
```

---

## 🚀 Démarrage Rapide

### Prérequis

- Subscription Azure dédiée (ou sandbox) avec droits Owner
- Terraform ≥ 1.7 (`terraform --version`)
- Azure CLI (`az login`) + `gh` CLI configuré
- Accès admin infrastructure MEDISOL on-site (audit Wi-Fi)

### Étapes Initiales

1. ✅ **Entretien 1** → Compte-rendu rédigé ([docs/ENTRETIEN_1_COMPTE_RENDU.md](./docs/ENTRETIEN_1_COMPTE_RENDU.md))
2. 🔄 **Audit Infrastructure** → Inventaire on-site à planifier ([docs/AUDIT_FINDINGS.md](./docs/AUDIT_FINDINGS.md))
3. 🔄 **Définir Requirements** → Mise à jour post-entretien ([docs/REQUIREMENTS.md](./docs/REQUIREMENTS.md))
4. ⏳ **Architecture Design** → 3 scénarios à proposer ([docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md))
5. ⏳ **PRA Planning** → Aucun PRA existant — à construire de zéro ([docs/PRA_PCA_PLAN.md](./docs/PRA_PCA_PLAN.md))

---

## 📋 Checklist Conformité HDS/RGPD

- [ ] Audit complet données patients (localisation, chiffrement)
- [ ] AIPD (Analyse Impact Protection Données) complétée
- [ ] DPO désigné et rôle clarifié
- [ ] Politique rétention données validée
- [ ] Chiffrement données au repos ✓
- [ ] Chiffrement données en transit (TLS) ✓
- [ ] Segmentation réseau métier/sensible/invités
- [ ] Accès distants VPN/MFA configurés
- [ ] Sauvegardes immuables/déconnectées
- [ ] Audit trail complet (logs)
- [ ] Plan de réponse incident
- [ ] Tests PRA mensuels documentés

---

## 🔐 Sécurité

**❌ DONNÉES SENSIBLES STRICTEMENT INTERDITES** dans ce repo (public) :

- ⛔ Pas de mots de passe, API keys, tokens
- ⛔ Pas d'adresses IP réelles, domaines internes
- ⛔ Pas de données patient, même fictives
- ⛔ Pas de configs production complètes

Utiliser `.env.template` pour les configurations (voir `.gitignore`).

---

## 📞 Points de Contact

| Rôle                          | Nom        | Responsabilité                |
| ----------------------------- | ---------- | ----------------------------- |
| Chef de Projet / Auditeur PRA | Gregory M. | PRA/PCA, coordination client  |
| RSSI                          | Lylian C.  | Sécurité, conformité HDS/RGPD |
| Architecte Infra              | Thibaut D. | Hyperviseur, réseau, stockage |
| Formateur / Client simulé     | Florian G. | Entretiens, validation        |

> **Organisation :** Groupe 2 — Paire : Sujet 1 METALIS + Sujet 4 MEDISOL

---

## 📅 Calendrier MSPR

| Date                 | Événement                                       | Statut   |
| -------------------- | ----------------------------------------------- | -------- |
| 26 mai 2026          | ✅ Entretien 1 MEDISOL                          | Réalisé  |
| Sem. 1–3             | Audit on-site + Architecture 3 scénarios        | En cours |
| 16 juin 2026 (matin) | ⏳ Entretien 2 MEDISOL                          | À venir  |
| 16 → 22 juin         | Finalisation docs + tests PRA                   | À venir  |
| **22 juin 23h**      | **Rendu final** → <florian.guillemard@ynov.com> | ⏳       |
| 23 juin              | Annonce cas soutenance                          | ⏳       |
| 25 juin              | Soutenance (si MEDISOL annoncé)                 | ⏳       |

---

## 📚 Documentation Externe Utile

- [HDS - Hébergement Données Santé](https://esante.gouv.fr/)
- [RGPD & Santé](https://www.cnil.fr/fr/rgpd-et-sante)
- [ANSSI - Bonnes Pratiques](https://www.anssi.gouv.fr/)
- [Microsoft 365 Compliance](https://docs.microsoft.com/compliance/)

---

## 💬 Questions ?

Consulter les **Issues** du projet ou contacter l'équipe RMI (Run My Infra).

---

**Last Updated:** 29 Mai 2026
**Groupe :** 2 — Gregory M. · Lylian C. · Thibaut D.
**Status :** 🟡 Post-Entretien 1 — Audit & Architecture en cours
