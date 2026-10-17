"""Tendances par province à partir des anomalies de chaque station (température et précipitations).

Pourquoi : la moyenne des stations actives une année donnée change quand le réseau change
(stations qui ferment ou ouvrent), même si le climat est stable. On compare donc chaque
station à sa propre moyenne pour le même mois, puis on agrège ces écarts.

Méthode
1. baseline(station, mois) = moyenne de la station pour ce mois sur toute la période,
   calculée seulement si la station a au moins `MIN_BASELINE_YEARS` années pour ce mois.
2. anomalie = valeur - baseline.
3. agrégation par province et par année, seulement si au moins `MIN_MONTHS` mois sont disponibles :
   - température : moyenne des écarts (°C) ;
   - précipitations : somme des écarts / somme des normales des stations (en % de la normale),
     ce qui reste stable pour des mois très secs et compare des provinces très inégalement arrosées.
4. Variante « stations longues » : on ne garde que les stations présentes au moins
   `LONG_RECORD_YEARS` années (réduit le biais lié aux arrivées/départs de stations).
5. Précipitations : un total mensuel avec trop de jours manquants (`JsP`) est sous-estimé,
   on écarte ces relevés (seuil `MAX_MISSING_DAYS`, sensibilité testée dans `sensitivity`).
6. Tendance : régression linéaire des anomalies annuelles sur l'année, avec intervalle à 95 %.

Usage : python ETL/station_anomalies.py [temperature|precipitation]   (sans argument : les deux)
"""

import sys
from dataclasses import dataclass, replace
from pathlib import Path

import numpy as np
import pandas as pd
from config import INTERIM_DIR, PROCESSED_DIR
from scipy import stats

STATIONS_FILE = INTERIM_DIR / "stations_monthly.csv.gz"

MIN_BASELINE_YEARS = 10
MIN_MONTHS = 10
LONG_RECORD_YEARS = 20
MAX_MISSING_DAYS = 5
NATIONAL = "CANADA"


@dataclass(frozen=True)
class Variable:
    name: str
    column: str  # colonne de la table de stations
    kind: str  # "difference" (écart, même unité) ou "percent" (% de la normale)
    annual: str  # "mean" (moyenne des mois) ou "sum" (cumul sur les mois)
    unit: str
    folder: str
    max_missing_days: int | None = None  # relevés écartés au-delà (colonne JsP)

    @property
    def anomaly_file(self):
        return PROCESSED_DIR / self.folder / f"{self.name}_anomaly_annual.csv"

    @property
    def trend_file(self):
        return PROCESSED_DIR / self.folder / f"{self.name}_trends.csv"


TEMPERATURE = Variable("temperature", "Tm", "difference", "mean", "°C", "Temperature")
PRECIPITATION = Variable("precipitation", "P", "percent", "sum", "% de la normale", "Precipitation",
                         max_missing_days=MAX_MISSING_DAYS)
VARIABLES = {"temperature": TEMPERATURE, "precipitation": PRECIPITATION}


def add_anomalies(table, value="Tm", min_baseline_years=MIN_BASELINE_YEARS):
    """Ajoute `Base` (moyenne de la station pour ce mois) et `Anomalie` (valeur - Base)."""
    data = table.dropna(subset=[value]).copy()

    baseline = data.groupby(["ID_Clim", "Mois"])[value].agg(Base="mean", NbAnnees="count")
    baseline = baseline[baseline["NbAnnees"] >= min_baseline_years]

    data = data.join(baseline, on=["ID_Clim", "Mois"], how="inner")
    data["Anomalie"] = data[value] - data["Base"]
    return data.drop(columns=["NbAnnees"])


def long_record_stations(table, value="Tm", min_years=LONG_RECORD_YEARS, min_months=MIN_MONTHS):
    """Identifiants des stations avec au moins `min_years` années d'au moins `min_months` mois."""
    months = table.dropna(subset=[value]).groupby(["ID_Clim", "Annee"])["Mois"].nunique()
    years = (months >= min_months).groupby("ID_Clim").sum()
    return set(years[years >= min_years].index)


