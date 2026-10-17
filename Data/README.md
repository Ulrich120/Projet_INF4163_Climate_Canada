# Données : sources, méthode et limites

Période couverte : **2000 à 2025**, 13 provinces et territoires (338 lignes par thème).

## Sources

| Thème | Source | Fichier brut |
|---|---|---|
| Température, précipitations | ECCC, [Sommaires climatiques mensuels](https://climat.meteo.gc.ca/) (un CSV par province, mois et année, une ligne par station) | `Raw/Temperature/` (~4 000 fichiers, non versionnés, régénérés par `ETL/download_climate_summaries.py`) |
| Émissions de GES | ECCC, [Inventaire officiel canadien des GES](https://data-donnees.az.ec.gc.ca/api/file?path=/substances/monitor/canada-s-official-greenhouse-gas-inventory/B-Economic-Sector/GHG_Econ_Can_Prov_Terr.csv), tableau par secteur économique, provinces et territoires | `Raw/Pollution/GES_Econ_Can_Prov_Terr.csv` (versionné, version française du fichier `GHG_Econ_Can_Prov_Terr.csv`) |

Les CSV agrégés utilisés par la base sont dans `Processed/`.

## Méthode

**Température.** Pour chaque province et chaque mois : moyenne de la température moyenne (`Tm`) de toutes les stations ayant une mesure. La valeur annuelle est la moyenne des 12 mois.

**Précipitations.** Même principe avec `P` ; la valeur annuelle est la **somme** des 12 moyennes mensuelles (mm).

**GES.** Total provincial de l'inventaire (kt CO₂e) converti en Mt CO₂e, sans ventilation sectorielle.

**Séries incomplètes.** Une valeur annuelle n'est calculée que si les 12 mois sont disponibles, sinon elle reste `NULL` (une moyenne sur 11 mois serait biaisée par la saison). Sur la période, aucune série de température ou de précipitations n'est incomplète.

**Année non publiée.** ECCC n'a pas encore publié les GES provinciaux 2025 : les 13 valeurs restent `NULL`, elles ne sont jamais estimées.

**Validation.** Le pipeline refuse de continuer si le nombre de lignes, les doublons, les provinces, les années ou la continuité des séries GES sont incohérents (voir les tests dans `tests/etl/`). Les 117 valeurs 2023-2025 obtenues sont identiques à celles de la première version du projet (tag `v1-remise-inf4163`).

## Tendance de température : pourquoi la moyenne simple ne suffit pas

Le nombre de stations qui rapportent une mesure passe d'environ 1 780 en 2000 à environ 1 000 en 2025 pour l'ensemble du pays. Au Québec, il tombe de ~194 à ~127 stations entre 2017 et 2018, et la moyenne annuelle simple chute de 1,75 °C la même année. Comme le réseau change, **la moyenne des stations actives une année donnée n'est pas comparable d'une année à l'autre** : elle donne par exemple −0,74 °C par décennie au Québec.

La méthode retenue (`ETL/station_anomalies.py`) compare chaque station à sa propre moyenne pour le même mois, puis agrège ces écarts par province :

1. une station n'est utilisée que si elle a au moins 10 années de mesures pour le mois considéré ;
2. une année provinciale n'est calculée que si au moins 10 mois sont disponibles ;
3. résultat principal : uniquement les stations présentes au moins 20 ans, car garder toutes les stations laisse un léger biais quand des stations ouvrent ou ferment ;
4. tendance : régression linéaire des anomalies annuelles, avec intervalle de confiance à 95 %.

**Validation.** Sur un réseau synthétique à climat stable où des stations chaudes ferment en cours de période, la moyenne simple invente −5,2 °C par décennie, la méthode par stations longues retrouve 0,0. Avec un vrai réchauffement de 0,4 °C par décennie, elle retrouve 0,4 (0,32 avec toutes les stations). Ces cas sont dans `tests/etl/test_station_anomalies.py`.

Les anomalies et tendances sont chargées dans les tables `TemperatureAnomalie` et `TemperatureTendance` de `TemperatureDB` (`ProvinceID` à `NULL` = Canada), exposées par l'API (`/api/temperature/anomalies` et `/api/temperature/trends`) et utilisées par la page Températures du frontend.

**Résultats sur 2000-2025** (`temperature_trends.csv`, figure dans `docs/figures/`) :

- Moyenne simple : cinq provinces affichent un refroidissement (Québec −0,74, Ontario −0,20, Manitoba −0,07, Saskatchewan −0,06, Terre-Neuve-et-Labrador −0,02 °C par décennie).
- Anomalies par stations longues : les 13 provinces et territoires se réchauffent, de +0,12 (Nouveau-Brunswick) à +0,62 °C par décennie (Territoires du Nord-Ouest).
- Moyenne des provinces à poids égaux : **+0,35 °C par décennie, intervalle de confiance à 95 % de 0,04 à 0,67**.
- Prises une par une, seules 5 provinces sur 13 ont un intervalle qui exclut zéro (Colombie-Britannique, Nouvelle-Écosse, Territoires du Nord-Ouest, Île-du-Prince-Édouard, Québec) : 26 années, c'est court, et la variabilité d'une année à l'autre est grande.
- Le saut de 2018 au Québec est en partie réel : l'anomalie des stations longues baisse de 0,44 °C cette année-là (0,72 °C avec toutes les stations), contre 1,75 °C pour la moyenne simple. Le reste de la chute vient du réseau.

## Tendance de précipitations

Le même problème de réseau touche les précipitations, en plus pénible : le total mensuel d'une station est une **somme**, donc des jours manquants le sous-estiment. ECCC publie quand même le total : 32 % des relevés ont au moins un jour manquant et 11 % en ont plus de 5. Surtout, la part de relevés avec plus de 5 jours manquants passe de 4,1 % en 2006 à 16,9 % en 2008 (puis 12,7 % en 2025), une rupture de qualité qui tire les totaux non filtrés vers le bas après 2008.

Méthode (`ETL/station_anomalies.py precipitation`) : même principe que pour la température, avec trois différences.

1. Les relevés avec plus de 5 jours manquants sont écartés (`MAX_MISSING_DAYS`).
2. L'anomalie est exprimée en **% de la normale** de la station : 100 × somme des écarts / somme des normales, sur les relevés disponibles. C'est stable pour les mois très secs de l'Arctique et comparable entre une province très humide et une province très sèche, ce que des millimètres ne permettraient pas.
3. Le seuil de 5 jours est un choix : la sensibilité à ce seuil est calculée et enregistrée dans `Data/Processed/Precipitation/precipitation_sensitivity.csv`.

**Validation.** Sur un réseau synthétique à climat stable où des stations très humides ferment, la somme simple invente −347 mm par décennie et l'anomalie en % retrouve 0,0. Avec une hausse connue de 1 % par an (8,9 % par décennie par rapport à la moyenne de la période), elle retrouve 8,9 (6,1 avec toutes les stations). Ces cas sont dans `tests/etl/test_station_anomalies.py`.

Les anomalies et tendances sont chargées dans `PrecipitationAnomalie` et `PrecipitationTendance` de `PrecipitationDB`, exposées par `/api/precipitation/anomalies` et `/api/precipitation/trends`.

**Résultats sur 2000-2025** (`precipitation_trends.csv`, figure `docs/figures/tendances_precipitations.png`) :

- **Cumul simple : une baisse nationale « significative » qui n'existe pas.** Il passe de 792 mm en 2000 à 618 mm en 2025, soit −37,9 mm par décennie (intervalle à 95 % de −59,2 à −16,5). C'est un artefact du réseau.
- **Anomalies par stations longues : aucune tendance détectable.** Canada : **−0,9 % de la normale par décennie, intervalle de −4,4 à +2,5**. Aucune des 12 provinces et territoires évaluables n'a un intervalle qui exclut zéro.
- Selon le seuil de jours manquants (0, 2, 5, 10 jours, ou aucun filtre), la pente nationale varie de −0,1 à −1,6 % par décennie et son intervalle contient toujours zéro.
- **Le Yukon n'a aucune station de longue durée** utilisable : pas de tendance (valeur vide). Le Nunavut en a 3 et les Territoires du Nord-Ouest 5 : leurs résultats sont fragiles.
- Ne pas conclure à une absence de changement : un intervalle de −4,4 à +2,5 % par décennie n'exclut pas des variations de quelques pour cent dans un sens ou dans l'autre.

## Limites connues

- Les intervalles de confiance supposent des années indépendantes ; l'autocorrélation les rend probablement un peu trop optimistes.
- La moyenne nationale donne le même poids à chaque province, sans tenir compte de la superficie.
- Les anomalies sont calculées par rapport à la moyenne de la station sur 2000-2025, pas par rapport à une normale de référence de 30 ans.
- Les données ne sont pas homogénéisées : un déplacement de station ou un changement d'instrument n'est pas corrigé.
- Dans une province, la moyenne est celle des stations, pas une moyenne pondérée par la surface : une province très instrumentée dans sa partie sud est dominée par cette partie.
- Les valeurs « simples » stockées dans les tables `Temperature` et `Precipitation` (moyenne et cumul des stations actives) sont conservées telles quelles : elles décrivent les stations actives chaque année, pas une tendance.
- Les précipitations solides (neige) dépendent du type de pluviomètre ; je n'ai pas évalué ce biais.
