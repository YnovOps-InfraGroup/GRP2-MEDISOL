## **COMPRENDRE LE CLIENT**

## **Pouvez-vous me présenter MEDISOL et votre activité, qui il est lui par rapport à la societé son poste** ? (type de consultations, nombre de patients, spécialités) » comprendre le métier avant de parler technique « **Combien de patients traitez-vous par jour/semaine** en moyenne ? quantifie le volume d\'activité « **Quels sont vos horaires d\'ouverture** ? (lun-ven, sam, heures exactes) » quand l\'activité est critique « **Comment est organisée votre équipe de 32 personnes** ? (combien d\'accueil, combien de praticiens, combien d\'admin) » comprendres utilisateurs « **Le Wi-Fi est saturé** : **quand est-ce que c\'est le plus gênant** ? (salle d\'attente patients, personnel, les deux) » le problème ? « **Le logiciel patient est lent aux heures de pointe** : **quelles sont ces heures de pointe** ? (matin 8h-12h, après-midi 14h-18h) » **Quel est l\'impact de cette lenteur** ? (retards en cascade, patients mécontents, annulations, perte d\'argent) » « **Y a-t-il déjà eu des incidents majeurs** ? (panne complète, perte de données, cyberattaque) Si oui, comment avez-vous réagi ? »  **ENJEUX ET ATTENTE**

##  « **La direction dit « zéro panne ». Qu\'est-ce que ça signifie concrètement pour vous** ? (tolérance 0 min d\'arrêt ? 30 min max ? 1 heure max ?) » RTO concret « **Qu\'est-ce qui est le plus critique pour votre activité** ? (logiciel patient, Wi-Fi, télétransmission mutuelles, accès dossiers patients) » priorise les processus « **Quelles sont vos 3 principales préoccupations** pour ce projet de modernisation ? » « **Qu\'est-ce qui serait un échec pour vous** après ce projet ?\*\* (ce que vous ne voulez surtout pas) » peurs/risques « **Qu\'est-ce qui serait un succès pour vous** après ce projet ?\*\* (ce que vous voulez absolument obtenir) » Comprends les objectifs de succès « **Avez-vous des contraintes spécifiques au secteur santé** que nous devons absolument prendre en compte\*\* ?\*\* (RGPD, confidentialité, loi médicale) » « **Avez-vous déjà estimé un budget pour ce projet de modernisation** ?\*\* 

## « **Y a-t-il un calendrier impératif** ? (date limite pour moderniser, audit prévu, garantie qui expire) » **Quelles sont les fenêtres de maintenance autorisées** ?\*\* Soir (après 18h), nuit, weekend, ou uniquement heures ouvrées ? »  

## Question Thibaut Architect / Ingé Virtu : 

Question : Quelle est l'objectif de la demande ? Renouvellement infra ?
résolution des problème rencontrer ? Réponse aux contraites ? Lift uP ?

Question : Les données traitées sont-elles soumises à la certification
HDS (Hébergement de Données de Santé) ?

Question : Quel est l\'état actuel des équipements réseaux (Firewall,
Switchs, Bornes Wi-Fi) ?

Question : Comment est géré le contrôle d\'accès actuel ? \> Les caméras
et objets connectés sont-ils sur le même réseau que les serveurs métiers
?

Question : Détails techniques sur le logiciel patient (client lourd) ?
\> Quel éditeur ? Quelle est la base de données derrière (SQL Server ?)
qui cause les lenteurs ?

Question : Ce client lourd est-il compatible RDS (Remote Desktop
Services) ou VDI ?

Question : Comment sont gérés les lecteurs de carte Vitale et appareils
de mesure ? \> Si on part sur du bureau à distance (RDS/VDI), la
redirection USB de ces périphériques spécifiques peut être un enfer
technique. Il faut l\'anticiper.

Question : Quelle est la volumétrie actuelle du stockage et sa
croissance annuelle ?

Question : Quelle est la politique de rétention légale des images et
dossiers ?