def province_year_anomaly(anomalies, min_months=MIN_MONTHS, kind="difference"):
    """Anomalie annuelle par province.

    "difference" : moyenne des stations par mois, puis des mois (même unité que la mesure).
    "percent"    : 100 x somme des écarts / somme des normales (relevés disponibles de l'année).
    """
    if kind == "percent":
        monthly = (
            anomalies.groupby(["Province", "Annee", "Mois"])
            .agg(Ecart=("Anomalie", "sum"), Normale=("Base", "sum"), NbStations=("ID_Clim", "nunique"))
            .reset_index()
        )
        annual = (
            monthly.groupby(["Province", "Annee"])
            .agg(Ecart=("Ecart", "sum"), Normale=("Normale", "sum"), NbMois=("Mois", "nunique"),
                 NbStations=("NbStations", "mean"))
            .reset_index()
        )
        annual["Anomalie"] = 100 * annual["Ecart"] / annual["Normale"]
        annual = annual.drop(columns=["Ecart", "Normale"])
    else:
        monthly = (
            anomalies.groupby(["Province", "Annee", "Mois"])
            .agg(Anomalie=("Anomalie", "mean"), NbStations=("ID_Clim", "nunique"))
            .reset_index()
        )
        annual = (
            monthly.groupby(["Province", "Annee"])
            .agg(Anomalie=("Anomalie", "mean"), NbMois=("Mois", "nunique"), NbStations=("NbStations", "mean"))
            .reset_index()
        )
    annual.loc[annual["NbMois"] < min_months, "Anomalie"] = np.nan
    return annual[["Province", "Annee", "Anomalie", "NbMois", "NbStations"]]


def linear_trend(years, values, confidence=0.95):
    """Pente par décennie (OLS) avec intervalle de confiance et p-value."""
    years = np.asarray(years, dtype=float)
    values = np.asarray(values, dtype=float)
    mask = ~np.isnan(values)
    years, values = years[mask], values[mask]

    n = len(years)
    if n < 8 or np.ptp(years) < 7:
        return {"PenteParDecennie": np.nan, "IC95_Bas": np.nan, "IC95_Haut": np.nan, "PValeur": np.nan, "NbAnnees": n}

    fit = stats.linregress(years, values)
    margin = stats.t.ppf((1 + confidence) / 2, n - 2) * fit.stderr
    return {
        "PenteParDecennie": fit.slope * 10,
        "IC95_Bas": (fit.slope - margin) * 10,
        "IC95_Haut": (fit.slope + margin) * 10,
        "PValeur": fit.pvalue,
        "NbAnnees": n,
    }


def naive_annual(table, value="Tm", annual="mean"):
    """Valeur annuelle simple des stations actives (la méthode de `aggregate_*.py`)."""
    monthly = table.groupby(["Province", "Annee", "Mois"])[value].mean().reset_index()
    aggregate = "sum" if annual == "sum" else "mean"
    result = monthly.groupby(["Province", "Annee"]).agg(Valeur=(value, aggregate), NbMois=("Mois", "nunique")).reset_index()
    result.loc[result["NbMois"] < 12, "Valeur"] = np.nan
    return result


def national_average(annual):
    """Moyenne des provinces (poids égaux, pas pondérée par la superficie) pour chaque année."""
    columns = ["AnomalieToutesStations", "AnomalieStationsLongues", "MoyenneSimple"]
    national = annual.groupby("Annee")[columns].mean().reset_index()
    national["Province"] = NATIONAL
    return national


def drop_incomplete_days(table, max_missing_days):
    """Écarte les relevés dont le total mensuel manque de trop de jours (JsP inconnu = écarté)."""
    if max_missing_days is None:
        return table
    return table[table["JsP"] <= max_missing_days]


