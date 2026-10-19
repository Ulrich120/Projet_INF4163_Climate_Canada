# Analyse des données climatiques du Canada — INF4163

**Projet de session — Techniques de bases de données | Université du Québec en Outaouais (2026)**

Dans le cadre du cours INF4163, notre équipe a développé une application permettant de consulter et d'analyser des données climatiques canadiennes. Nous avons travaillé sur trois thèmes : les températures, les précipitations et les émissions de gaz à effet de serre (GES).

Au départ, le projet portait surtout sur l'extraction et l'organisation des données dans SQL Server. Nous l'avons ensuite fait évoluer vers une application web complète, avec une API, une interface de visualisation et un volet d'analyse dans Power BI. Cela nous a permis de mettre en pratique plusieurs notions du cours, tout en abordant des questions concrètes de qualité et d'interprétation des données.

**[Consulter la démonstration en ligne](https://projet-inf-4163-climate-canada.vercel.app)**

> La démonstration utilise une API hébergée sur l'offre gratuite de Render. Après une période d'inactivité, son premier chargement peut prendre environ une minute. Les données de cette version sont accessibles en lecture seule.

## 1. Présentation du projet

Nous avons exploité **4 056 fichiers mensuels** provenant d'Environnement et Changement climatique Canada (ECCC), couvrant les **13 provinces et territoires**, de **2000 à 2025**. Le jeu de données traité représente **434 723 relevés provenant de 3 175 stations**.

Le travail a consisté à construire une chaîne de traitement allant des fichiers sources jusqu'à leur consultation dans une interface web :

1. Collecter et préparer les fichiers climatiques.
2. Nettoyer et agréger les observations avec Python.
3. Organiser les résultats dans des bases SQL Server.
4. Développer des procédures stockées et des déclencheurs.
5. Exposer les données au moyen d'une API FastAPI.
6. Afficher les résultats avec React et proposer une analyse complémentaire dans Power BI.

L'application permet de sélectionner une province ou un territoire, de consulter les graphiques et la carte, puis de comparer les résultats entre différentes périodes. Des pages de résultats présentent également les analyses réalisées par les procédures stockées.

La version initiale remise dans le cadre du cours, limitée à la période 2023–2025, est conservée sous le tag `v1-remise-inf4163`.

## 2. Architecture et choix techniques

```text
Fichiers climatiques ECCC
          |
          v
     ETL Python
          |
          v
 SQL Server (3 bases)
          |
          v
   API FastAPI
          |
          v
 Interface React

Power BI : analyse complémentaire à partir des bases SQL Server
```

Nous avons choisi de séparer le traitement des données, le stockage et l'affichage. Le frontend n'accède donc pas directement à SQL Server : les requêtes passent par l'API, qui utilise `pyodbc` pour communiquer avec la base de données.

### Organisation des bases de données

| Base | Contenu |
|---|---|
| `TemperatureDB` | Températures mensuelles et agrégations annuelles par province ou territoire |
| `PrecipitationDB` | Précipitations mensuelles et cumuls annuels |
| `PollutionDB` | Émissions de GES en Mt CO₂e |

La séparation en trois bases nous a permis de traiter chaque domaine indépendamment et de mieux structurer les scripts SQL. Des **procédures stockées** permettent d'identifier les années et les provinces présentant les valeurs les plus élevées ou les plus faibles. Des **déclencheurs** vérifient certaines valeurs lors des insertions, notamment les températures hors de la plage −100 à 70 °C, les précipitations négatives et les émissions négatives.

Exemples de procédures utilisées, à exécuter dans la base correspondante :

```sql
EXEC dbo.sp_AnneePlusMoinsChaude;
EXEC dbo.sp_ProvincePlusMoinsChaude;

EXEC dbo.sp_AnneePlusMoinsPluvieuse;
EXEC dbo.sp_ProvincePlusMoinsPluvieuse;

EXEC dbo.sp_AnneePlusMoinsPolluee;
EXEC dbo.sp_ProvincePlusMoinsPolluee;
```

Les scripts sont regroupés dans `Database/Procedures/` et `Database/Triggers/`.

## 3. Collecte et traitement des données (ETL)

Les scripts du dossier `ETL/` suivent les étapes classiques d'un processus **Extract, Transform, Load** : extraction des fichiers sources, nettoyage et transformation, puis préparation de leur chargement dans SQL Server.

Nous avons notamment dû gérer des différences d'encodage, les virgules décimales et les données manquantes. Les observations sont ensuite regroupées à l'échelle mensuelle ou annuelle, selon les indicateurs. Les scripts SQL d'insertion sont générés à partir des données préparées.

Nous avons préféré répartir ce travail dans plusieurs scripts Python plutôt que de tout réunir dans un seul fichier. Cette organisation facilite les vérifications et permet de relancer uniquement une étape lorsqu'un traitement échoue ou qu'un format de fichier change.

**Point important :** une valeur annuelle n'est calculée que si les douze mois nécessaires sont disponibles. Sinon, elle reste absente. Les valeurs provinciales de GES non publiées pour 2025 sont conservées à `NULL`, sans extrapolation. Les règles de traitement et leurs limites sont détaillées dans `Data/README.md`.

## 4. Résultats et enseignements

L'une des principales difficultés rencontrées n'était pas la création des graphiques, mais la manière de comparer des observations issues d'un réseau de stations qui change au fil du temps.

### Températures

Le nombre de stations actives passe d'environ **1 780 en 2000 à 1 000 en 2025**. Cette évolution peut fausser une moyenne calculée directement à partir de toutes les stations disponibles chaque année.

Par exemple, au Québec, une moyenne simple suggère une baisse de **0,74 °C par décennie**, tandis qu'une analyse fondée sur les anomalies propres à chaque station indique une hausse de **0,44 °C par décennie**.

En comparant les observations de chaque station à sa propre référence (`ETL/station_anomalies.py`), nous obtenons, pour les 13 provinces et territoires, des tendances comprises entre **+0,12 et +0,62 °C par décennie**. À l'échelle du Canada, en donnant le même poids à chaque province ou territoire, l'estimation est de **+0,35 °C par décennie**, avec un intervalle de confiance à 95 % de **+0,04 à +0,67 °C**.

Ces résultats doivent être interprétés avec prudence : sur les 13 provinces et territoires, seuls cinq présentent un intervalle de confiance qui exclut zéro.

### Précipitations

Le même problème se retrouve dans l'analyse des précipitations. La somme des relevés des stations actives suggère une baisse nationale de **38 mm par décennie** (de 792 mm en 2000 à 618 mm en 2025). L'analyse par anomalies de stations donne plutôt **−0,9 % de la normale par décennie**, avec un intervalle allant de **−4,4 % à +2,5 %**. Cette dernière estimation ne permet pas de conclure à une tendance nette.

Nous avons aussi observé un changement de qualité des données autour de 2008 : la proportion de relevés comportant plus de cinq jours manquants passe d'environ **4 % à 17 %**. Ces relevés sont exclus de l'analyse des tendances. Aucune tendance de précipitations n'est calculée pour le Yukon, faute de station de longue durée répondant aux critères retenus.

### Émissions de GES

L'analyse sectorielle montre une diminution d'environ **10 %** des émissions nationales depuis 2005, de **763,0 à 684,7 Mt CO₂e**. Environ **85 %** de cette diminution provient du secteur de l'électricité. Hors électricité, la baisse est de **1,9 %**, tandis que les émissions du pétrole et du gaz augmentent de **5 %**.

Ces résultats nous ont appris qu'une tendance statistique dépend fortement de la méthode de calcul et de la couverture des données. Il est donc important de présenter les incertitudes et de documenter les limites plutôt que de s'arrêter à un chiffre ou à un graphique.

La méthode a été testée sur des réseaux synthétiques dont les tendances sont connues (`tests/etl/`). Les analyses détaillées figurent dans `docs/analyse.md` et les précautions méthodologiques dans `Data/README.md`.

## 5. Interface web et Power BI

L'interface React présente des pages consacrées aux températures, aux précipitations et à la pollution. Elle permet d'explorer les données à l'aide de graphiques, de cartes et de filtres. Les tendances de température et de précipitations y sont présentées avec leurs intervalles de confiance.

Power BI constitue un complément à cette interface. Il permet d'effectuer des comparaisons plus libres, d'appliquer des filtres et de construire des tableaux de bord analytiques à partir des bases SQL Server. Le dossier `PowerBI/README.md` explique comment établir la connexion et utiliser les mesures DAX proposées.

## 6. Technologies utilisées

| Technologie | Utilisation dans le projet |
|---|---|
| Python, pandas | Extraction, nettoyage et agrégation des données |
| SQL Server, T-SQL | Stockage, procédures stockées et déclencheurs |
| pyodbc | Connexion de Python à SQL Server |
| FastAPI, Uvicorn | Développement et exécution de l'API REST |
| React, Vite, Bootstrap | Interface web |
| Chart.js | Graphiques interactifs |
| Power BI Desktop | Analyse et tableaux de bord |
| Docker Compose | Démarrage de l'environnement complet |
| SQLite | Données de démonstration en lecture seule |
| Render, Vercel | Hébergement de l'API et du frontend |
| pytest, Ruff, GitHub Actions | Tests et contrôles automatisés |

## 7. Organisation du dépôt

```text
Projet_INF4163/
├── Data/                 Données et agrégations
├── Database/             Scripts SQL, procédures, déclencheurs, vues et setup.ps1
├── ETL/                  Scripts de collecte et de transformation
├── PowerBI/              Guide Power BI et mesures DAX
├── Website/
│   ├── backend/          API FastAPI
│   └── frontend/         Application React
├── tests/                Tests ETL et API
├── docker/               Configuration des conteneurs
├── docker-compose.yml
├── deploy/               Scripts de déploiement et comparaison des backends
├── render.yaml
├── Rapport/              Rapport et annexes du cours
└── Presentation/         Présentation du projet
```

## 8. Exécuter le projet avec Docker

Pour faciliter la prise en main, nous avons prévu une configuration Docker Compose qui démarre SQL Server, l'API et l'interface sans avoir à installer chaque service séparément.

À la racine du dépôt :

```powershell
Copy-Item .env.example .env

docker compose up --build
```

Ouvrir ensuite **http://localhost:8080**.

Le premier lancement télécharge les images nécessaires, dont celle de SQL Server (environ 1,5 Go), puis initialise les trois bases. Les données sont conservées dans un volume Docker entre les démarrages.

```powershell
docker compose down       # Arrêter les services
docker compose down -v    # Arrêter et supprimer aussi les volumes de données
```

**Configuration :** le fichier `.env.example` contient `ACCEPT_EULA=Y`, qui indique l'acceptation des licences Microsoft associées à SQL Server Express et au pilote ODBC. Il contient également un mot de passe de démonstration (`MSSQL_SA_PASSWORD`) à remplacer pour tout usage réel. Le port SQL Server est exposé uniquement sur l'ordinateur local (`127.0.0.1`, port 14333 par défaut). Les ports peuvent être adaptés avec `WEB_PORT` et `DB_PORT`.

La configuration CI GitHub lance aussi Docker Compose et vérifie que l'application répond avec ses données.

## 9. Installation locale sans Docker

### Prérequis

- Python 3, Git, Node.js et npm
- SQL Server (l'édition Express convient) et SSMS ou un autre client SQL
- ODBC Driver 17 ou 18 for SQL Server
- Power BI Desktop pour consulter ou développer les rapports

### Récupérer le projet

```powershell
git clone https://github.com/Ulrich120/Projet_INF4163_Climate_Canada.git
cd Projet_INF4163_Climate_Canada
```

### Préparer les bases de données

```powershell
.\Database\setup.ps1 -Server ".\SQLEXPRESS"
```

Le paramètre `-Reset` permet de repartir de zéro, mais **réinitialise les données**. Il ne faut donc l'utiliser que si cette opération est souhaitée.

Copier `Website/backend/.env.example` vers `Website/backend/.env`, puis y renseigner l'instance SQL Server. Au besoin, la requête `SELECT @@SERVERNAME;` dans SSMS permet de vérifier le nom du serveur.

### Relancer l'ETL (facultatif)

Les fichiers annuels et les scripts d'insertion sont déjà inclus dans le dépôt. Pour reconstruire les résultats depuis les fichiers ECCC (environ 4 000 fichiers, durée indicative d'une heure) :

```powershell
python -m pip install -r ETL/requirements.txt
python ETL/download_climate_summaries.py
python ETL/aggregate_temperature.py
python ETL/aggregate_precipitation.py
python ETL/aggregate_pollution.py
python ETL/build_station_table.py
python ETL/station_anomalies.py
python ETL/plot_trends.py
python ETL/analyze_ges.py
python ETL/generate_sql.py
```

Le script de téléchargement peut reprendre après une interruption. La table intermédiaire des stations est enregistrée dans `Data/Interim/stations_monthly.csv.gz`; les résultats d'anomalies sont produits dans `Data/Processed/` et certaines figures dans `docs/figures/`. La période étudiée est définie par `START_YEAR` et `END_YEAR` dans `ETL/config.py`.

### Démarrer le backend

Depuis la racine du projet, dans PowerShell :

```powershell
python -m venv .venv3
.\.venv3\Scripts\Activate.ps1
python -m pip install -r Website\backend\requirements.txt
cd Website\backend
python -m uvicorn app.main:app --reload
```

L'API est accessible à **http://127.0.0.1:8000** et sa documentation interactive à **http://127.0.0.1:8000/docs**.

### Démarrer le frontend

Dans un second terminal, depuis la racine du dépôt :

```powershell
cd Website\frontend
npm install
npm run dev
```

Vite affiche l'adresse de l'interface, généralement **http://localhost:5173**. L'API doit également être en cours d'exécution pour que les données puissent être chargées.

### Utiliser le mode démonstration sans SQL Server

Depuis la racine du dépôt, générer les bases SQLite :

```powershell
python ETL/build_demo_db.py
cd Website\backend
$env:DATA_BACKEND = "sqlite"
$env:DEMO_DB_DIR = "../../Data/Demo"
python -m uvicorn app.main:app --reload
```

Lancer ensuite le frontend comme indiqué plus haut. L'interface précise si elle utilise SQL Server ou le mode démonstration.

### En cas de problème de chargement

Si l'interface affiche « Impossible de charger », vérifier d'abord que **http://127.0.0.1:8000/api/health** répond, puis que le serveur Vite fonctionne. Vérifier également la variable `VITE_API_URL` si elle a été définie. Une fois le problème corrigé, le bouton « Réessayer » permet de recharger les données.

## 10. Déploiement de la démonstration

Pour rendre le projet consultable sans installer SQL Server, nous avons déployé le frontend sur **Vercel** et l'API sur **Render**. La version publique utilise trois bases SQLite en lecture seule, construites à partir des mêmes CSV par `ETL/build_demo_db.py`.

Ce choix vient surtout des contraintes de l'hébergement gratuit : une instance SQL Server demande davantage de ressources et n'est pas proposée dans cette configuration. La version locale conserve SQL Server comme base principale.

### Déployer l'API sur Render

1. Dans Render, choisir **New → Blueprint** et sélectionner le dépôt.
2. Le fichier `render.yaml` définit le service Docker.
3. Renseigner `CORS_ORIGINS` avec l'adresse du frontend Vercel, ou une valeur provisoire à corriger ensuite.
4. Tester l'URL `https://<nom-du-service>.onrender.com/api/health`. La réponse doit indiquer `"donnees":"sqlite"`.

### Déployer le frontend sur Vercel

1. Choisir **Add New → Project** et importer le dépôt.
2. Définir `Website/frontend` comme **Root Directory**.
3. Définir `VITE_API_URL` avec l'adresse Render, sans barre oblique finale.
4. Déployer. Le fichier `vercel.json` gère la navigation entre les pages.
5. Retourner sur Render pour mettre `CORS_ORIGINS` à jour avec l'adresse Vercel définitive. `CORS_ORIGIN_REGEX` peut aussi autoriser les URL de prévisualisation.

L'offre gratuite de Render met le service en veille après environ quinze minutes sans activité. La première requête peut donc être plus lente. Une solution SQL Server hébergée en permanence demanderait une configuration payante, qui n'a pas été mise en place dans ce projet.

Le script `deploy/compare_backends.py` compare les réponses des **dix routes API** entre SQL Server et SQLite; cette vérification est également intégrée à la CI.

## 11. Tests et vérifications

Depuis la racine du dépôt :

```powershell
python -m pip install -r requirements-dev.txt
ruff check .
pytest
```

Les tests vérifient notamment le nettoyage et l'agrégation des données, ainsi que les routes de l'API. Certains tests utilisent une base simulée, ce qui évite d'avoir besoin de SQL Server pour les lancer. GitHub Actions exécute aussi des contrôles de qualité du code et une compilation du frontend à chaque push.

## 12. Répartition du travail

Projet réalisé en équipe de trois dans le cadre du cours INF4163 à l'UQO :

| Membre | Contribution principale |
|---|---|
| **Dongmo Ulrich** | Conception et développement : ETL, bases de données, procédures stockées, backend FastAPI, frontend React et intégration Power BI |
| **Domingo Christophe Jules Ifede Vignon** | Rapport et documentation |
| **Diagne El Hadj Talla** | Présentation et support visuel |

## 13. Bilan personnel

Ce projet m'a permis de mieux comprendre ce qu'implique la réalisation d'une application centrée sur les données. Au-delà des requêtes SQL, j'ai dû relier plusieurs outils, organiser les traitements, gérer les problèmes de qualité des fichiers et vérifier que les résultats affichés correspondaient réellement aux données analysées.

La partie la plus formatrice a été la comparaison entre les agrégations simples et les analyses par station. Elle m'a montré qu'un traitement techniquement correct ne suffit pas : il faut aussi s'assurer que la méthode utilisée permet de répondre à la question posée.

J'ai également pu approfondir mes compétences en Python, SQL Server, développement d'API, React, tests automatisés et déploiement. Ce sont des compétences que je souhaite continuer à développer dans mes prochains projets en génie informatique et en analyse de données.

## 14. Sources et limites

Les données utilisées proviennent d'**Environnement et Changement climatique Canada**. Elles ont été nettoyées, regroupées et transformées pour les besoins de notre application : les fichiers produits ne doivent donc pas être confondus avec les fichiers officiels d'origine.

Certaines observations sont incomplètes, le réseau de stations varie au fil des années et les émissions provinciales de GES pour 2025 ne sont pas encore publiées. Ces limites influencent l'interprétation des résultats et sont détaillées dans `Data/README.md` et `docs/analyse.md`.

Ce dépôt est un projet universitaire. Les données externes restent soumises aux conditions d'utilisation de leurs fournisseurs respectifs.