Question : Que signifie exactement le \"zéro panne\" pour la direction ?
(Définition du RTO / RPO) un redémarrage en 1 heure (PRA) est-il
finalement acceptable ?

Question : Quelle est l\'infrastructure actuelle (Compute/Storage) ? (
si ne sait pas presta audit ? )

Question : Existe-t-il une politique de sauvegarde externalisée et
déconnectée / immuable ?

Question : Qui administre l\'IT au quotidien actuellement ? \> Effectif
de 32 personnes, sûrement pas d\'informaticien dédié. Faut-il prévoir un
contrat de Maintien en Condition Opérationnelle / infogérance ?

Question : Quelle est l\'enveloppe budgétaire pour ce projet ? \> Permet
de calibrer entre une refonte complète (nouveaux serveurs + licences +
switchs) et du \"lift and shift\" vers le cloud.

Question : Délai de réalisation du projet.

gestion de parc qui s'occupe de votre parc informatique (entreprise
externe, salarié ?)

entreprise française ou pas ? situé ou ?\
windows server quel année ?\
quel matériel physique et qu'elle année ?\
\
pas d'AD ? role du server application

Lylian RSSI :\
Stockage des données patient ou sont stocké actuellement ?\
Avons nous une arborescence des droits actuelle ? Et quelle système
d'authentification est mise ne place ? (AD ou local)\
Qulle méthode de chiffrement pour le réseau wifi est mise ne place (WPA
?) De plus y'a til une wifi invité ?\
Pour les personnes hors site comment font elle pour accès au réseau de
l'organisation ? (VPN ?) Si VPN qu\'elle équipement utiliser ?

## **Qui gère l\'IT actuellement ? (responsable interne, prestataire externe, personne dédiée) » « Avez-vous déjà des sauvegardes ? (si oui, fréquence, où, qui gère) » « Avez-vous déjà fait un exercice de reprise après un incident ? (si oui, quoi, si non, pourquoi) » « Avez-vous un document écrit de Plan de Reprise d\'Activité (PRA) ?\*\* (si non, c\'est un risque majeur) » « Avez-vous un DPO (Délégué à la Protection des Données) ou quelqu\'un de chargé de la conformité RGPD ?\*\* » Question Greg : Auditeur PRA / PCA**

-   « Quel RTO réaliste pour une clinique (30min/1h/2h max) ? »

-   « Combien de patients par jour ? CA perdu par heure d\'arrêt ? »

-   « Les praticiens nomades (1j/semaine) ont-ils besoin d\'accès remote
    > aux dossiers ? »

-   « À quelle fréquence faire des exercices de reprise (1x/an, 2x/an) ?

-   « En cas d\'indisponibilité logiciel patient, comment gérez-vous les
    > consultations (papier/crayon, report) ? »

**question éventuel pour lylian (RSSI) =**\
« Les dossiers patients sont-ils chiffrés au repos et en transit ? »

-   « Avez-vous un DPO ou quelqu\'un de designated pour RGPD santé ? »

-   « Y a-t-il une Analyse d\'Impact RGPD (AIPD) faite pour le logiciel
    > patient ? »

-   « Les caméras/control d\'accès stockent-elles des données sensibles
    > (faces) ? »

**question éventuel pour Thibaut (Archi)**

« Combien d\'appareils connectés simultanément sur le Wi-Fi (patients +
personnel) ? »

« Les équipements de mesure connectés en cabinet utilisent quel
protocole (Wi-Fi/Ethernet) ? »

## **Liste de contrôle rapide**

-   **Activité MEDISOL** (type de consultations, patients/jour,
    > horaires)

-   **Équipe** (accueil/praticiens/admin, répartition)

-   **Problèmes actuels** (Wi-Fi saturé, logiciel lent, réseau mélangé)

-   **Enjeux principaux** (confidentialité patients, « zéro panne »,
    > créneaux serrés)

-   **RTO réel** (30min/1h/2h max acceptable)

-   **RPO réel** (perte données patients max : 1h/1j/1sem)

-   **PRA existant** (oui/non, exercice déjà fait oui/non)
