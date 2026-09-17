# Climate Canada Dashboard

Projet réalisé pour le cours **INF4163 — Techniques de bases de données** à l'UQO. L'idée de départ : prendre des données climatiques publiques du Canada (température, précipitations, émissions de GES) et construire une petite application complète autour — base de données, API, interface web, et maintenant un tableau de bord Power BI.

Le but n'était pas juste de "faire joli" avec des graphiques, mais de manipuler un vrai pipeline de données : aller chercher les fichiers bruts, les nettoyer, les charger dans SQL Server, écrire des procédures stockées pour en tirer des analyses, puis exposer tout ça via une API et un frontend.

## Ce que ça fait

L'application permet d'explorer, province par province, l'évolution de trois choses entre 2023 et 2025 :

- la **température** moyenne annuelle,
- les **précipitations** cumulées,
- les **émissions de GES** (en Mt CO₂e).

Pour chaque thème, il y a des graphiques, une carte du Canada, et une page "résultats" qui affiche ce que sortent nos procédures stockées (année/province la plus chaude, la plus pluvieuse, etc.).

> Petite note honnête sur les données : les chiffres officiels de GES par province pour 2025 n'étaient pas encore publiés au moment du projet. On a préféré laisser ces cellules à `NULL` plutôt que d'extrapoler un chiffre inventé — ça reste visible dans les moyennes calculées.

## Architecture

Rien de très exotique, c'est le classique base de données → API → frontend :

```
Data brutes (ECCC)
      │
      ▼
   ETL (Python)
      │
      ▼
 SQL Server (3 bases : TemperatureDB, PrecipitationDB, PollutionDB)
      │
      ▼
  FastAPI (backend)
      │
      ▼
   React (frontend)
      │
      ▼
   Power BI (analyse / tableau de bord)
```

Le frontend ne touche jamais directement aux données : tout passe par l'API, qui elle-même interroge SQL Server via pyodbc.

## Les trois bases de données

On a choisi de séparer les trois thèmes en bases distinctes plutôt que de tout mettre dans une seule — plus proche de ce qu'on ferait si chaque domaine (météo, environnement) était géré par une équipe différente.

**TemperatureDB** — température moyenne par province/territoire et par mois, avec l'agrégation annuelle correspondante.

**PrecipitationDB** — précipitations cumulées, même logique de granularité mensuelle → annuelle.

**PollutionDB** — émissions de GES en Mt CO₂e, avec les valeurs 2025 à `NULL` pour les raisons expliquées plus haut.

Chaque base a ses propres procédures stockées (`Database/Procedures/`) pour sortir l'année/la province la plus ou la moins extrême, et des déclencheurs (`Database/Triggers/`) qui bloquent l'insertion de valeurs aberrantes (température hors de -100/70 °C, précipitation négative, émission négative).

```sql
EXEC dbo.sp_AnneePlusMoinsChaude;
EXEC dbo.sp_ProvincePlusMoinsChaude;

EXEC dbo.sp_AnneePlusMoinsPluvieuse;
EXEC dbo.sp_ProvincePlusMoinsPluvieuse;

EXEC dbo.sp_AnneePlusMoinsPolluee;
EXEC dbo.sp_ProvincePlusMoinsPolluee;
```

## Le pipeline ETL

Les scripts dans `ETL/` suivent à peu près ce chemin pour chaque thème : télécharger les fichiers sources, les nettoyer (encodages inconsistants, virgules décimales à la française), calculer les agrégats mensuels puis annuels, valider que rien ne manque, et enfin générer les scripts SQL d'insertion.

C'est volontairement découpé en petits scripts plutôt qu'un seul gros programme — plus facile à relancer un morceau seul quand une source change de format en cours de route (ce qui est arrivé plus d'une fois avec les fichiers d'Environnement Canada).

## Power BI

En plus du dashboard React, il y a maintenant un classeur Power BI (`PowerBI/`) branché directement sur les trois bases SQL Server, pour une analyse plus libre que ce que permet l'interface web (croisements, filtres dynamiques, export). Voir [`PowerBI/README.md`](PowerBI/README.md) pour la marche à suivre — en résumé, Power BI Desktop se connecte en direct aux bases via le même driver ODBC que le backend.

## Stack technique

| Techno | Rôle |
|---|---|
| SQL Server / T-SQL | Stockage, procédures stockées, déclencheurs |
| Python + pandas | ETL (extraction, nettoyage, agrégation) |
| pyodbc | Connexion Python ↔ SQL Server |
| FastAPI + Uvicorn | API REST |
| React + Vite | Interface web |
| Chart.js | Graphiques |
| Power BI Desktop | Tableau de bord analytique |
| Bootstrap | Mise en page rapide du frontend |

## Structure du dépôt

```
Projet_INF4163/
├── Data/                 données brutes, intermédiaires et scripts SQL générés
├── Database/             création des bases, procédures stockées, déclencheurs
├── ETL/                  scripts Python du pipeline
├── PowerBI/              classeur .pbix + guide de connexion
├── Website/
│   ├── backend/          API FastAPI
│   └── frontend/         application React
├── Rapport/              rapport et annexes du cours
└── Presentation/         support de présentation
```

## Installation et exécution locale

### Prérequis

Python 3, SQL Server (Express suffit), SQL Server Management Studio ou équivalent, ODBC Driver 17/18 for SQL Server, Node.js + npm, Git. Power BI Desktop si tu veux ouvrir le tableau de bord.

### 1. Cloner

```bash
git clone https://github.com/Ulrich120/Projet_INF4163_Climate_Canada.git
cd Projet_INF4163_Climate_Canada
```

### 2. Mettre en place SQL Server

Exécuter les scripts de `Database/` (création des bases, puis `Database/Procedures/` et `Database/Triggers/`). Le nom du serveur utilisé par le backend (`Website/backend/app/database.py`) doit correspondre à ton instance locale — un `SELECT @@SERVERNAME;` dans SSMS te donne la bonne valeur si ce n'est pas déjà le cas.

### 3. Lancer le backend

```powershell
python -m venv .venv3
.\.venv3\Scripts\Activate.ps1
python -m pip install -r Website\backend\requirements.txt
cd Website\backend
python -m uvicorn app.main:app --reload
```

L'API tourne sur `http://127.0.0.1:8000` (doc interactive sur `/docs`).

### 4. Lancer le frontend

Dans un autre terminal :

```powershell
cd Website\frontend
npm install
npm run dev
```

Vite indique l'adresse locale, en général `http://localhost:5173`.

Le backend doit être démarré avant (ou pendant) l'utilisation du frontend — sans lui, les pages restent vides.

## Équipe

Projet réalisé à trois pour le cours INF4163 (UQO, 2026) :

- **Dongmo Ulrich** — conception et développement (ETL, bases de données, procédures stockées, backend FastAPI, frontend React, intégration Power BI)
- **Domingo Christophe Jules Ifede Vignon** — rapport et documentation
- **Diagne El Hadj Talla** — présentation et support visuel

## Sources et limites

Les données proviennent d'Environnement et Changement climatique Canada. Elles ont été retravaillées (nettoyage, agrégation, recodage des provinces) pour les besoins du projet — ce ne sont pas les fichiers officiels tels quels. Comme mentionné plus haut, certaines valeurs 2025 ne sont pas encore disponibles côté GES et apparaissent volontairement comme `NULL` plutôt que comme une estimation.

Projet universitaire, données externes soumises aux conditions d'utilisation de leurs fournisseurs respectifs.
