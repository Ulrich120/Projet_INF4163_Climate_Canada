import itertools

import pandas as pd
import pytest
from aggregate_temperature import build_annual_dataset, validate_monthly_dataset

PROVINCES = ["NL", "PE", "NS", "NB", "QC", "ON", "MB", "SK", "AB", "BC", "YT", "NT", "NU"]


def make_monthly(years=(2023, 2024, 2025), temp=10.0):
    rows = [
        {"Province": p, "Annee": y, "Mois": m, "TemperatureMoyenne": temp, "NombreStations": 4}
        for p, y, m in itertools.product(PROVINCES, years, range(1, 13))
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
    assert len(annual) == 39


def test_validate_accepts_complete_dataset():
    validate_monthly_dataset(make_monthly())


def test_validate_rejects_missing_rows():
    with pytest.raises(ValueError, match="Nombre de lignes"):
        validate_monthly_dataset(make_monthly().iloc[:-1])


def test_validate_rejects_duplicates():
    monthly = make_monthly()
    monthly.iloc[0] = monthly.iloc[1]
    with pytest.raises(ValueError, match="Doublons"):
        validate_monthly_dataset(monthly)
