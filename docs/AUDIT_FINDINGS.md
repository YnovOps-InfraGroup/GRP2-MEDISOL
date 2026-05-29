# AUDIT_FINDINGS.md — État Infrastructure MEDISOL

**Version :** 0.1 (Pré-audit — données entretien 1)
**Date entretien :** 26 mai 2026
**Rédigé par :** Gregory M. · Lylian C. · Thibaut D. (RMI)
**Source :** [Compte-rendu Entretien 1](./ENTRETIEN_1_COMPTE_RENDU.md) · Notes Notion

> ⚠️ **Statut :** Données collectées en entretien 1. Audit on-site à planifier pour mesures précises (capacité disque, topologie réseau, inventaire complet).

---

## 🏢 Contexte Business

| Élément            | Valeur                                                            |
| ------------------ | ----------------------------------------------------------------- |
| Activité           | Clinique médecine chinoise (médecine douce non conventionnée)     |
| Clientèle          | High-ticket (pas de carte vitale)                                 |
| Patients           | ~200/mois                                                         |
| Employés           | 32 (praticiens, accueil, admin, compta, RH)                       |
| Locaux             | ~1 000 m²                                                         |
| Horaires           | 8h–19h, lun–ven                                                   |
| Croissance         | CA × 3 en 4 ans                                                   |
| Praticiens nomades | Oui — consultations domicile, enregistrements vocaux → secrétaire |
| Prise de RDV       | Doctolib (réflexion d'arrêt en cours)                             |

---

## 🖥️ Inventaire Matériel (Déclaratif — à confirmer audit on-site)

### Serveur / Stockage Principal

| Élément          | État constaté                                             |
| ---------------- | --------------------------------------------------------- |
| **Type réel**    | ❌ Simple PC Windows (PAS un serveur)                     |
| **Âge**          | ~4 ans                                                    |
| **Stockage**     | 2 To HDD (interne, non redondé)                           |
| **OS**           | Windows (version à confirmer)                             |
| **Localisation** | Salle d'imagerie                                          |
| **Redondance**   | ❌ Aucune (SPOF total)                                    |
| **Chiffrement**  | BitLocker (qualifié de "méga faille" par la gérante)      |
| **Performances** | "Lent" — impact sur logiciel patient aux heures de pointe |

### Réseau

| Composant                | État                                                      |
| ------------------------ | --------------------------------------------------------- |
| **WAN**                  | Box Orange Fibre Pro — unique, aucune redondance          |
| **Ligne secondaire**     | ❌ Inexistante                                            |
| **Topologie LAN**        | ❌ Réseau plat non segmenté                               |
| **Segments coexistants** | Caméras IP + patients + métier + admin sur le MÊME réseau |
| **Switch**               | Inconnu — à inventorier lors de l'audit on-site           |
| **Wi-Fi**                | Plusieurs bornes déployées, couverture **inégale**        |
| **Salle VIP clients**    | Bonne couverture Wi-Fi (salle dédiée)                     |
| **Firewall**             | Inconnu — probablement intégré à la box Orange uniquement |

### Caméras de Surveillance

| Élément                    | État                                  |
| -------------------------- | ------------------------------------- |
| **Marque / Modèle**        | Hikvision PoE                         |
| **Usage**                  | Dissuasion                            |
| **Stockage images**        | Cartes SD locales (sur les caméras)   |
| **Détection mouvement**    | Activée                               |
| **Rétention**              | 1 semaine                             |
| **Serveur NVR centralisé** | ❌ Inexistant                         |
| **Réseau dédié caméras**   | ❌ Aucun — sur le réseau plat général |

---

## 🔐 Audit Sécurité (Déclaratif)

### Gestion des Identités & Accès

| Risque                    | Gravité     | Détail                                                               |
| ------------------------- | ----------- | -------------------------------------------------------------------- |
| **Compte unique partagé** | 🔴 Critique | `Lyliandu33` utilisé par les **32 employés** sur toutes les machines |
| **Mot de passe**          | 🔴 Critique | Jamais modifié depuis la création du compte                          |
| **Pas d'AD / LDAP**       | 🔴 Critique | Aucune gestion centralisée des identités                             |
| **Pas de 2FA**            | 🔴 Critique | Aucune authentification multi-facteur                                |
| **Pas de politique MDP**  | 🔴 Critique | Aucune règle de rotation ou complexité                               |
| **Audit trail**           | 🔴 Critique | Impossible de tracer qui a accédé à quoi (compte partagé)            |

### Sauvegarde & Continuité

| Risque                     | Gravité     | Détail                                                       |
| -------------------------- | ----------- | ------------------------------------------------------------ |
| **Backup manuel**          | 🔴 Critique | Fréquence : "quand j'ai envie" — aucune automatisation       |
| **Support de sauvegarde**  | 🔴 Critique | Disque externe **sur site** (risque incendie = perte totale) |
| **Pas de backup off-site** | 🔴 Critique | Aucune copie distante                                        |
| **Pas de PRA**             | 🔴 Critique | Aucun plan de reprise d'activité documenté                   |
| **Tests de restauration**  | 🔴 Critique | Jamais réalisés                                              |
| **Protection ransomware**  | 🔴 Critique | Aucun snapshot immuable                                      |

### Réseau & Périmètre

| Risque                    | Gravité     | Détail                                                 |
| ------------------------- | ----------- | ------------------------------------------------------ |
| **Réseau plat**           | 🔴 Critique | Caméras IP sur le même réseau que les données patients |
| **Pas de firewall dédié** | 🟠 Haute    | Box Orange seule — aucun filtrage applicatif           |
| **Wi-Fi non segmenté**    | 🟠 Haute    | Clients et employés probablement sur le même SSID      |
| **Pas de redondance WAN** | 🟠 Haute    | Coupure box = arrêt total                              |

### Conformité Réglementaire

| Exigence                            | État actuel                                   |
| ----------------------------------- | --------------------------------------------- |
| **HDS (Hébergement Données Santé)** | ❌ Non certifié                               |
| **RGPD**                            | ❌ Pas de DPO désigné, pas d'AIPD réalisée    |
| **Souveraineté données**            | ❌ Données stockées sur PC local non sécurisé |
| **Traçabilité accès**               | ❌ Impossible (compte partagé)                |
| **Politique de rétention**          | ❌ Non appliquée                              |

---

## 💻 Logiciel Métier

| Élément                   | État                                         |
| ------------------------- | -------------------------------------------- |
| **Type**                  | Client lourd (application desktop installée) |
| **Éditeur**               | Non communiqué — à identifier                |
| **Performances**          | Lenteur signalée aux heures de pointe        |
| **Compatibilité RDS/VDI** | À qualifier avec l'éditeur                   |
| **Dépendance réseau**     | Forte — dégradation visible si réseau saturé |

---

## 📊 Synthèse des Risques

| #   | Risque                                               | Probabilité | Impact         | Niveau    |
| --- | ---------------------------------------------------- | ----------- | -------------- | --------- |
| R1  | Ransomware (chiffrement données patients)            | Élevée      | Catastrophique | 🔴 **P0** |
| R2  | Perte totale données (incendie + backup sur site)    | Moyenne     | Catastrophique | 🔴 **P0** |
| R3  | Violation RGPD / HDS (compte partagé, pas de traces) | Élevée      | Critique       | 🔴 **P0** |
| R4  | Indisponibilité prolongée (SPOF PC + box unique)     | Élevée      | Majeur         | 🔴 **P1** |
| R5  | Accès illégitime données patients (réseau plat)      | Moyenne     | Majeur         | 🟠 **P1** |
| R6  | Perte caméras (SD locales, rétention 1 semaine)      | Moyenne     | Modéré         | 🟡 **P2** |
| R7  | Wi-Fi insuffisant (clients VIP insatisfaits)         | Élevée      | Modéré         | 🟡 **P2** |

---

## ✅ Actions Issues de l'Entretien 1

| #   | Action                                                             | Responsable | Deadline          |
| --- | ------------------------------------------------------------------ | ----------- | ----------------- |
| 1   | Audit on-site complet (matériel, réseau, logiciels)                | Thibaut D.  | Avant entretien 2 |
| 2   | Identifier éditeur logiciel patient + tester compatibilité RDS/VDI | Thibaut D.  | Avant entretien 2 |
| 3   | Évaluer hébergeurs HDS souverains (OVH, Scaleway, Outscale)        | Lylian C.   | Avant entretien 2 |
| 4   | Rédiger 2–3 propositions commerciales                              | Gregory M.  | Entretien 2       |
| 5   | Dimensionner pour 1 000 utilisateurs potentiels (vs 200 actuels)   | Thibaut D.  | Avant entretien 2 |
| 6   | Checklist RGPD + HDS à préparer pour entretien 2                   | Lylian C.   | Avant entretien 2 |

---

## ❓ Points à Clarifier (Entretien 2)

- [ ] Inventaire complet du matériel réseau (switch, AP — marque, modèle)
- [ ] Version exacte du logiciel patient et nom de l'éditeur
- [ ] Volumétrie réelle données (espace disque occupé)
- [ ] Budget disponible (aucune enveloppe définie à ce stade)
- [ ] Décision sur Doctolib : continuer ou migrer ?
- [ ] Nombre exact de praticiens nomades et besoins d'accès distant
- [ ] Prestataire CNC / maintenance externe : niveau d'accès actuel ?
- [ ] Portail patient et prise de RDV en ligne : horizon prévu ?

---

_Document évolutif — sera complété après audit on-site (Thibaut D.)_
