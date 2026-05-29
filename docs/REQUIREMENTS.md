# REQUIREMENTS.md - MEDISOL Project

**Version:** 1.1 (Post-Entretien 1)
**Last Updated:** 29 Mai 2026
**Groupe 2 :** Gregory M. · Lylian C. · Thibaut D.
**Source :** [Compte-rendu Entretien 1](./ENTRETIEN_1_COMPTE_RENDU.md) — 26 mai 2026

> ⚠️ **Infrastructure actuelle réelle :** Simple PC Windows 4 ans, 2 To, compte `Lyliandu33` partagé par 32 employés, backup manuel irrégulier, réseau plat. **Aucun PRA**.

---

## 📋 Exigences Métier

### 1. Disponibilité & PRA

| Exigence                    | Valeur                     | Source                         |
| --------------------------- | -------------------------- | ------------------------------ |
| **Tolérance d'arrêt (RTO)** | Zéro panne 8h–19h          | Confirmé gérante — entretien 1 |
| **Fenêtre maintenance**     | Soirs après 19h, week-ends | Confirmé gérante               |
| **RPO (perte données max)** | 1 heure                    | À confirmer entretien 2        |
| **Disponibilité cible**     | 99,9 % en heures ouverture | Objectif RMI                   |
| **PRA actuel**              | **Inexistant**             | Confirmé entretien 1           |
| **Tests PRA**               | Jamais réalisés            | Confirmé gérante               |
| **Fenêtre maintenance**     | Sam/Dim + soirs            | Confirmé                       |

### 2. Sécurité & Conformité

| Exigence                | Statut actuel                                      | Cible                                                          |
| ----------------------- | -------------------------------------------------- | -------------------------------------------------------------- |
| **HDS**                 | ❌ Aucune certification                            | ✅ Azure France Central — certifié HDS (obligation légale)     |
| **Souveraineté**        | ❌ Données sur PC local non sécurisé               | ✅ Azure France Central + France South (données FR uniquement) |
| **RGPD**                | ❌ Aucun DPO, aucune AIPD                          | ✅ DPO à désigner, AIPD à réaliser (Azure Defender for Cloud)  |
| **Gestion comptes**     | ❌ **Compte unique `Lyliandu33`** pour 32 employés | ✅ Comptes nominatifs + Microsoft Entra ID P2                  |
| **Mot de passe**        | ❌ Jamais modifié                                  | ✅ Politique MDP stricte + rotation                            |
| **Chiffrement disque**  | ⚠️ BitLocker ("méga faille" selon gérante)         | ✅ Azure SSE AES-256 natif (géré Azure)                        |
| **Chiffrement transit** | ❌ Non confirmé                                    | ✅ TLS 1.2+ enforced Azure + Azure Firewall                    |
| **Audit trail**         | ❌ Inexistant                                      | ✅ Microsoft Sentinel + Log Analytics Workspace                |
| **2FA**                 | ❌ Inexistant                                      | ✅ Entra ID Conditional Access (MFA obligatoire)               |
| **Segmentation réseau** | ❌ Réseau plat unique                              | ✅ Azure VNet Subnets + NSG + Azure Firewall Premium           |

### 3. Performance & Utilisateurs

