"""Tendances par province à partir des anomalies de chaque station.

Pourquoi : la moyenne des stations actives une année donnée change quand le réseau change
(stations qui ferment ou ouvrent), même si le climat est stable. On compare donc chaque
station à sa propre moyenne pour le même mois, puis on agrège ces écarts.

Méthode
1. baseline(station, mois) = moyenne de la station pour ce mois sur toute la période,
   calculée seulement si la station a au moins `MIN_BASELINE_YEARS` années pour ce mois.
2. anomalie = valeur - baseline (température, en °C).
3. anomalie province-mois = moyenne des anomalies des stations, puis anomalie annuelle =
   moyenne des mois, calculée seulement si au moins `MIN_MONTHS` mois sont disponibles.
4. Variante « stations longues » : on ne garde que les stations présentes au moins
   `LONG_RECORD_YEARS` années (réduit le biais lié aux arrivées/départs de stations).
5. Tendance : régression linéaire des anomalies annuelles sur l'année, avec intervalle à 95 %.
"""

import numpy as np
import pandas as pd
from config import INTERIM_DIR, PROCESSED_DIR
from scipy import stats

STATIONS_FILE = INTERIM_DIR / "stations_monthly.csv.gz"
OUTPUT_DIR = PROCESSED_DIR / "Temperature"
ANOMALY_OUTPUT = OUTPUT_DIR / "temperature_anomaly_annual.csv"
TREND_OUTPUT = OUTPUT_DIR / "temperature_trends.csv"

MIN_BASELINE_YEARS = 10
MIN_MONTHS = 10
LONG_RECORD_YEARS = 20
NATIONAL = "CANADA"


def add_anomalies(table, value="Tm", min_baseline_years=MIN_BASELINE_YEARS):
    """Ajoute la colonne `Anomalie` (écart à la moyenne de la station pour le même mois)."""
    data = table.dropna(subset=[value]).copy()

    baseline = data.groupby(["ID_Clim", "Mois"])[value].agg(Base="mean", NbAnnees="count")
    baseline = baseline[baseline["NbAnnees"] >= min_baseline_years]

    data = data.join(baseline, on=["ID_Clim", "Mois"], how="inner")
    data["Anomalie"] = data[value] - data["Base"]
    return data.drop(columns=["Base", "NbAnnees"])


def long_record_stations(table, value="Tm", min_years=LONG_RECORD_YEARS, min_months=MIN_MONTHS):
    """Identifiants des stations avec au moins `min_years` années d'au moins `min_months` mois."""
    months = table.dropna(subset=[value]).groupby(["ID_Clim", "Annee"])["Mois"].nunique()
    years = (months >= min_months).groupby("ID_Clim").sum()
    return set(years[years >= min_years].index)


def province_year_anomaly(anomalies, min_months=MIN_MONTHS):
    """Anomalie annuelle par province : moyenne des stations par mois, puis des mois."""
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
    return annual


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


def naive_annual(table, value="Tm"):
    """Moyenne simple des stations actives (la méthode de `aggregate_temperature.py`)."""
    monthly = table.groupby(["Province", "Annee", "Mois"])[value].mean().reset_index()
    annual = monthly.groupby(["Province", "Annee"]).agg(Valeur=(value, "mean"), NbMois=("Mois", "nunique")).reset_index()
    annual.loc[annual["NbMois"] < 12, "Valeur"] = np.nan
    return annual


def national_average(annual):
    """Moyenne des provinces (poids égaux, pas pondérée par la superficie) pour chaque année."""
    columns = ["AnomalieToutesStations", "AnomalieStationsLongues", "MoyenneSimple"]
    national = annual.groupby("Annee")[columns].mean().reset_index()
    national["Province"] = NATIONAL
    return national


def compute(table):
    """Retourne (anomalies annuelles par province, tendances par province et méthode)."""
    anomalies = add_anomalies(table)
    all_stations = province_year_anomaly(anomalies).rename(columns={"Anomalie": "AnomalieToutesStations"})

    long_ids = long_record_stations(table)
    long_stations = province_year_anomaly(anomalies[anomalies["ID_Clim"].isin(long_ids)])
    long_stations = long_stations.rename(
        columns={"Anomalie": "AnomalieStationsLongues", "NbStations": "NbStationsLongues", "NbMois": "NbMoisLongues"}
    )

    annual = all_stations.merge(long_stations, on=["Province", "Annee"], how="outer")
    naive = naive_annual(table).rename(columns={"Valeur": "MoyenneSimple"})[["Province", "Annee", "MoyenneSimple"]]
    annual = annual.merge(naive, on=["Province", "Annee"], how="outer")
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


def main():
    table = pd.read_csv(STATIONS_FILE, dtype={"ID_Clim": "string"})
    annual, trends = compute(table)

    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    annual.round(3).to_csv(ANOMALY_OUTPUT, index=False, encoding="utf-8-sig")
    trends.round(4).to_csv(TREND_OUTPUT, index=False, encoding="utf-8-sig")

    pivot = trends.pivot(index="Province", columns="Methode", values="PenteParDecennie").round(2)
    print("Pente (°C par décennie), 2000-2025")
    print(pivot.to_string())
    print(f"\n{ANOMALY_OUTPUT}\n{TREND_OUTPUT}")


if __name__ == "__main__":
    main()
