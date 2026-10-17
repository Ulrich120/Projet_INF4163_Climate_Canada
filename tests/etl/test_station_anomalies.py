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


# ---------------------------------------------------------------------------
# Précipitations : anomalies en % de la normale
# ---------------------------------------------------------------------------


def make_precipitation_network(growth_per_year=0.0, seed=0):
    """10 stations sèches actives toute la période, 10 stations très humides qui ferment en 2012.
    Le climat est stable (ou les précipitations augmentent de `growth_per_year` par an, en relatif)."""
    rng = np.random.default_rng(seed)
    rows = []
    for station in range(20):
        wet = station >= 10
        base = 120.0 if wet else 20.0
        last_year = 2012 if wet else 2025
        for year in YEARS:
            if year > last_year:
                continue
            for month in range(1, 13):
                seasonal = 1 + 0.5 * np.cos((month - 7) * np.pi / 6)
                value = base * seasonal * (1 + growth_per_year * (year - 2000)) * rng.normal(1, 0.02)
                rows.append({"ID_Clim": f"P{station}", "Province": "QC", "Annee": year, "Mois": month,
                             "P": value, "JsP": 0.0})
    return pd.DataFrame(rows)


def precipitation_slope(table, column):
    from station_anomalies import PRECIPITATION, compute

    annual, _ = compute(table, PRECIPITATION)
    province = annual[annual["Province"] == "QC"]
    return slope_per_decade(province, column)


def test_precipitation_naive_sum_invents_a_drying_when_wet_stations_close():
    naive = naive_annual(make_precipitation_network(), value="P", annual="sum")
    assert slope_per_decade(naive, "Valeur") < -200  # mm par décennie, climat pourtant stable


def test_precipitation_percent_anomaly_recovers_a_stable_climate():
    assert abs(precipitation_slope(make_precipitation_network(), "AnomalieStationsLongues")) < 1.0


def test_precipitation_percent_anomaly_recovers_a_known_growth():
    # +1 %/an du niveau de départ ; relatif à la moyenne de la période (1,125 x départ) : 8,9 %/décennie
    slope = precipitation_slope(make_precipitation_network(growth_per_year=0.01), "AnomalieStationsLongues")
    assert slope == pytest.approx(8.89, abs=0.7)


def test_percent_aggregation_is_sum_of_gaps_over_sum_of_normals():
    from station_anomalies import province_year_anomaly as aggregate

    rows = []
    for month in range(1, 13):
        rows.append({"Province": "QC", "Annee": 2020, "Mois": month, "ID_Clim": "A", "Base": 10.0, "Anomalie": 2.0})
        rows.append({"Province": "QC", "Annee": 2020, "Mois": month, "ID_Clim": "B", "Base": 30.0, "Anomalie": -3.0})
    result = aggregate(pd.DataFrame(rows), kind="percent")
    assert result.loc[0, "Anomalie"] == pytest.approx(100 * (2 - 3) / 40)  # -2,5 %
    assert result.loc[0, "NbMois"] == 12


def test_stations_with_too_many_missing_days_are_dropped():
    from station_anomalies import drop_incomplete_days

    table = pd.DataFrame({"P": [10.0, 10.0, 10.0, 10.0], "JsP": [0.0, 5.0, 6.0, np.nan]})
    assert list(drop_incomplete_days(table, 5)["JsP"]) == [0.0, 5.0]
    assert len(drop_incomplete_days(table, None)) == 4


def test_naive_sum_needs_twelve_months():
    rows = [{"Province": "QC", "Annee": 2020, "Mois": m, "P": 50.0} for m in range(1, 13)]
    full = pd.DataFrame(rows)
    assert naive_annual(full, value="P", annual="sum")["Valeur"].iloc[0] == pytest.approx(600.0)
    assert np.isnan(naive_annual(full.iloc[:-1], value="P", annual="sum")["Valeur"].iloc[0])