| Exigence                           | Valeur confirmée                       | Notes                |
| ---------------------------------- | -------------------------------------- | -------------------- |
| **Utilisateurs simultanés**        | 32 (toute l'équipe)                    | Confirmé entretien 1 |
| **Patients/mois**                  | ~200                                   | Confirmé entretien 1 |
| **Temps réponse logiciel patient** | Actuellement lent aux heures de pointe | Objectif < 2s        |
| **Wi-Fi clients**                  | Streaming 4K souhaité                  | Confirmé entretien 1 |
| **Latence VPN praticiens nomades** | À définir                              | < 100ms objectif     |

### 4. Données & Stockage

| Exigence                  | Valeur actuelle              | Cible                                          |
| ------------------------- | ---------------------------- | ---------------------------------------------- |
| **Stockage actuel**       | 2 To (PC Windows)            | Azure Files Premium + Azure NetApp Files       |
| **Volume data**           | À mesurer lors audit on-site | ~500 GB estimé (scalable)                      |
| **Rétention légale**      | Non appliquée                | 5–6 ans — Azure Lifecycle Management           |
| **Backup fréquence**      | Manuel, irrégulier           | Azure Backup GRS — RPO 1h                      |
| **Backup off-site**       | ❌ Inexistant                | ✅ Azure Backup GRS (France South)             |
| **Protection ransomware** | ❌ Aucune                    | ✅ Soft delete 30j + snapshots immuables Azure |

---

## 🔧 Exigences Techniques Cibles (Infrastructure déployée via Terraform)

> ℹ️ **Contexte :** L'infrastructure actuelle (PC Windows, compte Lyliandu33, réseau plat) n'est pas gérée par Terraform.
> Les exigences ci-dessous décrivent l'**infrastructure cible** qui sera déployée via Terraform sur Azure.

### A. Réseau Azure (cible)

- [ ] Azure VNet `10.0.0.0/16` avec 4 subnets dédiés (AVD, Stockage, Admin, Bastion)
- [ ] NSG par subnet : règles entrée/sortie documentées et auditables
- [ ] Azure Firewall Premium : IDPS activé, TLS inspection, force-tunnel
- [ ] Azure VPN Gateway P2S (VpnGw2) pour praticiens nomades (certificats)
- [ ] Azure Bastion pour accès admin RDP/SSH sans IP publique
- [ ] Wi-Fi on-premises (Aruba/Ubiquiti) supervisé via Azure Arc
- [ ] Pas d'IP publique directe sur aucune ressource Azure

### B. Compute / VDI Azure (cible)

- [ ] Azure Virtual Desktop — Host Pool Pooled (32 users) + Personal (praticiens nomades)
- [ ] Session Hosts en Availability Zone (Standard_D4s_v3 ou équivalent AVD)
- [ ] FSLogix Profile Containers sur Azure Files Premium
- [ ] Test compatibilité logiciel patient dans session AVD (latence < 2s)
- [ ] Licences Microsoft 365 E3/E5 (inclut AVD + Entra ID P2)
- [ ] Image AVD versionée + déployée via Terraform (`azurerm_virtual_desktop_*`)

### C. Stockage Azure (cible)

- [ ] Azure Files Premium (SMB 3.0) pour données patients — chiffrement SSE AES-256 natif
- [ ] Azure NetApp Files pour imageries médicales volumineuses
- [ ] Snapshots automatiques toutes les 6h (politique Azure Backup)
- [ ] Soft delete activé — rétention 30 jours (protection ransomware)
- [ ] Lifecycle Management : archivage automatique selon ancienneté (rétention légale 5-6 ans)
- [ ] Quota par share configuré (capacity planning)

### D. Sauvegarde & DR Azure (cible)

- [ ] Recovery Services Vault (GRS) — réplication France Central → France South
- [ ] Politique backup Azure : AVD Session Hosts + Azure Files — RPO 1h
- [ ] Azure Site Recovery (ASR) : réplication asynchrone des VMs critiques
- [ ] Snapshots immuables (Immutable Blob Storage) — 30 jours minimum
- [ ] Test restauration mensuel documenté (RTO mesuré vs objectif < 30 min)
- [ ] Chiffrement AES-256 en transit (TLS 1.2+) et au repos (Azure SSE)

### E. Monitoring & Sécurité Azure (cible)

- [ ] Log Analytics Workspace dédié MEDISOL (Diagnostic Settings sur toutes ressources)
- [ ] Microsoft Sentinel : règles d'alertes HDS, audit trail accès patients
- [ ] Azure Monitor Alerts : CPU, disk, AVD session failures → Action Groups email/SMS
- [ ] Azure Workbooks : dashboard opérationnel + dashboard direction (uptime, incidents)
- [ ] Defender for Cloud : score de sécurité + recommandations conformité HDS
- [ ] SLA reporting mensuel exporté depuis Azure Monitor

---

## 👥 Rôles & Responsabilités

| Rôle                              | Nom        | Responsabilités                 | Interne/Externe      |
| --------------------------------- | ---------- | ------------------------------- | -------------------- |
| **Chef de Projet / Auditeur PRA** | Gregory M. | Planning, PRA/PCA, coordination | Interne (RMI)        |
| **RSSI**                          | Lylian C.  | Conformité HDS/RGPD, sécurité   | Interne (RMI)        |
| **Architecte Infra**              | Thibaut D. | Design, déploiement, tests      | Interne (RMI)        |
| **Admin IT MEDISOL**              | À recruter | Support jour, escalade incident | À désigner (MEDISOL) |
| **Gérante MEDISOL**               | Floriane   | Approbation décisions, budget   | Direction (MEDISOL)  |

---

## � Stack Technique Azure

| Composant   | Service / Outil                          | Version               |
| ----------- | ---------------------------------------- | --------------------- |
| IaC         | Terraform (`azurerm` provider)           | ≥ 4.x                 |
| VDI         | Azure Virtual Desktop (AVD)              | Pooled + Personal     |
| Identité    | Microsoft Entra ID P2                    | + MFA + CA            |
| Stockage    | Azure Files Premium + Azure NetApp Files | —                     |
| Backup      | Azure Backup (GRS) + ASR                 | Vault France Central  |
| Monitoring  | Azure Monitor + Log Analytics + Sentinel | —                     |
| Firewall    | Azure Firewall Premium                   | IDPS + TLS inspection |
| VPN         | Azure VPN Gateway P2S                    | VpnGw2                |
| Accès admin | Azure Bastion                            | —                     |
| Secrets     | Azure Key Vault                          | Standard              |

## 📅 Timeline Déploiement Terraform

- **Semaines 1–2** : Foundation (VNet, Entra ID, Key Vault)
- **Semaines 3–4** : Services cœur (AVD, Azure Files, NetApp)
- **Semaines 5–6** : Backup + Monitoring (ASR, Sentinel, alertes)
- **Semaines 7–8** : Migration données + basculement pilot (5 users)
- **Semaine 9+** : Cutover 32 users + mise hors service PC Windows
- **Semaines 9-10** : Tests PRA + Validation HDS
- **Semaine 11+** : Mise en production + Support

---

## 💰 Budget (Estimé — modèle OPEX Azure)

> ℹ️ **Modèle Azure = zéro CapEx matériel.** Coûts mensuels Azure + intégration RMI uniquement.

| Poste                          | Détail                            | Coût mensuel estimé |
| ------------------------------ | --------------------------------- | ------------------- |
| **Azure Compute (AVD)**        | Session Hosts Standard_D4s_v3 × 3 | ~450 €/mois         |
| **Azure Files Premium**        | 1 To (patients + FSLogix)         | ~120 €/mois         |
| **Azure NetApp Files**         | 4 To imageries                    | ~300 €/mois         |
| **Azure Firewall Premium**     | IDPS + TLS                        | ~900 €/mois         |
| **VPN Gateway P2S**            | VpnGw2                            | ~180 €/mois         |
| **Azure Backup + ASR**         | GRS Recovery Vault                | ~80 €/mois          |
| **Microsoft Sentinel**         | ~2 Go/j logs                      | ~120 €/mois         |
| **Licences M365 E3**           | 32 users                          | ~640 €/mois         |
| **TOTAL OPEX**                 |                                   | **~2 800 €/mois**   |
| **Intégration RMI (one-shot)** | Design + déploiement Terraform    | ~12 000 €           |

> Estimations à affiner lors de l'entretien 2 (sizing réel, volumes data).

---

## ✅ Critères d'Acceptation

Projet considéré "réussi" si :

- [ ] 99.9% uptime mesuré via Azure Monitor (SLA report exporté)
- [ ] RTO < 30 min — ASR Test Failover réussi et documenté
- [ ] Audit HDS compliant — rapport Defender for Cloud + Azure Policy
- [ ] Azure Backup restore test réussi (rapport daté, RTO mesuré)
- [ ] Comptes individuels Entra ID — compte `Lyliandu33` désactivé
- [ ] MFA activé sur 100% des comptes (Conditional Access policy active)
- [ ] Équipe MEDISOL formée : onboarding AVD + procédure incident documentée
- [ ] Infrastructure entièrement déployée via Terraform (pas de ressources manuelles)
- [ ] Zéro credential en clair dans le code Terraform (Key Vault + Managed Identity)

---

## 🚫 Points NON Inclus

- Formation utilisateurs approfondie (onboarding de base inclus, formation avancée hors scope)
- Modernisation du logiciel patient (Lift & Shift AVD seulement — refonte app hors scope)
- Migration vers Azure AD DS / Active Directory on-prem (Entra ID standalone suffisant)
- Gestion poste de travail physique (MDM/Intune hors scope Phase 1)
- Infrastructure Wi-Fi physique (câblage, bornes — existant conservé, supervisé via Azure Arc)
- Cloud migration (Phase 2)

---

## 📞 Questions Clarification

À valider avec client :

1. **RTO exact ?** Actuellement 30-60min - est-ce acceptable ?
2. **Budget flexible ?** 50k€ estimé, flexibilité jusqu'à X% ?
3. **Logiciel patient details ?** Éditeur/version/compatibility RDS ?
4. **Praticiens nomades** : Combien ? Accès VPN 24/7 necessary ?
5. **Maintenance post** : RMI continue ou equipe interne formée ?
6. **Escalade incident** : Qui appeler 24/7 en problème critique ?

---

**Next Step:** Signature client → Architecture détaillée → Déploiement
