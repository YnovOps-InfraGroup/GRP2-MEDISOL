# MEDISOL - REUNION 1

---

# 🧩**Réunion MEDISOL (avec enregistrement vocal)**

---

📅 *Date : 26/05/2026*

# 🟦 **Réunion MEDISOL — 1er RDV Client**

👥 *Participants RMI :* Gregory (PRA/PCA), Lylian (RSSI), Thibaut (Architecte)

👥 *Participants MEDISOL : Forian*

---

## 🟨 **1. CONTEXTE DE LA RÉUNION**

Rendez-vous avec un nouveau client “MEDISOL”.

**Pitch d’introduction :**

« Bonjour, je suis Greg, chef de projet et auditeur PRA chez RunMyInfra. Voici Lylian, notre RSSI, et Thibaut, notre architecte infra. Notre objectif aujourd'hui : vous comprendre avant tout pour vous proposer ensuite une solution adaptée. On va aller à l'essentiel. »

**Objectifs du RDV :**

- Comprendre le contexte business
- Identifier les problèmes, impacts et priorités
- Évaluer les enjeux PRA/PCA
- Vérifier la posture sécurité / conformité
- Cartographier l’infrastructure existante
- Préparer une recommandation (on-prem / cloud / hybride)

---

## 🟩 **2. INSTRUCTIONS**

> **Notion AI :**
> 
> 
> Après la transcription, génère un résumé structuré en 6 sections :
> 
> 1. Contexte & activité MEDISOL
> 2. Problèmes, impacts et objectifs
> 3. Exigences PRA/PCA (RTO/RPO)
> 4. Sécurité & conformité (RGPD/HDS)
> 5. Infrastructure & architecture actuelle
> 6. Actions, décisions, risques, budget & calendrier
> 
> Mets en évidence :
> 
> - les points critiques
> - les dépendances
> - les risques majeurs
> - les décisions explicites
> - les éléments manquants à clarifier

---

# 🎙️ **3. ENREGISTREMENT & TRANSCRIPTION**

Résumé

### Action Items

- [ ]  RMI à proposer 2-3 offres avec différents niveaux de service et budgets : migration complète vers le cloud, amélioration de l'infrastructure existante, et une option intermédiaire
- [ ]  RMI à réaliser un audit complet sur site pour inventorier précisément l'infrastructure actuelle (matériel, réseau, caméras, etc.)
- [ ]  Équipe RMI à visiter les locaux pendant la réunion pour évaluer l'infrastructure en place

### Contexte de la Réunion

- Réunion de découverte entre Run My Infra (Greg - chef de projet/auditeur PRA, Lilian - SSI, Thibaut - architecte infra) et la gérante de Médisol
- Objectif : comprendre les besoins de Médisol avant de proposer une solution adaptée

### Présentation de Médisol

- Clinique de médecine chinoise (médecine douce non conventionnée) avec clientèle "high-ticket"
- Croissance forte : chiffre d'affaires multiplié par 3 en 4 ans
- Volume d'activité : environ 200 patients par mois
- Équipe de 32 personnes : praticiens, accueil, administration (compta, RH)
- Certains praticiens en mode nomade (consultations à domicile chez clients high-ticket)
- Locaux de 1000m²
- Horaires d'ouverture : 8h-19h

### Infrastructure Actuelle

**Matériel et stockage :**

- Serveur Windows (4 ans) dans la salle d'imagerie pour stockage des données et imageries
- En réalité, il s'agit d'un simple ordinateur avec 2 To de stockage
- Stockage insuffisant et lent
- Réseau local unique (non segmenté)
- Box Orange fibrée pro - toute la connectivité passe par là
- Pas de ligne secondaire/redondance

**Système de surveillance :**

- Caméras Hikvision en PoE pour dissuasion
- Stockage local sur cartes SD avec détection de mouvement
- Rétention d'une semaine
- Pas de serveur de surveillance centralisé

**WiFi :**

- Plusieurs bornes WiFi déployées dans les locaux mais couverture inégale
- Salle dédiée pour clients high-ticket avec bonne couverture

**Logiciel métier :**

- Client lourd développé par un éditeur
- Problèmes de lenteur impactant l'expérience client

### Problèmes et Contraintes Identifiés

**Sécurité et gestion des accès :**

- Compte unique partagé "Lyliandu33" utilisé par tous les employés sur toutes les machines
- Mot de passe jamais changé depuis le début
- Chiffrement Windows du disque (mentionné comme ayant une "méga faille")
- Pas de politique de gestion des mots de passe

**Sauvegarde et continuité :**

- Sauvegarde manuelle sur disque dur externe, fréquence irrégulière ("quand j'ai envie")
- Disque de sauvegarde reste sur site
- Pas de sauvegarde externalisée
- Aucun plan de reprise d'activité (PRA) documenté
- Pas de plan en cas d'indisponibilité logicielle

**Risques identifiés :**

- Préoccupation concernant les cyberattaques (ransomware) observées chez des confrères
- Risque d'incendie/perte totale des données évoqué
- Infrastructure fragile et non professionnelle décrite comme "un gruyère"

