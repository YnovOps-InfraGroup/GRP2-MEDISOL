*« Bonjour, je suis **Greg**, chef de projet et auditeur PRA chez
RunMyInfra. Voici **Lylian**, notre RSSI, et **Thibaut**, notre
architecte infra. Notre objectif aujourd\'hui : vous comprendre avant
tout pour vous proposer ensuite une solution adaptée.*

**2**

**PHASE 1 --- Contexte & Enjeux Business**

**Phase 1 : Gregory M. (Auditeur et Chef de projet PRA/PCA)**\
\
**I. Contexte et Business**

1.  Pouvez-vous nous présenter MEDISOL, votre activité votre CA (type de
    > consultations, spécialités), et votre rôle au sein de
    > l\'organisation ?

2.  Quel est le **volume d\'activité moyen** (**nombre de patients**
    > traités par jour/semaine) ?

3.  Quels sont les horaires d\'ouverture et d\'activité critique ?

4.  Comment est organisée votre équipe de 32 personnes (répartition
    > entre accueil, praticiens, et administration) ?

5.  Qui administre l\'IT au quotidien (interne, prestataire externe
    > dédié) ?

**II. Problèmes, Objectifs et Contraintes**

1.  Quel est l\'impact de la lenteur du logiciel patient aux heures de
    > pointe (retards en cascade, annulations, perte d\'argent) ?

2.  En cas d\'indisponibilité du logiciel patient, comment gérez-vous
    > les consultations (méthode manuelle, report de rendez-vous) ?

3.  Qu\'est-ce qui est le plus critique pour votre activité(logiciel
    > patient, Wi-Fi, télétransmission mutuelles, accès dossiers) ? Si
    > oui l'impact financier ?

4.  Avez-vous déjà estimé une enveloppe budgétaire et un calendrier
    > impératif pour ce projet ?

5.  Définir précisément l\'objectif

-   est-il un renouvellement complet de l\'infrastructure, ?

-   une migration vers le cloud (Lift up) ?

-   une simple mise à niveau ?

-   Quelles sont vos 3 principales préoccupations concernant ce projet ?

-   **Qu\'est-ce qui serait un succès et, à l\'inverse, un échec après
    > ce projet ?**

**pas de panne fonctionnel manière fluide netflix 4K\
full cloud. possiblement.**

**III. Disponibilité et Reprise d\'Activité (PRA/PCA)**

1.  Que signifie concrètement l\'exigence de la direction d\'avoir «
    > zéro panne » ? « **La direction dit « zéro panne ». Qu\'est-ce que
    > ça signifie concrètement pour vous** ? (tolérance 0 min d\'arrêt ?
    > 30 min max ? 1 heure max ?) » RTO concret\
    > Quelle est la tolérance maximale d\'arrêt (RTO) et la perte de
    > données acceptable (RPO) ?

2.  Y a-t-il déjà eu des incidents majeurs (panne complète, perte de
    > données, cyberattaque) ? Si oui, comment avez-vous réagi ?
    > (forensic) pas de cyber-attaque

3.  Avez-vous un document écrit de Plan de Reprise d\'Activité (PRA) et
    > avez-vous déjà fait des exercices de reprise après incident ?

4.  À quelle fréquence jugeriez-vous pertinent de faire des exercices de
    > reprise (1x/an, 2x/an) ?

5.  Les praticiens nomades (consultant 1 jour/semaine) ont-ils besoin
    > d\'un accès distant aux dossiers patients ? (pas de carte vitale)

## **PHASE 2 --- Sécurité & Conformité**

\-\-\-\--**Phase 2 : Lylian (RSSI - Responsable Sécurité des Systèmes
d\'Information)**

L\'objectif est d\'évaluer la posture de sécurité, la conformité
réglementaire (RGPD/HDS) et l\'accès aux données.

1.  Pour l\'hébergement de vos données patients, avez-vous une exigence
    > de **souveraineté française** ? *(hébergeur certifié HDS sur sol
    > français uniquement, ou cloud étranger acceptable*

2.  Avez-vous un DPO (Délégué à la Protection des Données) ou une
    > personne chargée de la conformité RGPD/santé ?

3.  Les dossiers patients sont-ils chiffrés au repos et en transit ? non
    > chiffré

4.  Où sont stockées les données patient actuellement ? sauvegarde
    > disque externe.

5.  Quelle est la politique de rétention légale des images et dossiers
    > patients ? pas de politique de retention.

6.  Quel système d'authentification est en place (Active Directory ou
    > local) et existe-t-il une arborescence des droits d'accès actuelle
    > ? mot de passe partout même mot de passe meme compte.

7.  Pour le Wi-Fi : quelle méthode de chiffrement est utilisée (WPA ?),
    > et y a-t-il un réseau Wi-Fi invité séparé du réseau métier ?

8.  Comment les personnes hors site accèdent-elles au réseau de
    > l'organisation (VPN ?) et quels équipements sont utilisés pour
    > cela ?

9.  Les caméras et le contrôle d\'accès stockent-ils des données
    > sensibles (visages, horaires) ?

10. Avez-vous réalisé une Analyse d\'Impact relative à la Protection des
    > Données (AIPD) pour le logiciel patient ?

## **PHASE 3 --- Infrastructure & Architecture**

\-\-\-\--**Phase 3 : Thibaut (Architecte, Ingénieur Infra et
Virtualisation)**

L\'objectif est de sonder l\'infrastructure technique existante, les
problèmes de performance et les détails de l\'environnement pour la
solution.

1.  Quel est l\'état actuel des équipements réseaux (Firewall, Switchs,
    > Bornes Wi-Fi) ?

2.  Le contrôle d\'accès et les caméras/objets connectés sont-ils sur le
    > même réseau que les serveurs métiers ? (Confirme la ségrégation
    > des réseaux) **RZO plat**

3.  Combien d\'appareils (patients et personnel) sont connectés
    > simultanément sur le Wi-Fi aux heures de pointe ?

4.  Quels sont les détails techniques sur le logiciel patient (client
    > lourd) : quel éditeur, et quelle est la base de données (SQL
    > Server, etc.) derrière qui pourrait causer les lenteurs ?

5.  Ce client lourd est-il compatible avec des solutions de bureau à
    > distance (RDS/VDI) ?

6.  Comment sont gérés les périphériques spécifiques, comme les lecteurs
    > de carte Vitale et les appareils de mesure, notamment en cas de
    > déploiement de bureau à distance (redirection USB) ?

7.  Quelle est l\'infrastructure actuelle (Compute, Storage : serveurs,
    > type et âge) ?

8.  Quelle est la volumétrie actuelle du stockage et sa croissance
    > annuelle estimée ?

9.  Avez-vous une politique de sauvegarde externalisée, déconnectée ou
    > immuable, pour se prémunir des cyberattaques de type rançongiciel
    > ?

10. Quelles sont les fenêtres de maintenance autorisées (soir après 18h,
    > nuit, weekend, ou uniquement heures ouvrées) ?

**Checklist rapide avant de partir :**

-   RTO + RPO confirmés

-   PRA existant ou non

-   Conformité HDS / DPO / AIPD

-   Segmentation réseau actuelle

-   Compatibilité logiciel patient avec RDS/VDI

-   Type de sauvegarde (immuable / externalisée)

-   Vision projet (on-prem / cloud / hybride)

-   Budget + calendrier

pc 2 to
