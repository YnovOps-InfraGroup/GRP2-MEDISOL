# 📋 Compte-Rendu — Entretien 1 MEDISOL

> **Date :** 26 mai 2026  
> **Lieu :** Locaux MEDISOL (1 000 m²)  
> **Client :** Gérante MEDISOL (Floriane)  
> **Équipe RMI :** Gregory M. (Chef de projet / Auditeur PRA) · Lylian C. (RSSI) · Thibaut D. (Architecte Infra)  
> **Statut :** ✅ Entretien 1 réalisé — Entretien 2 prévu 16 juin 2026

---

## 🏢 Présentation du Client

| Critère | Valeur |
|---------|--------|
| **Secteur** | Clinique médecine chinoise / médecine douce non conventionnée |
| **Effectif** | 32 personnes (accueil, praticiens, administration) |
| **Volumétrie** | ~200 patients/mois |
| **Horaires d'activité** | Lun–Ven 8h–19h |
| **Locaux** | 1 000 m² |
| **Croissance** | CA × 3 en 4 ans (clientèle "high-ticket") |
| **Remboursements** | Aucun (médecine non conventionnée — pas de carte Vitale) |

---

## 🔍 Infrastructure Existante — État Réel Découvert

> ⚠️ **Alerte critique** : L'infrastructure est décrite par la gérante elle-même comme *"un gruyère"*

### Serveur / Compute

| Composant | Réalité découverte | Risque |
|-----------|-------------------|--------|
| **"Serveur"** | Simple ordinateur Windows, 4 ans d'ancienneté, 2 To de stockage | 🔴 Critique |
| **Performances** | Stockage insuffisant et très lent aux heures de pointe | 🔴 Critique |
| **Redondance** | Aucune — single point of failure | 🔴 Critique |

### Réseau

| Composant | Réalité découverte | Risque |
|-----------|-------------------|--------|
| **WAN** | Box Orange fibrée Pro — aucune ligne de secours | 🔴 Critique |
| **Segmentation** | Réseau plat — caméras, postes métier, patients, admin sur le même réseau | 🔴 Critique |
| **Wi-Fi** | Plusieurs bornes déployées, couverture inégale selon les zones | 🟠 Haute |
| **Wi-Fi invités** | Non séparé du réseau métier | 🔴 Critique |

### Sécurité & Accès

| Composant | Réalité découverte | Risque |
|-----------|-------------------|--------|
| **Identifiants** | **Un seul compte partagé `Lyliandu33` pour tous les 32 employés** | 🔴 Critique |
| **Mot de passe** | Jamais modifié depuis l'origine | 🔴 Critique |
| **Chiffrement disque** | Windows BitLocker activé (décrit avec "une méga faille") | 🟠 Haute |
| **Politique MDP** | Inexistante | 🔴 Critique |

### Sauvegarde

| Composant | Réalité découverte | Risque |
|-----------|-------------------|--------|
| **Méthode** | Manuelle sur disque dur externe | 🔴 Critique |
| **Fréquence** | *"Quand j'ai envie"* (aucune planification) | 🔴 Critique |
| **Localisation** | Disque de sauvegarde stocké **sur site** | 🔴 Critique |
| **Backup off-site** | Inexistant | 🔴 Critique |
| **PRA/PCA** | Aucun plan documenté — aucun exercice jamais réalisé | 🔴 Critique |

### Vidéosurveillance

| Composant | Réalité découverte | Risque |
|-----------|-------------------|--------|
| **Caméras** | Hikvision PoE — usage dissuasif | 🟡 Moyen |
| **Stockage** | Local sur cartes SD — détection mouvement uniquement | 🟡 Moyen |
| **Rétention** | 1 semaine | 🟡 Moyen |
| **Serveur central** | Inexistant | 🟡 Moyen |

### Logiciel Métier

| Composant | Réalité découverte | Risque |
|-----------|-------------------|--------|
| **Application patient** | Client lourd Windows (éditeur tiers) | 🟠 Haute |
| **Problème** | Lenteurs marquées aux heures de pointe | 🟠 Haute |
| **Compatibilité RDS/VDI** | À vérifier avec l'éditeur | ⚠️ À qualifier |
| **Lecteur carte Vitale** | Non utilisé (clientèle high-ticket) | ℹ️ Info |
| **Prise de RDV** | Doctolib utilisé actuellement — envisagent d'arrêter | ℹ️ Info |

---

## 🎯 Besoins & Exigences Identifiés

### Disponibilité

| Exigence | Valeur confirmée | Source |
|----------|-----------------|--------|
| **Tolérance d'arrêt** (RTO) | **0 panne pendant 8h–19h** (maintenance possible soir/week-end) | Gérante |
| **Fenêtre maintenance** | Soirs après 19h, week-ends | Gérante |
| **Impact actuel** | Agacement clients, dégradation expérience — pas de perte financière directe chiffrée | Gérante |

### Sécurité & Conformité

| Exigence | Valeur confirmée |
|----------|-----------------|
| **Réglementation santé** | Exigée — données patients sensibles |
| **Souveraineté** | France uniquement (hébergeur certifié HDS, sol français) |
| **DPO / RGPD** | Aucun DPO en place actuellement |
| **Audit AIPD** | Non réalisé |

