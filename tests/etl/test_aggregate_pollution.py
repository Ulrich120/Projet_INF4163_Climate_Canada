import pandas as pd
import pytest
from aggregate_pollution import PROVINCE_CODES, add_2025_rows, extract_official_data, validate


def row(year, region, secteur=None, value=12000.0):
    return {
        "Année": year,
        "Région": region,
        "Source": "Total",
        "Secteur": secteur,
        "Sous-Secteur": None,
        "Sous-sous-Secteur": None,
        "Total (kt CO2eq)": value,
    }


def make_source():
    rows = [row(year, region) for region in PROVINCE_CODES for year in (2023, 2024)]
    # lignes qui doivent être ignorées : ventilation sectorielle, année hors période, région inconnue
    rows.append(row(2023, "Québec", secteur="Transport", value=999.0))
    rows.append(row(2020, "Québec", value=999.0))
    rows.append(row(2023, "Canada", value=999.0))
    return pd.DataFrame(rows)


def test_extract_keeps_only_provincial_totals_and_converts_to_mt():
    result = extract_official_data(make_source())
    assert len(result) == 26
    assert set(result["Province"]) == set(PROVINCE_CODES.values())
    assert (result["EmissionGES_MtCO2e"] == 12.0).all()


def test_extract_fails_on_missing_column():
    with pytest.raises(ValueError, match="Colonnes manquantes"):
        extract_official_data(make_source().drop(columns=["Source"]))


def test_add_2025_creates_null_rows_and_full_dataset_validates():
    full = add_2025_rows(extract_official_data(make_source()))
    assert len(full) == 39
    assert full[full.Annee == 2025]["EmissionGES_MtCO2e"].isna().all()
    validate(full)


def test_validate_rejects_non_null_2025():
    full = add_2025_rows(extract_official_data(make_source()))
    full.loc[full.Annee == 2025, "EmissionGES_MtCO2e"] = 1.0
    with pytest.raises(ValueError):
        validate(full)
