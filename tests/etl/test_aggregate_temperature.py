import itertools

import pandas as pd
import pytest
from aggregate_temperature import build_annual_dataset, validate_monthly_dataset
from reference import PROVINCE_CODES

YEARS = (2023, 2024, 2025)


def make_monthly(years=YEARS, temp=10.0):
    rows = [
        {"Province": p, "Annee": y, "Mois": m, "TemperatureMoyenne": temp, "NombreStations": 4}
        for p, y, m in itertools.product(PROVINCE_CODES, years, range(1, 13))
    ]
    return pd.DataFrame(rows)


def test_annual_is_mean_of_months():
    monthly = make_monthly()
    qc_2023 = (monthly.Province == "QC") & (monthly.Annee == 2023)
    monthly.loc[qc_2023 & (monthly.Mois <= 6), "TemperatureMoyenne"] = 0.0
    monthly.loc[qc_2023 & (monthly.Mois > 6), "TemperatureMoyenne"] = 20.0

    annual = build_annual_dataset(monthly)
    qc = annual[(annual.Province == "QC") & (annual.Annee == 2023)].iloc[0]
    assert qc.TemperatureMoyenne == pytest.approx(10.0)
    assert qc.MoisDisponibles == 12
    assert len(annual) == 13 * len(YEARS)


def test_annual_is_empty_when_a_month_is_missing():
    monthly = make_monthly()
    target = (monthly.Province == "NU") & (monthly.Annee == 2024) & (monthly.Mois == 3)
    monthly.loc[target, "TemperatureMoyenne"] = None

    annual = build_annual_dataset(monthly)
    nu = annual[(annual.Province == "NU") & (annual.Annee == 2024)].iloc[0]
    assert pd.isna(nu.TemperatureMoyenne)
    assert nu.MoisDisponibles == 11
    assert annual.TemperatureMoyenne.notna().sum() == len(annual) - 1


def test_validate_accepts_complete_dataset():
    validate_monthly_dataset(make_monthly(), years=YEARS)


def test_validate_scales_with_year_range():
    years = tuple(range(2000, 2026))
    validate_monthly_dataset(make_monthly(years=years), years=years)


def test_validate_rejects_missing_rows():
    with pytest.raises(ValueError, match="Nombre de lignes"):
        validate_monthly_dataset(make_monthly().iloc[:-1], years=YEARS)


def test_validate_rejects_duplicates():
    monthly = make_monthly()
    monthly.iloc[0] = monthly.iloc[1]
    with pytest.raises(ValueError, match="Doublons"):
        validate_monthly_dataset(monthly, years=YEARS)