### Mobilité & Accès Distant

| Besoin | Détail |
|--------|--------|
| **Praticiens nomades** | Enregistrent des vocaux → secrétaire retranscrit. Souhait : accès facile aux données partagées |
| **Accès distant sécurisé** | À mettre en place (VPN ou solution équivalente) |

### Expérience Client

| Besoin | Détail |
|--------|--------|
| **Wi-Fi clients** | Qualité "4K streaming" souhaitée |
| **Salle VIP (high-ticket)** | Bonne couverture déjà présente — à maintenir |

---

## ⚠️ Risques Critiques Identifiés

| Risque | Probabilité | Impact | Priorité |
|--------|-------------|--------|----------|
| **Ransomware** | 🔴 Élevée (infrastructure vulnérable) | Perte totale données | P0 |
| **Panne serveur** | 🔴 Élevée (matériel de 4 ans, non redondé) | Arrêt activité > 8h | P0 |
| **Incendie / sinistre physique** | 🟡 Modérée | Perte irréversible données (backup sur site) | P0 |
| **Violation données patients** | 🔴 Élevée (compte unique partagé) | RGPD + HDS : sanctions financières | P0 |
| **Panne WAN** | 🔴 Élevée (single box Orange) | Arrêt total connectivité | P1 |
| **Cyberattaque ciblée** | 🟡 Modérée (contexte confrères) | Chiffrement ransomware | P1 |

> ⚠️ **Note importante** : L'ancien prestataire de MEDISOL a fait **faillite** suite à un incident critique chez Metalis (48h d'arrêt total). L'infrastructure a été laissée sans suivi depuis.

---

## 💰 Budget & Approche Commerciale

| Élément | Situation |
|---------|-----------|
| **Enveloppe définie** | ❌ Non — aucune enveloppe fixée |
| **Demande client** | 2 à 3 propositions à différents niveaux (budget / service) |
| **Ouverture cloud** | ✅ Totale — migration 100% cloud acceptée |
| **Positionnement** | Recherche prestataire "étiquette premium" |
| **CA estimé** | Fort (×3 en 4 ans) — marge de manœuvre budgétaire |

### Scénarios à proposer

1. **Option A — Migration Cloud Complète** : Infrastructure as a Service, zéro on-prem (SaaS patient + stockage cloud souverain)
2. **Option B — Hybride** : On-prem modernisé + cloud pour backups et mobilité
3. **Option C — Amélioration Minimale** : Remplacement matériel, segmentation réseau, backup off-site

---

## 📌 Projets Futurs (Non Prioritaires)

| Projet | Statut | Notes |
|--------|--------|-------|
| Portail patient en ligne | 💤 En attente | Envisagé mais pas pour maintenant |
| Prise de RDV en ligne personnalisée | 💤 En attente | Remplacement Doctolib souhaité |
| IA locale retranscription vocaux | 💤 En attente | Évoqué par RMI — nécessite prestataire spécialisé |

---

## ✅ Actions Définies en Réunion

| # | Action | Responsable | Deadline |
|---|--------|-------------|----------|
| 1 | Réaliser audit on-site complet (matériel, réseau, caméras) | Thibaut D. | Avant entretien 2 |
| 2 | Proposer 2–3 offres avec niveaux de service et budgets | Gregory M. | Avant entretien 2 |
| 3 | Qualifier la compatibilité RDS/VDI du logiciel patient (contacter éditeur) | Thibaut D. | Avant entretien 2 |
| 4 | Évaluer options souveraineté française HDS (OVH, Scaleway, Outscale) | Lylian C. | Avant entretien 2 |
| 5 | Estimer volumétrie future (dimensionnement 1 000 utilisateurs potentiels) | Thibaut D. | Avant entretien 2 |
| 6 | Préparer checklist RGPD + HDS pour prochaine réunion | Lylian C. | Avant entretien 2 |

---

## ❓ Points à Clarifier (Entretien 2 — 16 juin 2026)

- [ ] Quel est l'éditeur exact du logiciel patient (compatibilité RDS/VDI) ?
- [ ] Quelle est la volumétrie exacte des données imagerie stockées ?
- [ ] Y a-t-il des équipements de mesure connectés à l'ordinateur "serveur" ?
- [ ] Les praticiens nomades ont-ils des postes fournis par MEDISOL ?
- [ ] Quel est le contrat SLA actuel avec l'hébergeur/opérateur ?
- [ ] Politique RGPD actuellement appliquée (consentements, durée rétention) ?
- [ ] Souhait exact concernant Doctolib (arrêt immédiat ou migration planifiée) ?

---

## 📎 Documents Associés

- [ARCHITECTURE.md](./ARCHITECTURE.md) — Architecture cible en cours de définition
- [REQUIREMENTS.md](./REQUIREMENTS.md) — Exigences mises à jour post-entretien
- [SKILLS_VALIDATION.md](../SKILLS_VALIDATION.md) — Grille objectifs pédagogiques

---

**Prochain RDV :** Entretien 2 — 16 juin 2026 (matin, sujet 4)  
**Email rendu :** florian.guillemard@ynov.com avant le 22 juin 23h
