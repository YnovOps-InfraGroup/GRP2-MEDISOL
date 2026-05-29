# ARCHITECTURE.md - MEDISOL Infrastructure Cible

**Version:** 1.0 (Draft)
**Last Updated:** 29 Mai 2026
**Status:** À Valider avec Client

---

## 1️⃣ Contexte & Contraintes

### Exigences Critiques

- **RTO** : 30-60 minutes maximum
- **RPO** : 1 heure maximum
- **Disponibilité** : 99.9% (zéro panne perçue)
- **Conformité** : HDS, RGPD, Loi santé
- **Données** : Patients (sensible), imageries (volumique)

### Contraintes Actuelles

- Infrastructure vieillissante (Windows Server 4 ans)
- Réseau NON segmenté
- Wi-Fi saturé
- Pas de PRA documenté

---

## 2️⃣ Architecture Cible (Proposée)

```
┌─────────────────────────────────────────────────────────────┐
│                    MEDISOL Infrastructure                    │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐         ┌─────────────────────┐           │
│  │ Firewall HA  │◄────────┤ Internet (Fibre Box)│           │
│  └──────────────┘         └─────────────────────┘           │
│         │                                                    │
│  ┌──────┴──────────────────────────────────┐               │
│  │        Réseau Cœur (Switchs HA)         │               │
│  └──────┬──────────────────────────────────┘               │
│         │                                                    │
│  ┌──────┴────────────────────────────────────────┐         │
│  │  VLAN Segmentation                            │         │
│  ├──────────────────────────────────────────────┤         │
│  │ VLAN 100 (Métier) → Logiciel Patient + RDS  │         │
│  │ VLAN 200 (Invités) → Wi-Fi Patients         │         │
│  │ VLAN 300 (Admin) → Gestion + Accès Sécurisé │         │
│  │ VLAN 400 (Imagerie) → Serveur Stockage      │         │
│  └──────┬───────────────────────────────────────┘         │
│         │                                                   │
│  ┌──────┴──────────────┬──────────────┬──────────────┐    │
│  │                     │              │              │    │
│  ▼                     ▼              ▼              ▼    │
│ ┌─────────────┐   ┌─────────────┐ ┌─────────┐  ┌──────┐  │
│ │ RDS/VDI     │   │  NAS        │ │ Backup  │  │ Wi-Fi│  │
│ │ Logiciel    │   │  Imagerie   │ │ Externe │  │ HA   │  │
│ │ Patient     │   │  4To        │ │ Immuable│  │      │  │
│ │ HA/Scaling  │   │  Snapshots  │ │ Off-Site│  │ Mesh │  │
│ └─────────────┘   └─────────────┘ └─────────┘  └──────┘  │
│                                                             │
│  ┌──────────────────────────────────────────────┐         │
│  │ Monitoring & Alertes (Zabbix/Prometheus)    │         │
│  │ - CPU/Mémoire/Stockage                      │         │
│  │ - Disponibilité RDS/NAS                     │         │
│  │ - Compliance HDS                            │         │
│  └──────────────────────────────────────────────┘         │
│                                                             │
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