**Ancien prestataire :**

- Prestataire externe précédent a fait faillite suite à un incident chez un autre client (Metalis - 48h d'arrêt)
- Contact impossible avec l'ancien prestataire
- Infrastructure actuelle considérée comme bricolée

### Exigences et Besoins

**Disponibilité :**

- Exigence de zéro panne pendant les heures d'ouverture (8h-19h)
- Maintenance possible en dehors de ces horaires et le week-end
- Impact actuel : agacement des clients et dégradation de l'expérience, mais pas de perte financière directe

**Données de santé :**

- Nécessité de respecter la réglementation sur les données de santé
- Souhait de rester conforme (souveraineté française, certification HDS mentionnée)
- Données actuellement uniquement en local sur le serveur Windows

**Mobilité :**

- Praticiens nomades enregistrent des vocaux qu'ils transmettent à la secrétaire pour retranscription
- Souhait que les praticiens nomades puissent accéder facilement aux informations partagées
- Pas d'utilisation de carte vitale (clientèle high-ticket, peu de remboursements)

**Services clients :**

- WiFi pour clients avec capacité 4K souhaitée
- Utilisation de Doctolib pour prise de rendez-vous (mais envisagent d'arrêter)

**Budget et approche :**

- Pas d'enveloppe budgétaire définie
- Souhait de 2-3 propositions avec différents niveaux de services et budgets
- Ouverture totale à une migration cloud
- Recherche d'un "prestataire à étiquette premium"
- CA estimé à 3 milliards d'euros mentionné en fin de réunion (vraisemblablement une blague/erreur)

### Projets Futurs (Non Prioritaires)

- Portail patient : projet envisagé mais pas pour l'instant
- Prise de rendez-vous en ligne : mentionné comme projet futur
- IA locale pour automatisation de la retranscription des vocaux : évoqué par RMI mais nécessiterait un autre prestataire (RSA)

### Critères de Succès

- Pas de panne pendant les heures d'ouverture
- Fonctionnement fluide de tous les systèmes
- WiFi de qualité pour les clients (streaming 4K)
- Accès facile aux informations partagées pour les praticiens nomades
- Données sécurisées et souveraines

### Prochaines Étapes

- RMI va réaliser un audit sur site pour inventorier précisément l'infrastructure
- Proposition de 2-3 offres avec différents niveaux : migration cloud complète, amélioration de l'existant, et solution intermédiaire
- Anticipation d'une volumétrie de 1000 utilisateurs potentiels pour dimensionnement futur (vs 200 actuels)

Notes

Transcription

Bonjour, je suis Greg, chef de projet, auditeur PRA chez Run My Infra. Voici Lilian, notre SSI, et Thibaut, notre architecte infra. Enchanté, merci. Aujourd'hui, on est là pour vous comprendre avant tout et proposer ensuite une solution adaptée à votre besoin. J'aurais quelques questions à vous poser pour ça. Premièrement, quel est votre rôle au sein de l'organisation Médisol ? Si vous pouvez nous présenter en quelques mots, vous êtes quel poste ?

Je suis le gérant de la structure. Je suis le décisionnaire. Décisionnaire total, très bien. Est-ce qu'on pourrait savoir à peu près qui est... Je ne connais rien. En informatique ? Ah ouais. D'accord. C'est juste... On va commencer par parler un peu de votre activité. En quelques mots, est-ce que vous pouvez nous dire quel est votre chiffre d'affaires ?

Vous êtes un petit peu curieux. C'est parfois sur ce qui se situe pour aussi adapter. En 4 ans, on a multiplié notre chiffre d'affaires par 3. Ça marche plutôt bien. On commence à avoir des personnes renommées qui viennent chez nous. On veut protéger nos données. En sorte que tout se passe bien, les chouchouter et comme ça parce qu'on a des gros tickets d'entrée donc voilà. On veut continuer à surfer sur la belle bague.

Votre volume moyen d'activité c'est le nombre de patients traités par jour ou par mois à peu près, il est de combien ? Parce que c'est pas indiqué, on a pas... 30. 30 patients par jour ?

Non, par mois.

Par mois ?

High ticket ? Ok, très bien. Non, attends, je te dis des bêtises parce que 32 personnes, après, c'est du chouchoutage de ouf. On va dire 200 personnes.

D'accord. Par mois ? Par mois. D'accord.

Et du coup aussi, quels sont les horaires de l'ouverture ? En plus, tu me poses des questions auxquelles je ne me suis moi-même pas posé la question.

Alors pourquoi on vous parle du solide moyen ? Parce que pour voir aussi qu'est-ce qui est brassé par mois, la volumétrie. Là je vous demande aussi quels sont les horaires d'ouverture, c'est pour savoir aussi est-ce qu'il y a des temps d'activité critique. Ça c'est bon, ça j'étais prêt à ça.

C'est le nombre de patients. Non, non.

Parce que volumétrie, on m'a directement posé la question de la volumétrie. Ok, c'était pour en agréger à là. On commence dans les questions que vous avez posées.

C'est une belle approche parce que tu parles le langage. Je me serais adapté.

Si c'était une musique que vous connaissiez, peut-être que j'aurais changé et j'aurais dit plus volbétrie. Combien de gigaoctets par patient ? C'est plus, du coup, vous êtes une équipe de 32 personnes sans la noter. On peut savoir à peu près la répartition de ces 32 personnes, mais plus ou moins, est-ce que vous avez une équipe IT au sein de ces 32 personnes, ou alors c'est plutôt des prestataires externes, ou alors rien du tout pour l'instant ?

On avait un prestataire externe.

D'accord, ok. Et ces 32 personnes, c'est plus du coup accueil, compta ?

Accueil praticien, ouais. Accueil praticien, c'est tout ? Oui, il y a un service compta aussi dans la partie administrative.

Ok, c'est d'accord. OK, et donc service RH aussi, du coup, dans les 32 personnes. OK, c'est bon. Donc, on va poser quelques questions pour cibler un peu plus l'objectif et les contraintes et la problématique actuelle. Donc, aujourd'hui, on a vu, vous avez dit que c'était par rapport à l'impact de la lenteur du logiciel. Par rapport aux patients, aux heures de pointe, il y a beaucoup de retard, des annulations.

Est-ce que vous avez une perte d'argent à ce niveau-là ou pas du tout ? Une perte financière, il y a un impact financier ?

Non, c'est plus de l'agacement et du coup, l'expérience avec le client. C'est pas très agréable, on attend, ça va pas vite.

Comment vous faites quand ça vous arrive d'avoir une indisponibilité au niveau d'un logiciel ? Comment vous gérez les consultations ? Vous passez en mode manuel ou vous avez un truc de secours ? Ok, donc il n'y a rien de prévu, il n'y a pas de... Non, pas pour l'instant. Ok, pas de disquabilité. On aimerait, on aimerait. Très bien. On veut une offre premium. On a compris que...

Qu'est-ce qui est le plus important et le plus critique ? La moula, la moula, la moula.

Nous aussi on en veut. On va aller vers le même objectif alors. Très bien. - Du coup, qu'est-ce que vous considérez le plus critique actuellement pour votre activité ? Est-ce que c'est plutôt la partie Wi-Fi ou la partie de lenteur logicielle ?

- Wi-Fi, c'est bien, c'est un plus, c'est un service qu'on apporte. Mais c'est vrai que tout ce qui est logiciel, stockage des données, même si on n'est qu'une clinique bien-être, il y a quand même des données de santé. Donc voilà, on fait attention à ça. Là, pour l'instant, c'est sur un... Un serveur Windows à côté de la salle d'imagerie qu'on utilise occasionnellement quand il y a besoin. Ce n'est pas notre cœur d'activité, c'est juste un service supplémentaire qui nous permet de savoir un peu plus si ça n'a pas été fait.

On peut comme ça permettre de faire des radios rapidement sans faire aller notre patient, notre client. Moi je dis patient, mais client.

C'est bien-être, médecine douce, ça ne s'amène pas, c'est pas une chose que la médecine. D'accord, du coup, on va revenir un peu sur ce budget Lamoula, est-ce que vous avez estimé une enveloppe budgétaire pour le projet ? On va cadrer un peu le projet là. Je vais vous poser quelques questions. Mais est-ce que vous avez déjà une idée d'englobe budgétaire à louer ?

Pas du tout. Ce que j'aimerais que vous me fassiez, c'est 2 à 3 propositions avec différents budgets. ...services associés. Et comme ça, on verra vers quoi on part selon ce que ça amène derrière.

Plus ou moins, on peut partir sur un renouvellement complet de l'infrastructure. Pour une migration vers le cloud ?

On est prêt à ça. Vous pouvez proposer du très haut. Ou alors une simple mise au niveau de ce que vous avez déjà. Et après descendre un petit peu sans descendre trop bas parce que du coup, ça serait déjà ce qu'on a.

Du coup, vous disiez que vous avez un serveur Windows, mais en termes d'infrastructure, vous avez d'autres choses ?

Pas grand-chose. Il y a des caméras de surveillance qu'on a installées. un peu pour faire peur mais rien de...

- Et ces caméras, les plus vieux, ils les stockent ? - Ouais, ils sont stockés.

- C'est en direct ? - Ouais, sur des cartes SD, stockées.

Mais par contre, c'est des super caméras en PoE et tout ça...

- C'est du Hachika Vision ?

- Oui, oui, voilà. Made in China. - Vous savez combien de temps les vidéos restent ? C'est un jour, deux jours ou alors si c'est juste du continu ? Pour voir s'il n'y a pas quelqu'un qui vole une chaise ou du matériel ? - Une semaine.

Après, il y a tellement de mouvements que ça enregistre quasiment tout le temps. La détection de mouvement, si il n'y a pas de mouvement, ça n'enregistre pas.

Du coup, j'imagine que vous avez aussi un serveur qui permet de stocker une semaine de rétention ? Pas du tout ? Non, non, sur la carte SD. C'est vraiment carte SD ? Que la carte SD ? Très bien.

On va vous faire sur une migration complète de l'infrastructure, soit une migration vers le cloud ou alors une amélioration. Vous voulez les trois et qu'on budgétise ces trois parties-là ? D'accord. Qu'est-ce que... Alors du coup, je vais venir à peu près aussi à d'autres questions. Vous avez dit que la direction, donc vous, je suppose, vous avez une exigence d'avoir zéro panne. Qu'est-ce que ça signifie concrètement pour vous, zéro panne ?

Est-ce que vous avez quand même une tolérance des 30 minutes, d'une heure ? concrètement on est ouvert de 0 minutes de panne de 8h à 19h on veut 0 panne sur cette plage horaire c'est important de noter sur cette plage horaire il peut y avoir des pannes hors plage horaire vous considérez pas ça comme si vous avez des mises à jour à faire ça doit redémarrer des trucs en dehors de ces heures là week-end et

Est-ce que vous avez déjà eu des incidents liés justement à des pannes complètes ou des pertes de données ou une cyberattaque ? Et si oui, du coup, qu'est-ce qui s'est passé ?

Alors justement, on n'a pas eu de cyberattaque, mais on anticipe un petit peu puisqu'on a déjà vu du coup des confrères subir ce genre de choses.

Et voilà, fil de données, ransomware, tout ça... Vous êtes au fait un peu de ce qui peut se passer et des coups que ça peut avoir... On regarde les infos. Et des coups que ça peut avoir...

Voilà, l'impact sur un business florissant.

Et à ce propos, du coup, vous avez dit que vous avez fait... Est-ce que vous n'avez pas de plan de reprise d'activité de PRA ? Quoi ? Ça ne vous parle pas. Donc, vous n'avez pas de document, si suite à un incident que vous auriez pu avoir, qui...

Voilà, ça, c'est certainement l'autre prestataire qui avait ça. Il nous avait montré un truc... Il vous aurait laissé. Donc, OK, pas de PRA. et donc du coup... C'était un petit prestataire, nous maintenant on cherche un prestataire à étiquette, premium, voilà.

Eh bien vous êtes bien chez RMI. Je vais laisser la place à Lilian pour ses questions.

RMI, c'est pas terrible comme nom quand même. Pourquoi pas RSA ?

Parce qu'on n'est plus old school.

D'accord.

Pour avoir le droit de vous abriter sans ce projet-là en amont, on vous expliquera... Alors comme vous avez dit, vous utilisez des données quand même sensibles, des patients, tout ça. Est-ce que vous vous êtes dit que c'est quand même une souveraineté française ? En termes même de certifiés HDS par exemple ?

Comme je le disais, on a des données de santé et on veut rester dans les clous là-dedans.

Oui, mais c'est un peu la question. C'est plus à ce que vos données actuellement sont hébergées. Sur le Windows Server, dans la salle d'imagerie.

Que sur le serveur. Pour l'instant, c'est que là-dedans.

Alors vous avez aussi des...

Des praticiens nomades qui font des enregistrements vocaux et après qui donnent ça à la secrétaire qui est en local.

Old school.

Mais tu n'imagines pas le nombre de médecins qui font ça, qui font des enregistrements vocaux et c'est une secrétaire qui va ressaisir tout.

Quand même pour la prise de la carte vitale, ça se passe comment dans ces cas-là ? C'est pareil, c'est directement via sur le portable ?

- Putain, toi t'es pas con, toi t'es pas la moitié d'un con. - Et encore vous avez pas fini la question. - Ouais ouais ouais ouais ouais ouais. - C'est que le début. - Pour ça toi avec le côté nomade depuis ce matin, je dis "ah les nomades, non ils font ça comme ça" et là "ah ouais mais comment il fait pour la carte Mita, les nomades ?" - Parce que généralement, quand on fait une...

à distance, il peut y avoir des consultations à distance, on passe par... Je vais citer Doctolib, que ce soit un psychologue ou un médecin, il y a une empreinte de la capitale.

Oui, c'est vrai, c'est vrai, c'est vrai.

On travaille avec Doctolib, mais on va arrêter. Donc, vous passez par le cloud, alors.

Non, juste pour ça, toi.

Pour les rendez-vous, ça facilite un peu le traitement. Et aussi pour le paiement, aussi. Ah, putain.

Est-ce que c'est bien, par exemple, la VPN qui emmène justement vers votre infrastructure ? C'est un lecteur de cartes qui est branché, qui permet d'accéder à votre logiciel métier ? Vous aviez un logiciel métier qui était plutôt lourd.

Oui, un client lourd, oui.

C'est du maison ?

Oui, ça a été développé par un éditeur. Je suis en train de penser sur les praticiens nomades. Nos clients n'utilisent pas la carte vitale. C'est des high-ticket clients. Et donc, ils s'en foutent de la carte vitale. Ils payent ce qu'il faut. Il y en a très peu qui est remboursé. Et donc, du coup, quand on les envoie, c'est déjà payé à l'avance.

Ça simplifie un peu tous les problèmes.

On est sur quel type de médecine douce ? C'est pas de l'ostéopathie ?

Non, c'est de la médecine chinoise. C'est de la médecine douce qui n'est pas conventionnée ?

Non, non, du tout. Bon, alors pas de sécurité sociale, on oublie cette partie.

Pas sur la version nomade, en local il y a des trucs, ça passe, mais vu qu'on ne se pose pas la question, ils n'avaient pas besoin de ça.

- Parce que quand même, il faut limiter les transmissions à la mutuelle, généralement, et puis même la médecine douce sont parfois aussi...

- Oui, non mais il y a des trucs qui sont pris en mutuelle, d'ailleurs, en médecine douce.

- Tout à fait, en médecine douce.

- Mais euh... - La biologie, ce genre de choses là...

- Pour chercher le truc pour ma fille, il est vachement bas, en fait. - Du coup, aussi, alors du coup, au niveau des stock... Enfin, je te cache des données, est-ce que ces données-là sont chiffrées sur le serveur à l'heure actuelle ou c'est en clair actuellement ?

Vous ne savez pas du tout ? Je crois que c'est un chiffrement Windows du disque. C'est le truc où il y a une méga faille et c'est recalculé.

Et au même moment, c'est donné là, est-ce qu'il y a une sauvegarde qui est mis en place actuellement ou pas du tout ?

Oui, c'est un disque dur externe.

Et à quelle fréquence ?

Vous savez ou pas ? Quand j'ai envie. - Ça peut être une fois dans la semaine... - Non, non... - Très bien. - Non, j'exagère un petit peu. Moi, c'est comme à d'autres, là. J'aurais dit des trucs, à un moment, c'était pas cohérent... Mais parce que... - On s'est mis à fond dans le jeu drôle. - Ouais, mais très bien, très bien. C'est surtout que du coup, le sujet, ce que vous avez, c'est une coquille.

Et après, je la remplis par les éléments de réponse que vous me posez des questions. Ce qui fait qu'il y a des fois... et après un temps je vous ai dit que le maïs est une bonne internet sauf que aucun sens le rpv en local c'est pas le cas de nous le plus gros problème c'est celle ci

pas de politique de rétention.

En termes du RSSD, vous le prenez avec vous quand vous partez du bureau ou alors il reste sur site ?

Oui, il reste sur site.

Il n'y a pas de sauvegarde externalisée ?

Non, pas pour l'instant, mais j'aimerais bien que ce soit... J'ai déjà vu qu'il y avait eu un incendie une fois dans une clinique, ils ont tout perdu avec toutes les données... Un camarade qui m'a raconté ça, je ne l'ai pas ça.

Au niveau du système d'authentification, quand vous lancez votre ordinateur et tout, est-ce qu'il y a un compte avec une personne qui fait ça ? Oui, l'ancien prestataire avait fait ça. D'accord. Et au niveau des mots de passe, c'est comment généralement ?

C'est toujours l'Illion du 33, c'est le même mot de passe partout sur toute la machine. Ah oui, ça ne change jamais, c'est toujours ça depuis le début ?

- C'est tous le même compte ?

- Oui, tous, Lyon du 33. - Même pour les nomades ? - Oui, ils sont nomades, ils ont rien à part leur téléphone pour enregistrer le local.

- Ils n'ont pas d'ordinateur ?

- Non, ils sont high ticket, ils viennent, ils viennent saper, ils viennent même avec un Uber Tesla, Ils viennent directement chez le high ticket et puis ils font leur prestat et puis après ils reviennent.

C'est occasionnel. La méthode de chiffrement, il ne va pas savoir.

Est-ce qu'il y aurait moyen de rentrer en contact avec ce prestataire pour échanger ce qu'il a fait et dans quel cadre il interagissait ?

Quel prestataire ? L'ancien prestataire ? Non, ça c'est mal fini. ... Ils ont fait une intervention dans une boîte qui s'appelle Metalis et ça s'est mal goupillé et ça a fait couler leur boîte.

48 heures de stop.

Il y avait des petites clauses et ils ont dû payer plus que ce qu'ils faisaient en un mois. C'est vite.

On peut lui laisser la place. On va plus sur l'infrastructurelle. Est-ce que les questions type Wifi, méthode, WPA, on va s'en occuper ?

Ce qu'on peut vous proposer aussi, c'est que vous nous avez indiqué qu'au niveau de l'informatique, ce n'était pas non plus votre plus gros point fort. Est-ce que ce serait possible, sinon, on peut vous proposer une prestation d'audit qui nous permet d'étudier ce que vous avez actuellement chez vous. On vient chez vous l'histoire d'une demi-journée pour prendre en note, voir ce que vous avez, pouvoir bien savoir exactement tout ce que vous avez comme matériel, comme réseau, comme caméra, etc.

pour pouvoir après vous proposer les meilleures solutions à ce niveau-là.

Oui, ben, regardez, vous êtes venus dans les locaux, pendant que je parle avec vos deux camarades, profitez-en, baladez-vous, regardez, il y a les caméras de surveillance là-bas.

Voilà, tu veux chercher, tu veux trouver, regarde.

Voilà, n'hésitez pas, faites un tour, allez regarder ça, le serveur il est là-bas. On va passer aux questions en vrai. En vrai, tu as raison. Tu dis ça, tu reprogrammes un truc exprès pour faire le bilan de tout. Parce qu'à tout moment, le client fait « Ah mais oui, il y avait ça, j'avais oublié de vous en parler. » C'est ce qui va se passer au deuxième entretien. C'est « Ah oui, au fait, il y a des trucs là, des fois c'est mineur, des fois c'est majeur.

Tout à l'heure, il y en a un qui m'a posé une question et ça tombait pile poil sur un des éléments qui allait changer. » ok pour les deux éléments de réponse à l'issue de la cv et votre c'est combien de temps vous avez votre cerveau ça fait quatre ans quatre ans il est plutôt récent oui je pense qu'il est un truc c'était un vous savez quel constructeur et là on n'a pas à s'en plaindre hormis que ça tient pas sur

Un seul ordinateur pour stocker toutes les imageries et toutes les données.

Et c'est un serveur qui est raqué horizontalement ?

Ah non, non, c'est un ordinateur.

Un ordinateur, ah. Vous savez à peu près au niveau de l'espoir de stockage, combien il y a là, combien il lui reste ? Je crois qu'il y a 2 Tera. 2 Tera. Qui vont vite ou qui vont lentement ?

Qui vont lentement.

Et votre version de Windows elle ressemble à quoi ?

Alors jamais regardé, c'est pas moi qui utilise l'ordinateur. D'accord.

Du coup c'est la secrétaire qui met les fichiers dedans directement ? Depuis son ordinateur ou sur l'ordinateur ?

Depuis son ordinateur, oui.

D'accord.

Là on a quand même un réseau local.

Un réseau local ? C'est un seul réseau local ou il est séparé en plusieurs parties ?

C'est un seul réseau local, je pense.

Ça va être dur. Prise de rendez-vous en ligne, partage de passion.

Comme je disais au groupe, tout à faire potentiellement. Ce n'est pas un gruyère, c'est un trou rempli de fromage. Il y a vraiment beaucoup de choses à faire. c'est plein de brides et puis alors plus vous m'en demandez plus j'en rebalance un peu à droite à gauche et que vous vous retrouvez avec un truc tu te dis waouh mais le prestataire tu m'étonnes qu'il a liquidé bah oui comment ça se passe du tout ?

alors c'est soit un prestataire bancal qui a liquidé soit c'était un mec en interne qui a fait ça genre autodidacte il a bricolé des trucs ça marche et puis ça a vécu son temps et que là il y a un moment le gars il est parti mais par contre On doit consolider tout ça avant que ça nous claque dans les doigts. Jusque là, je ne vous ai pas fait un seul sujet. Ce serait intéressant peut-être l'année prochaine de caler un sujet d'une boîte ou ransomware.

On s'est fait attaquer. Moment de crise, j'ai failli basculer en arrière. Ça fait bizarre. Mais toi, moment de crise, là, ce n'est pas le cas. C'est que des boîtes qui fonctionnent, c'est stable, mais... Ça marche hot et puis en fait il y a une montée en puissance de l'activité et qu'il faut consolider ça avant que ça soit le chaos. Donc ça va, c'est gentil. Mais il y a beaucoup de choses à faire. Il y a quasiment tout à proposer, à dire bon bah ça en fait on vous le change.

Déjà prendre l'existant et voir si c'est pas mal. Et d'ailleurs ça me fait emmener, je vois que vous avez des bornes wifi à Roubaix.

Je vois que vous avez des bornes wifi à Roubaix.

Vous avez d'autres bornes wifi, elles sont toutes là ou alors c'est directement via votre box orange j'imagine qui vous permet d'accéder au wifi ?

On a 1000m2 quand même de locaux donc il y en a quelques unes. Ça capte pas hyper bien partout mais il y en a quelques unes.

Pour les high tickets c'est quand même contraignant ?

Eux on a une salle exprès pour eux, on met pas le tournement avec les high tickets.

Du coup, il y a tous les flux qui passent par cette box orange ? Ou vous avez un autre équipement ou d'autres équipements qui traînent dans une salle ? J'avais dit qu'il y avait une box orange. Vous n'avez pas été très au casse sur ce qu'il y a ?

Il faut que je te rende. Oui, on a une box orange fibrée. Tout passe par là.

Vous n'avez pas d'autres équipements qui traînent ? Par contre, c'est un abonnement pro ! Ah oui, attention. J'imagine que si vous avez des problèmes ou des pales, vous appelez Orange. Ah bah oui, ils ont intérêt.

Pas de ligne secondaire ?

Non. Pourquoi pas payer deux fois pour Internet ?

Mais comme vous êtes des clients à l'étiquette, ce serait dommage de perdre une connexion internet et de tout miser sur le cheval. La étiquette, on va chez eux. C'est pas eux qui se déplacent. Ah ok, ça change maintenant du coup. Ah oui, c'est vrai.

Parce qu'en plus, je dis, il y a les nomades. Mais à la fois, juste avant, je disais, il y avait la salle dédiée pour la étiquette. C'est les médiums tickets. Les médiums tickets, ils sont là, ok.

Ça va être chaud. Ok.

Non, mais la ligne secondaire, toi, c'est un sujet en effet... Vous êtes le premier groupe aujourd'hui à... Il y en a un à qui j'ai dit : "Ouais, dans une ancienne boîte, j'ai fait des lignes secondaires mais tout en ADSL." Deux lignes ADSL en trois lignes ADSL. Ça coûtait trop cher de faire installer à Fibo.

Après, si tu fais un band de trois lignes ADSL, tu peux essayer d'avoir une connexion.

En fait, il y avait déjà les lignes téléphoniques dans le bâtiment. Donc on a profité des 3 lignes pour... C'est des lignes RTC du coup ? Ouais ! Donc toi du coup tu fais avec ça alors que quand tu contactes SFR et Orange et qu'ils t'annoncent les tarifs pour faire installer la fibre pro tu fais... On est resté avec des abonnements particuliers, la boîte n'allait pas hyper bien, il y avait une recherche d'investisseurs...

Donc tu fais des choix qui sont durs et pas très logiques.

pas très logique logique à l'instant t mais pas logique quand tu te projettes à deux ans ou cinq ans du coup juste pour terminer sur Medisol qu'elle serait votre si dans la qu'est ce qui serait un succès pour vous dans notre collaboration ou qu'est ce qui serait un échec par rapport à ce projet là qu'on va mettre ensemble à quoi vous vous attendez vraiment au minimum

dans cette collaboration pas de panne tout fonctionne de façon fluide que nos clients quand ils viennent ils ont le wifi et ils peuvent regarder Netflix en 4K sur leur téléphone de 3 pouces

Non, pas de données souveraines.

Si, les praticiens nomades, idéalement, ils peuvent accéder à des informations partagées facilement, ce qui n'est pas le cas aujourd'hui. Ils font juste les retours de leur séance avec un vocal qu'ils laissent à la fin de la journée.

Vous n'êtes pas contre de délocaliser votre système d'information entièrement dans le cloud, par exemple ?

Non, non, au moins c'est géré par quelqu'un. Vu qu'on n'a personne en interne...

C'est la question que vous me posez, c'est que du coup... ... ... ...

... ... ... ... ... ... ... ... ... ...

...

mais s'il arrête de faire le stockage des données, c'est très bien.

Après, en même temps, si jamais on peut vous faire une proposition aussi qui vous oriente sans avoir de serveur chez vous directement, mais plutôt orienté cloud, est-ce quelque chose qui pourrait vous convaincre ?

Allez-y, faites-moi des propositions, même indécentes. Je ne vous ai pas dit, mais en fait, je suis la gérante.

On s'adapte à tout ce qui est public.

Du coup j'ai regardé sur société.com, j'ai vu que vous aviez en 2025 un CA estimé à 3 milliards d'euros, c'est ça ?

Parce qu'on aurait besoin quand même d'un rôle budgétaire. En fait, c'est que derrière, on va mettre en place des pratiques FinOps aussi pour glisser tout ça. Oui, 3 milliards. 3 milliards ? Très bien.

Donc c'est bon.

IT4. IT4. Le serveur, le barrette de RAM en or.

En or.

Il y a intérêt qu'il y ait de l'or. En titane, titane.

Et du coup, ça vous intéresserait, vu que vos nomades laissent des vocaux pour faire des rapports, d'avoir de l'IA intégrée dans votre récit ? Ah, l'IA, attention, hein.

Attention, il ne faut pas que les données soient divulguées. Ah, mais justement, ça serait de l'IA en local. Ah, c'est quoi ça, de l'IA en local ? Parce que tout le monde s'occupe de la partie applicative. C'est quoi de la l'IA en... On va s'occuper surtout de la partie infra, non ? C'est vrai, ça.

Parce que là, ça va aller trop au touchy, et ça doit aussi s'occuper de...

Et vous connaissez quelqu'un qui gère ça, là ? C'est pas RNI, c'est RSA. C'est une société qui s'appelle RSA.

Mais c'est pas la nôtre.

Ils sont vraiment spécialisés sur les IA en local.

Avec de l'automatisation, du NUT, enfin tout ça.

Ça permet d'automatiser des tâches pour, par exemple, la dame à l'accueil, qu'elle n'ait pas tout retapé, que justement, ça soit plus facile. C'est bon pour elle aussi. D'accord. J'ai vu que vous aviez un projet pour le portail patient. Vous savez dans combien de temps cela va arriver ?

Est-ce que vous voulez qu'on l'inclue dans cette proposition ? Non, non.

C'est un projet. On verra s'il voit le jour.

Donc on ne s'y attarde pas ?

Non, pas pour l'instant.

C'est pour après.

Prise de rendez-vous en ligne, portail patient, projet. C'est pour après. J'ai compris.

ça va être en plein milieu finalement ce qui va se passer mais si justement tu sais qu'il y a quelque chose il n'y a pas grand chose à anticiper sur ça donc tu l'anticipes et moi je vais vous rajouter bon finalement machin et puis ça se concrétise un petit peu plus dans tous les trucs je ne vous fais pas tout remettre à zéro c'est juste qu'il y a des nouveaux éléments

Pour savoir aussi si jamais vous voulez après justement faire ce portail, vu que vous avez indiqué qu'il y avait un flux de 200 personnes par mois qui faisaient vos consultations, du coup ça pourrait nous permettre aussi d'estimer combien de ressources il faudrait allouer potentiellement pour le futur. Allez-y, estimez. Partir sur le flux de 200 par mois. Admettons que c'est juste des personnes qui consultent.

On pourrait estimer qu'il y aurait peut-être 10 fois plus de personnes qui y arrivent.

200, 200, ça fait combien ça par jour ?

Ça fait 10. 10. Après, quand on continue, je fermais, oui, ça fait 21 jours dans un mois qui sont livrés. Avec 32...

Après, 10.

Après c'est un partage patient, donc c'est pas forcément que pour des rendez-vous, c'est aussi peut-être pour retrouver leur dossier médical, ce qui s'ensuit, on sait pas après.

1000 au lieu de 200. 1000 au lieu de 200. Parce que, bah ouais, sur 20 jours, t'imagines, je vous ai parlé un jour, ça faisait que 10 par jour, et avec 32 salariés, il faut déjà que ça soit que des high-ticket pour que ça commence à être rentable. Donc tu en fais un peu plus et il y a des high tickets et l'ambition c'est qu'on en ait encore un peu plus. Ok. Très bien.

Pour rester sûr. Vous avez d'autres questions ?

Est-ce que vous avez d'autres questions messieurs ?

Puis après c'est pareil avec son 3 milliards. Avec 200, t'arrondis et ça fait 2400 à l'année. Ça fait déjà des sacrés high tickets. C'est pour ça que je pose ces questions.

Mille. Avec la télétransmission mutuelle, tu sais. Ah, la mutuelle, ça sert à rien. On va peut-être l'enlever.

C'est pour ça, je préfère vous poser la question, comme ça, nous, ça nous permet de savoir un peu plus, sans connaître pour autant.

À la base, c'est le sujet, le cas réel. C'est juste un recours.
		

---

# 🟦 **4. GUIDE D’ENTRETIEN — Questions à poser**

---

## 🔵 **PHASE 1 — Contexte & Enjeux Business (Gregory)**

### I. Contexte & Business

- Présentation de MEDISOL, activité, CA, rôle
- Volume d’activité (patients/jour/semaine)
- Organisation des 32 personnes
- Horaires critiques
- Qui administre l’IT ?

### II. Problèmes, Objectifs, Contraintes

- Impact des lenteurs du logiciel patient
- Gestion en cas d’indisponibilité
- Éléments critiques (logiciel, Wi-Fi, télétransmission…)
- Impact financier
- Budget + calendrier
- Objectif du projet (renouvellement / cloud / upgrade)
- 3 préoccupations principales
- Définition du succès / échec

### III. PRA/PCA

- “Zéro panne” → définition concrète
- RTO / RPO
- Incidents majeurs passés
- PRA existant ? Exercices ?
- Fréquence souhaitée
- Accès distant pour praticiens nomades

---

## 🔴 **PHASE 2 — Sécurité & Conformité (Lylian)**

- Exigence de souveraineté / HDS
- DPO / RGPD
- Chiffrement des données
- Localisation des données
- Rétention légale
- Authentification (AD/local)
- Wi-Fi (WPA, réseau invité)
- Accès distant (VPN)
- Caméras / contrôle d’accès
- AIPD réalisée ?

---

## 🟣 **PHASE 3 — Infrastructure & Architecture (Thibaut)**

- État du réseau (FW, switchs, Wi-Fi)
- Segmentation réseau (RZO plat ?)
- Charge Wi-Fi
- Logiciel patient (éditeur, DB, compatibilité RDS/VDI)
- Périphériques spécifiques (Vitale, appareils médicaux)
- Infra actuelle (compute, storage, âge)
- Volumétrie + croissance
- Sauvegardes (externalisées, immuables)
- Fenêtres de maintenance

---

## 🟧 **Checklist avant de partir**

- RTO + RPO confirmés
- PRA existant ou non
- Conformité HDS / DPO / AIPD
- Segmentation réseau
- Compatibilité logiciel patient RDS/VDI
- Type de sauvegarde
- Vision projet (on-prem / cloud / hybride)
- Budget + calendrier

---

---

# 🟦 5**. ACTIONS / DÉCISIONS / RISQUES**

---

# 🟪 6**. POINTS À CLARIFIER / QUESTIONS OUVERTES**

---