def compute(table, variable=TEMPERATURE):
    """Retourne (anomalies annuelles par province, tendances par province et méthode)."""
    value = variable.column
    usable = drop_incomplete_days(table, variable.max_missing_days)

    anomalies = add_anomalies(usable, value)
    all_stations = province_year_anomaly(anomalies, kind=variable.kind)
    all_stations = all_stations.rename(columns={"Anomalie": "AnomalieToutesStations"})

    long_ids = long_record_stations(usable, value)
    long_stations = province_year_anomaly(anomalies[anomalies["ID_Clim"].isin(long_ids)], kind=variable.kind)
    long_stations = long_stations.rename(
        columns={"Anomalie": "AnomalieStationsLongues", "NbStations": "NbStationsLongues", "NbMois": "NbMoisLongues"}
    )

    annual = all_stations.merge(long_stations, on=["Province", "Annee"], how="outer")
    # la valeur simple publiée dans la base utilise tous les relevés : on la compare telle quelle
    naive = naive_annual(table, value, variable.annual).rename(columns={"Valeur": "MoyenneSimple"})
    annual = annual.merge(naive[["Province", "Annee", "MoyenneSimple"]], on=["Province", "Annee"], how="outer")
    annual = pd.concat([annual, national_average(annual)], ignore_index=True)
    annual = annual.sort_values(["Province", "Annee"])

    rows = []
    for province, group in annual.groupby("Province"):
        for method, column in [
            ("moyenne_simple", "MoyenneSimple"),
            ("anomalie_toutes_stations", "AnomalieToutesStations"),
            ("anomalie_stations_longues", "AnomalieStationsLongues"),
        ]:
            rows.append({"Province": province, "Methode": method, **linear_trend(group["Annee"], group[column])})

    return annual.reset_index(drop=True), pd.DataFrame(rows)


def sensitivity(table, variable, thresholds):
    """Tendance nationale (stations longues) selon le seuil de jours manquants toléré."""
    rows = []
    for threshold in thresholds:
        kept = drop_incomplete_days(table.dropna(subset=[variable.column]), threshold)
        _, trends = compute(table, replace(variable, max_missing_days=threshold))
        national = trends[(trends["Province"] == NATIONAL) & (trends["Methode"] == "anomalie_stations_longues")].iloc[0]
        provinces = trends[(trends["Province"] != NATIONAL) & (trends["Methode"] == "anomalie_stations_longues")]
        rows.append({
            "SeuilJoursManquants": "aucun" if threshold is None else threshold,
            "ReleveConserves": len(kept),
            "PenteCanada": national["PenteParDecennie"],
            "IC95_Bas": national["IC95_Bas"],
            "IC95_Haut": national["IC95_Haut"],
            "ProvincesPositives": int((provinces["PenteParDecennie"] > 0).sum()),
        })
    return pd.DataFrame(rows)


def run(variable, table):
    annual, trends = compute(table, variable)

    out_dir = Path(variable.anomaly_file).parent
    out_dir.mkdir(parents=True, exist_ok=True)
    annual.round(3).to_csv(variable.anomaly_file, index=False, encoding="utf-8-sig")
    trends.round(4).to_csv(variable.trend_file, index=False, encoding="utf-8-sig")

    pivot = trends.pivot(index="Province", columns="Methode", values="PenteParDecennie").round(2)
    print(f"{variable.name} : pente par décennie ({variable.unit}), 2000-2025")
    print(pivot.to_string())
    print(f"\n{variable.anomaly_file}\n{variable.trend_file}\n")

    if variable.max_missing_days is not None:
        result = sensitivity(table, variable, [0, 2, 5, 10, None])
        result_file = out_dir / f"{variable.name}_sensitivity.csv"
        result.round(3).to_csv(result_file, index=False, encoding="utf-8-sig")
        print("Sensibilité au seuil de jours manquants (pente nationale, stations longues)")
        print(result.round(2).to_string(index=False))
        print(result_file)


def main():
    names = sys.argv[1:] or list(VARIABLES)
    table = pd.read_csv(STATIONS_FILE, dtype={"ID_Clim": "string"})
    for name in names:
        run(VARIABLES[name], table)


if __name__ == "__main__":
    main()
