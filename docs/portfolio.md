# Présenter le projet (CV, LinkedIn, entretien)

À adapter à ton rôle exact dans l'équipe : le projet d'origine est un travail d'équipe, ce texte décrit l'ensemble de ce que contient la version actuelle.

## Titre

**Climate Canada Dashboard : pipeline de données, API et tableau de bord sur 25 ans de climat canadien**
Démo : https://projet-inf-4163-climate-canada.vercel.app · Code : https://github.com/Ulrich120/Projet_INF4163_Climate_Canada

## Pour le CV (4 lignes)

- Pipeline Python de bout en bout : 4 056 fichiers mensuels d'Environnement et Changement climatique Canada (434 723 relevés, 3 175 stations) nettoyés, agrégés et chargés dans 3 bases SQL Server (procédures stockées, triggers, vues).
- Détection et correction de deux biais de mesure : la moyenne simple des stations affichait un faux refroidissement (−0,74 °C par décennie au Québec, contre +0,44 en suivant chaque station) ; méthode validée sur des réseaux synthétiques et rendue avec intervalles de confiance à 95 %.
- API FastAPI, interface React/Vite et tableau de bord Power BI ; conteneurisation Docker Compose ; intégration continue GitHub Actions (75 tests, lint, build, comparaison SQL Server contre SQLite).
- Déploiement public (Render + Vercel) avec un mode démonstration SQLite vérifié identique à SQL Server sur 10 routes de l'API.

## Pour le CV (version anglaise)

- Built an end-to-end Python data pipeline: 4,056 monthly Environment and Climate Change Canada files (434,723 readings, 3,175 stations) cleaned, aggregated and loaded into three SQL Server databases (stored procedures, triggers, views).
- Found and corrected two measurement biases: the naive station average showed a false cooling (−0.74 °C/decade in Quebec, versus +0.44 when tracking each station); validated the method on synthetic networks and reported 95 % confidence intervals.
- Shipped a FastAPI backend, a React/Vite front end and a Power BI dashboard; containerised with Docker Compose; GitHub Actions CI (75 tests, lint, build, SQL Server vs SQLite equivalence check).
- Deployed publicly (Render + Vercel) with a read-only SQLite demo mode verified identical to SQL Server on 10 API routes.

## Description LinkedIn (section « Projets »)

Projet de session (INF4163, UQO) que j'ai ensuite repris pour en faire un vrai projet d'analyse de données. À partir des données publiques d'ECCC (température, précipitations, émissions de gaz à effet de serre, 13 provinces et territoires, 2000-2025), j'ai construit le pipeline complet : collecte, nettoyage, bases SQL Server, API, interface web et tableau de bord Power BI.

Ce que j'en retiens : la moyenne simple des stations ment. Le réseau d'ECCC passe d'environ 1 780 stations actives à environ 1 000, ce qui fait « refroidir » le Québec alors que, station par station, il se réchauffe. Pour les précipitations, une rupture de qualité en 2008 (jours de mesure manquants) créait une fausse baisse nationale « significative ». Côté GES, 85 % de la baisse nationale depuis 2005 vient d'un seul secteur, l'électricité.

Technologies : Python (pandas, SciPy), SQL Server / T-SQL, FastAPI, React, Power BI, Docker, GitHub Actions.

## Pitch de 30 secondes

« J'ai pris 25 ans de données climatiques publiques du Canada et j'ai construit tout le trajet, des fichiers bruts jusqu'au site en ligne. Le plus intéressant, c'est que la méthode naïve donnait la mauvaise réponse : la moyenne des stations montrait un refroidissement au Québec parce que le réseau de stations change. Je l'ai corrigé en comparant chaque station à elle-même, et j'ai vérifié la méthode sur des données synthétiques dont je connais la vraie réponse. »

## Questions d'entretien probables

**Pourquoi la moyenne simple trompe-t-elle ?** La composition du réseau change (stations qui ferment, souvent plus chaudes ou plus au sud) : on compare des échantillons différents d'une année à l'autre. Comparer chaque station à sa propre moyenne mensuelle retire cet effet.

**Comment savoir que votre méthode est bonne ?** Réseau synthétique à climat stable avec fermetures de stations chaudes : la moyenne simple invente −5,2 °C par décennie, la méthode retrouve 0,0. Avec un réchauffement connu de 0,4, elle retrouve 0,4. Ce sont des tests automatiques.

**Quel est le résultat le plus incertain ?** La tendance par province : sur 13, seules 5 ont un intervalle de confiance qui exclut zéro. Vingt-six ans, c'est court devant la variabilité annuelle.

**Pourquoi un mode SQLite en plus de SQL Server ?** Un site public ne peut pas joindre une base locale. Le mode démonstration réécrit les 6 procédures stockées en Python avec la même arithmétique décimale, et un script compare 10 routes de l'API entre les deux modes (10 sur 10 identiques, vérifié en CI).

**Quelles erreurs avez-vous faites ?** Quand l'API ne répondait pas (arrêtée en local, ou en veille sur l'offre gratuite), les pages restaient vides sans expliquer pourquoi. J'ai ajouté un message clair avec un bouton « Réessayer » et désactivé les listes tant que les données manquent. Autre cas : un libellé « moyenne nationale » affichait en fait une moyenne par province ; je l'ai corrigé.

**Que feriez-vous avec plus de temps ?** Normaliser les émissions par habitant et par PIB, descendre au sous-secteur pour l'Alberta, utiliser une normale de 30 ans, et tester l'autocorrélation des résidus (voir [`analyse.md`](analyse.md)).
