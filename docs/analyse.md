# Analyse : le climat et les émissions du Canada, 2000-2025

Ce document lit les résultats du projet comme le ferait un analyste : une question, ce que les données permettent de dire, ce qu'elles ne permettent pas, et ce que je ferais ensuite. Les méthodes détaillées et les validations sont dans [`Data/README.md`](../Data/README.md).

## Résumé

1. **Le Canada se réchauffe, mais l'incertitude est grande.** +0,35 °C par décennie (intervalle à 95 % : de +0,04 à +0,67). Les 13 provinces et territoires vont dans le même sens, mais seules 5 ont un intervalle qui exclut zéro.
2. **Aucune tendance de précipitations n'est détectable.** −0,9 % de la normale par décennie (de −4,4 à +2,5). Ce n'est pas la preuve d'une absence de changement : l'intervalle reste trop large pour trancher.
3. **Les émissions de GES ont baissé de 10 % depuis 2005** (763,0 → 684,7 Mt CO₂e), mais **85 % de cette baisse vient d'un seul secteur, l'électricité** (−66,3 Mt). Sans l'électricité, les émissions ne baissent que de 1,9 %.
4. **Deux pièges de mesure** ont failli produire de fausses conclusions : la moyenne simple des stations (faux refroidissement) et la somme simple des précipitations (fausse baisse).

## 1. Température : une moyenne qui ne mesure pas ce qu'on croit

**Constat.** La moyenne annuelle des stations donne un refroidissement de 0,74 °C par décennie au Québec. Le même réseau, suivi station par station, se réchauffe de 0,44 °C.

**Explication.** Le nombre de stations qui rapportent passe d'environ 1 780 en 2000 à environ 1 000 en 2025. Quand des stations ferment, la moyenne change de composition, pas de climat. La méthode retenue compare chaque station à sa propre moyenne pour le même mois, puis agrège ces écarts.

**Comment je sais que la méthode est bonne.** Sur un réseau synthétique à climat stable où des stations chaudes ferment, la moyenne simple invente −5,2 °C par décennie et la méthode retrouve 0,0. Avec un réchauffement connu de 0,4, elle retrouve 0,4. Ces cas sont des tests automatiques.

**Ce qu'on peut affirmer.** Le sens du signal est cohérent partout (13 sur 13) et la moyenne nationale exclut zéro de peu (de +0,04 à +0,67).

**Ce qu'on ne peut pas affirmer.** Un classement précis des provinces : leurs intervalles se chevauchent largement. Vingt-six ans de données, c'est court devant la variabilité d'une année à l'autre.

## 2. Précipitations : un artefact de qualité des données

**Constat.** Le cumul simple affiche une baisse nationale « significative » : −38 mm par décennie, de 792 à 618 mm.

**Explication.** La part de relevés auxquels il manque plus de 5 jours de mesure passe de 4,1 % en 2006 à 16,9 % en 2008. Un total mensuel est une somme : des jours manquants le sous-estiment. La baisse apparente suit cette rupture de qualité, pas le climat.

