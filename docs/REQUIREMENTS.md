# REQUIREMENTS.md - MEDISOL Project

**Version:** 1.1 (Post-Entretien 1)  
**Last Updated:** 29 Mai 2026  
**Groupe 2 :** Gregory M. · Lylian C. · Thibaut D.  
**Source :** [Compte-rendu Entretien 1](./ENTRETIEN_1_COMPTE_RENDU.md) — 26 mai 2026

> ⚠️ **Infrastructure actuelle réelle :** Simple PC Windows 4 ans, 2 To, compte `Lyliandu33` partagé par 32 employés, backup manuel irrégulier, réseau plat. **Aucun PRA**.

---

## 📋 Exigences Métier

### 1. Disponibilité & PRA

| Exigence | Valeur | Source |
|----------|--------|--------|
| **Tolérance d'arrêt (RTO)** | Zéro panne 8h–19h | Confirmé gérante — entretien 1 |
| **Fenêtre maintenance** | Soirs après 19h, week-ends | Confirmé gérante |
| **RPO (perte données max)** | 1 heure | À confirmer entretien 2 |
| **Disponibilité cible** | 99,9 % en heures ouverture | Objectif RMI |
| **PRA actuel** | **Inexistant** | Confirmé entretien 1 |
| **Tests PRA** | Jamais réalisés | Confirmé gérante |
| **Fenêtre maintenance** | Sam/Dim + soirs | Confirmé |

### 2. Sécurité & Conformité

| Exigence | Statut actuel | Cible |
|----------|--------------|-------|
| **HDS** | ❌ Aucune certification | ✅ Obligatoire (données santé) |
| **Souveraineté** | ❌ Données sur PC local non sécurisé | ✅ Hébergeur certifié HDS, sol français |
| **RGPD** | ❌ Aucun DPO, aucune AIPD | ✅ DPO à désigner, AIPD à réaliser |
| **Gestion comptes** | ❌ **Compte unique `Lyliandu33`** pour 32 employés | ✅ Comptes nominatifs + AD |
| **Mot de passe** | ❌ Jamais modifié | ✅ Politique MDP stricte + rotation |
| **Chiffrement disque** | ⚠️ BitLocker ("méga faille" selon gérante) | ✅ AES-256 validé |
| **Chiffrement transit** | ❌ Non confirmé | ✅ TLS 1.2+ |
| **Audit trail** | ❌ Inexistant | ✅ Logs tous accès patients |
| **2FA** | ❌ Inexistant | ✅ Accès distants obligatoire |
| **Segmentation réseau** | ❌ Réseau plat unique | ✅ VLAN métier/invités/admin/imagerie |

### 3. Performance & Utilisateurs

