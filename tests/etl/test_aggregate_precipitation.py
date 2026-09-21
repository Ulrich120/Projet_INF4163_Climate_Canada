import itertools

import pandas as pd
import pytest
from aggregate_precipitation import build_annual_dataset, validate_annual_dataset
from reference import PROVINCE_CODES

YEARS = (2023, 2024)


def make_monthly(value=50.0):
    rows = [
        {"Province": p, "Annee": y, "Mois": m, "PrecipitationMoyenne": value, "NombreStations": 3}
        for p, y, m in itertools.product(PROVINCE_CODES, YEARS, range(1, 13))
    ]
    return pd.DataFrame(rows)


def test_annual_is_sum_of_months():
    annual = build_annual_dataset(make_monthly())
    assert (annual.PrecipitationAnnuelle == 600.0).all()
    assert len(annual) == 13 * len(YEARS)


def test_annual_is_empty_when_a_month_is_missing():
    monthly = make_monthly()
    target = (monthly.Province == "QC") & (monthly.Annee == 2023) & (monthly.Mois == 5)
    monthly.loc[target, "PrecipitationMoyenne"] = None

    annual = build_annual_dataset(monthly)
    qc = annual[(annual.Province == "QC") & (annual.Annee == 2023)].iloc[0]
    assert pd.isna(qc.PrecipitationAnnuelle)
    assert qc.MoisDisponibles == 11


def test_validate_annual_checks_row_count():
    annual = build_annual_dataset(make_monthly())
    validate_annual_dataset(annual, years=YEARS)
    with pytest.raises(ValueError, match="lignes attendues"):
        validate_annual_dataset(annual.iloc[:-1], years=YEARS)
