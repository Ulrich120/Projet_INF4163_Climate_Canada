# Tableau de bord Power BI

Ce dossier contient de quoi construire un rapport Power BI branché **en direct sur SQL Server**, sur les mêmes trois bases que le backend FastAPI (`TemperatureDB`, `PrecipitationDB`, `PollutionDB`).

Il n'y a volontairement pas de fichier `.pbix` versionné ici : ce format est un binaire propriétaire qui se prête mal à un dépôt Git (diffs illisibles, gros fichiers, credentials parfois embarqués). À la place, tu trouveras tout ce qu'il faut pour reconstruire le rapport en quelques minutes chez toi :

- [`sql/`](../Database/Views/create_views.sql) — vues SQL qui simplifient la connexion (jointures déjà faites)
- [`dax/measures.dax`](dax/measures.dax) — les mesures à recréer dans le modèle

## 1. Créer les vues côté SQL Server

Avant d'ouvrir Power BI, exécute `Database/Views/create_views.sql` dans SSMS. Ça crée une vue par base (`vw_Temperature`, `vw_Precipitation`, `vw_Pollution`) qui inclut déjà le nom de la province et l'année en clair — évite de refaire les jointures dans Power Query.

## 2. Se connecter depuis Power BI Desktop

Pour chacune des trois bases :

1. **Accueil → Obtenir les données → Serveur SQL Server**
2. Serveur : le même que dans `Website/backend/app/database.py` (par défaut `Ulrich\SQLEXPRESS`, à adapter à ton instance)
3. Mode de connectivité : **Import** (les données ne bougent pas assez souvent pour justifier du DirectQuery, et Import donne de meilleures performances pour les visuels)
4. Sélectionner la base correspondante, puis cocher :
   - `vw_Temperature` (dans TemperatureDB)
   - `vw_Precipitation` (dans PrecipitationDB)
   - `vw_Pollution` (dans PollutionDB)
   - `Province` et `Annee` (une seule fois, depuis TemperatureDB — voir étape 3)

Répète l'opération pour les trois bases (Power BI permet d'avoir plusieurs sources SQL Server dans un seul modèle).

## 3. Construire un schéma en étoile

Les tables `Province` et `Annee` existent dans les trois bases avec exactement les mêmes identifiants (1 à 13 pour les provinces, 1 à 3 pour les années — voir `ETL/generate_sql_*.py`). Ça permet de n'en importer **qu'une seule copie** et de la partager entre les trois faits :

- Importer `Province` et `Annee` depuis `TemperatureDB` seulement
- Dans la vue **Modèle**, créer les relations :
  - `Province[ProvinceID]` → `vw_Temperature[ProvinceID]`, `vw_Precipitation[ProvinceID]`, `vw_Pollution[ProvinceID]`
  - `Annee[AnneeID]` → `vw_Temperature[AnneeID]`, `vw_Precipitation[AnneeID]`, `vw_Pollution[AnneeID]`

Résultat : un schéma en étoile classique, avec `Province` et `Annee` comme dimensions communes aux trois thèmes climatiques.

## 4. Ajouter les mesures

Ouvre `dax/measures.dax` et recrée chaque mesure listée (clic droit sur la table concernée → **Nouvelle mesure**, coller la formule). Rien d'automatisé ici, Power BI ne permet pas d'importer un fichier `.dax` directement.

## 5. Construire les visuels

Suggestions de base pour un premier rapport :

- Carte du Canada colorée par province (température moyenne, précipitations ou émissions selon la page)
- Courbe d'évolution 2023-2025 par province sélectionnée (slicer sur `Province[CodeProvince]`)
- Graphique en barres pour comparer les 13 provinces sur une année donnée
- Cartes KPI utilisant les mesures `Temperature Moyenne`, `Precipitation Totale`, `Emissions Moyennes`

## Pourquoi Power BI en plus du dashboard React

Le frontend React couvre les besoins de présentation (démo, navigation guidée). Power BI sert à l'exploration libre : croiser les trois thèmes ensemble, filtrer par province ou par année sans coder de nouvelle page, exporter vers Excel. Les deux tapent sur les mêmes bases, donc pas de risque de désynchronisation entre les chiffres affichés.