| Exigence | Valeur confirmée | Notes |
|----------|-----------------|-------|
| **Utilisateurs simultanés** | 32 (toute l'équipe) | Confirmé entretien 1 |
| **Patients/mois** | ~200 | Confirmé entretien 1 |
| **Temps réponse logiciel patient** | Actuellement lent aux heures de pointe | Objectif < 2s |
| **Wi-Fi clients** | Streaming 4K souhaité | Confirmé entretien 1 |
| **Latence VPN praticiens nomades** | À définir | < 100ms objectif |

### 4. Données & Stockage

| Exigence | Valeur actuelle | Cible |
|----------|----------------|-------|
| **Stockage actuel** | 2 To (PC Windows) | NAS RAID6 redondant |
| **Volume data** | À mesurer lors audit on-site | ~500 GB estimé |
| **Rétention légale** | Non appliquée | 5–6 ans (réglementation santé) |
| **Backup fréquence** | Manuel, irrégulier | 4×/jour incrémental + 1×/nuit full |
| **Backup off-site** | ❌ Inexistant | ✅ Cloud HDS (OVH/Scaleway) |
| **Protection ransomware** | ❌ Aucune | ✅ Snapshots immuables 30j |

---

## 🔧 Exigences Techniques

### A. Réseau

- [ ] Firewall dual WAN (failover automatique)
- [ ] Switchs managés L3 avec redondance
- [ ] VLAN 4 : Métier (100), Invités (200), Admin (300), Imagerie (400)
- [ ] Wi-Fi 6 mesh + séparation SSID par VLAN
- [ ] VPN IPSec pour praticiens nomades
- [ ] Pas d'IP publique directe sur serveurs
- [ ] Firewall rules documentées

### B. Calcul (RDS)

- [ ] 2 serveurs RDS HA (failover auto 5min)
- [ ] Logiciel patient optimisé RDS (test compatibilité)
- [ ] Windows Server 2022 latest patches
- [ ] Monitoring CPU/RAM/Disk alertes
- [ ] Licenses Microsoft RDS CAL appropriées
- [ ] Connection broker load-balancing

### C. Stockage (NAS)

- [ ] NAS primaire RAID6 (2 disques panne tolérée)
- [ ] Snapshots automatiques 6h (immuable 30j)
- [ ] NAS secondaire réplication iSCSI (test failover mensuel)
- [ ] Accès CIFS/NFS/iSCSI according to use
- [ ] Deduplication activée si possible
- [ ] Quota par utilisateur (capacity planning)

### D. Sauvegarde

- [ ] Backup incrémental 4x/jour (RDS + NAS)
- [ ] Backup complet 1x/nuit
- [ ] Rétention : 30j local + 90j cloud
- [ ] Cloud backup AWS Glacier (région EU, HDS compliant)
- [ ] Restore test mensuel documenté
- [ ] Encryption AES-256 en transit + au repos

### E. Monitoring & Alertes

- [ ] Monitoring agent tous serveurs
- [ ] Alertes email/SMS critiques
- [ ] Dashboard métier (KPIs direction)
- [ ] SLA reporting mensuel (uptime %)
- [ ] Logs centralisés (syslog + audit)

---

## 👥 Rôles & Responsabilités

| Rôle | Nom | Responsabilités | Interne/Externe |
|------|-----|-----------------|----------------|
| **Chef de Projet / Auditeur PRA** | Gregory M. | Planning, PRA/PCA, coordination | Interne (RMI) |
| **RSSI** | Lylian C. | Conformité HDS/RGPD, sécurité | Interne (RMI) |
| **Architecte Infra** | Thibaut D. | Design, déploiement, tests | Interne (RMI) |
| **Admin IT MEDISOL** | À recruter | Support jour, escalade incident | À désigner (MEDISOL) |
| **Gérante MEDISOL** | Floriane | Approbation décisions, budget | Direction (MEDISOL) |

---

## 📅 Timeline Indicatif

- **Semaines 1-2** : Audit + Validation architecture
- **Semaines 3-4** : Commande équipements + Préparation
- **Semaines 5-8** : Déploiement infrastructure
- **Semaines 9-10** : Tests PRA + Validation HDS
- **Semaine 11+** : Mise en production + Support

---

## 💰 Budget (Estimé)

- **Equipements** : 25k€
- **Licences** : 8k€
- **Services intégration** : 12k€
- **Support 1an** : 5k€
- **TOTAL** : 50k€

---

## ✅ Critères d'Acceptation

Projet considéré "réussi" si :

- [ ] 99.9% uptime atteint (mesurable Zabbix)
- [ ] RTO <60min démo failover réussi
- [ ] Audit HDS compliant (rapport audit)
- [ ] Backup restore test réussi (evidenced)
- [ ] Equipe MEDISOL formée (traçabilité)
- [ ] Documentation complète & à jour
- [ ] Zéro incident sécurité mois 1

---

## 🚫 Points NON Inclus

- Formation utilisateurs (hors scope initial)
- Modernisation application métier (Lift & Shift seulement)
- Infrastructure secondaire/DR site (Phase 2)
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