**Après correction** (relevés trop incomplets écartés, anomalie en % de la normale de chaque station) : −0,9 % par décennie, intervalle de −4,4 à +2,5, aucune province significative. Le résultat tient pour des seuils de 0, 2, 5 et 10 jours manquants (de −0,1 à −1,6 %, zéro toujours dans l'intervalle).

**Réserve.** « Pas de tendance détectable » n'est pas « pas de changement ». Le Yukon n'a aucune station de longue durée utilisable, le Nunavut en a 3 et les Territoires du Nord-Ouest 5 : leurs résultats sont fragiles.

## 3. Émissions de GES : d'où vient la baisse ?

![Émissions nationales par secteur](figures/ges_secteurs.png)

*Reproductible avec `python ETL/analyze_ges.py`.*

**Vérification préalable.** Le total national de l'inventaire est égal à la somme des 13 provinces et territoires, à l'arrondi près (écart maximal de 0,018 Mt sur 25 années). Les secteurs s'additionnent aussi au total. Ces contrôles sont des tests automatiques.

**Décomposition 2005 → 2024** (Mt CO₂e) :

| Secteur | 2005 | 2024 | Variation | Part de la variation nationale |
|---|---:|---:|---:|---:|
| Électricité | 115,9 | 49,6 | −66,3 (−57 %) | 85 % |
| Industrie lourde | 88,6 | 77,5 | −11,1 | 14 % |
| Industrie légère et construction | 27,4 | 22,1 | −5,3 | 7 % |
| Transports | 156,2 | 151,4 | −4,8 | 6 % |
| Bâtiments | 84,7 | 81,4 | −3,3 | 4 % |
| Déchets, charbon | 26,4 | 25,4 | −1,0 | 1 % |
| Agriculture | 66,2 | 69,8 | +3,6 | −5 % |
| Pétrole et gaz | 197,6 | 207,6 | +10,0 | −13 % |
| **Total** | **763,0** | **684,7** | **−78,3 (−10,3 %)** | 100 % |

**Lecture.**

- **Une baisse concentrée.** Sans l'électricité, les émissions passent de 647,1 à 635,1 Mt (−1,9 %). Le plus gros secteur émetteur, le pétrole et le gaz, a augmenté de 5 %.
- **Où l'électricité a baissé** : Alberta (−30,3 Mt) et Ontario (−24,0 Mt), soit 82 % de la baisse du secteur. En Ontario, les émissions du secteur passent de 26,8 Mt en 2008 à 5,4 Mt en 2014, un profil cohérent avec la fin de la production d'électricité au charbon. Cette explication vient de connaissances extérieures : le jeu de données montre la baisse, pas sa cause.
- **L'Alberta cache deux histoires.** Ses émissions totales augmentent de 9,0 Mt depuis 2005, alors que son électricité baisse de 30,3 Mt : le reste de son économie a donc augmenté d'environ 39 Mt. Sa part du total national passe de 31,5 % en 2000 à 38,0 % en 2024.
- **L'effet de 2020.** Les émissions chutent de 67,1 Mt (−9,0 %) entre 2019 et 2020, puis ne remontent que de 3,8 Mt jusqu'en 2024 (+0,6 %). 2024 reste 8,5 % sous 2019 : un rebond complet n'a pas eu lieu. Les plus fortes baisses 2019 → 2024 sont les transports (−17,4 Mt), le pétrole et gaz (−15,2 Mt), les bâtiments (−12,5 Mt) et l'électricité (−12,0 Mt). Le jeu de données ne permet pas de dire quelle part est durable.
- **Concentration.** L'Alberta, l'Ontario et le Québec représentent 72 % des émissions de 2024.

**Piège évité dans l'interface.** Le graphique « moyenne par année » affichait une moyenne par province (~55 Mt), qu'on pouvait confondre avec un total national (~700 Mt). Le libellé le dit maintenant.

## 4. Limites

- Les intervalles de confiance supposent des années indépendantes ; l'autocorrélation les rend probablement un peu trop étroits.
- Les moyennes nationales donnent le même poids à chaque province, quelle que soit sa superficie.
- Les anomalies sont calculées par rapport à la moyenne de la station sur 2000-2025, pas à une normale de 30 ans.
- Les stations ne sont pas homogénéisées (déplacements, changements d'instruments).
- Une droite est un mauvais résumé des GES : la série est faite de paliers (fermetures de centrales, 2020), pas d'une pente régulière. J'ai donc préféré la décomposition par secteur à une pente.
- Aucune causalité n'est testée entre climat et émissions : ce sont deux analyses parallèles sur la même période.

## 5. Ce que je ferais ensuite

1. **Ramener les émissions à la population et au PIB** (intensité par habitant et par dollar) pour comparer l'Alberta et le Québec équitablement. Cela demande des données de Statistique Canada.
2. **Descendre au sous-secteur** pour l'Alberta, là où se cache la hausse (le fichier ECCC contient déjà ce niveau de détail).
3. **Remplacer la tendance linéaire de température par une normale de 30 ans** (1991-2020) comme référence, et tester l'autocorrélation des résidus.
4. **Comparer avec les moyennes homogénéisées d'ECCC** (températures ajustées) pour mesurer ce que la correction des stations ne couvre pas.
