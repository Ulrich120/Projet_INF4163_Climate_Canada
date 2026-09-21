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

## Limites connues

**Le réseau de stations change au fil du temps.** Le nombre de stations qui rapportent une mesure passe d'environ 1 780 en 2000 à environ 1 000 en 2025 pour l'ensemble du pays. Au Québec, il tombe de ~194 à ~127 stations entre 2017 et 2018, et la température annuelle moyenne baisse de 1,75 °C la même année. Cette coïncidence indique un effet de composition du réseau plutôt qu'un signal climatique (hypothèse à confirmer à l'étape suivante).

Conséquence : **les moyennes de température par province ne doivent pas être lues comme une tendance climatique** (par exemple, le Québec affiche −1,4 °C entre 2000 et 2025). Elles décrivent la moyenne des stations actives cette année-là. Une analyse de tendance rigoureuse demande de suivre les mêmes stations dans le temps (anomalies par station par rapport à leur propre normale), ce qui est prévu à l'étape suivante du projet.

Autres limites :

- la moyenne est celle des stations, pas une moyenne pondérée par la surface : une province très instrumentée dans sa partie sud est dominée par cette partie.
