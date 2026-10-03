import numpy as np
import pandas as pd
import pytest
from station_anomalies import (
    add_anomalies,
    linear_trend,
    long_record_stations,
    naive_annual,
    province_year_anomaly,
)

YEARS = range(2000, 2026)


def make_network(warming_per_year=0.0, seed=0):
    """Réseau synthétique : 10 stations froides actives toute la période, 10 stations chaudes
    qui ferment en 2012. Le climat est stable (ou se réchauffe de `warming_per_year`)."""
    rng = np.random.default_rng(seed)
    rows = []
    for station in range(20):
        warm = station >= 10
        base = 12.0 if warm else -6.0
        last_year = 2012 if warm else 2025
        for year in YEARS:
            if year > last_year:
                continue
            for month in range(1, 13):
                seasonal = 10 * np.cos((month - 7) * np.pi / 6)
                value = base + seasonal + warming_per_year * (year - 2000) + rng.normal(0, 0.3)
                rows.append({"ID_Clim": f"S{station}", "Province": "QC", "Annee": year, "Mois": month, "Tm": value})
    return pd.DataFrame(rows)


def slope_per_decade(frame, column):
    return linear_trend(frame["Annee"], frame[column])["PenteParDecennie"]


def test_naive_mean_invents_a_cooling_when_warm_stations_close():
    naive = naive_annual(make_network())
    assert slope_per_decade(naive, "Valeur") < -2.0  # artefact : le climat est stable


def test_station_anomalies_recover_a_stable_climate():
    annual = province_year_anomaly(add_anomalies(make_network()))
    assert abs(slope_per_decade(annual, "Anomalie")) < 0.15


def test_long_record_variant_recovers_a_real_warming():
    table = make_network(warming_per_year=0.04)  # 0,4 °C par décennie
    keep = long_record_stations(table)
    assert keep == {f"S{i}" for i in range(10)}  # seules les stations froides couvrent 20 ans

    annual = province_year_anomaly(add_anomalies(table[table["ID_Clim"].isin(keep)]))
    assert slope_per_decade(annual, "Anomalie") == pytest.approx(0.4, abs=0.05)


def test_baseline_needs_enough_years():
    table = make_network()
    short = table[(table["ID_Clim"] == "S0") & (table["Annee"] < 2005)]
    others = table[table["ID_Clim"] != "S0"]
    anomalies = add_anomalies(pd.concat([short, others]), min_baseline_years=10)
    assert "S0" not in set(anomalies["ID_Clim"])


def test_year_with_too_few_months_has_no_anomaly():
    table = make_network()
    table = table[~((table["Annee"] == 2020) & (table["Mois"] > 6))]
    annual = province_year_anomaly(add_anomalies(table), min_months=10)
    assert annual.loc[annual["Annee"] == 2020, "Anomalie"].isna().all()
    assert annual["Anomalie"].notna().sum() == len(YEARS) - 1


def test_linear_trend_known_slope_and_confidence_interval():
    years = np.arange(2000, 2026)
    result = linear_trend(years, 0.03 * (years - 2000))
    assert result["PenteParDecennie"] == pytest.approx(0.3)
    assert result["IC95_Bas"] <= 0.3 <= result["IC95_Haut"]
    assert result["NbAnnees"] == 26


def test_linear_trend_refuses_short_series():
    assert np.isnan(linear_trend([2000, 2001, 2002], [1.0, 2.0, 3.0])["PenteParDecennie"])
