import pandas as pd
import pytest
from aggregate_pollution import PROVINCE_CODES, add_missing_rows, extract_official_data, validate

YEARS = (2023, 2024, 2025)


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


def make_full():
    return add_missing_rows(extract_official_data(make_source(), years=YEARS), years=YEARS)


def test_extract_keeps_only_provincial_totals_and_converts_to_mt():
    result = extract_official_data(make_source(), years=YEARS)
    assert len(result) == 26
    assert set(result["Province"]) == set(PROVINCE_CODES.values())
    assert (result["EmissionGES_MtCO2e"] == 12.0).all()


def test_extract_fails_on_missing_column():
    with pytest.raises(ValueError, match="Colonnes manquantes"):
        extract_official_data(make_source().drop(columns=["Source"]), years=YEARS)


def test_unpublished_year_becomes_null_rows_and_dataset_validates():
    full = make_full()
    assert len(full) == 39
    assert full[full.Annee == 2025]["EmissionGES_MtCO2e"].isna().all()
    validate(full, years=YEARS)


def test_add_missing_rows_is_idempotent():
    assert len(add_missing_rows(make_full(), years=YEARS)) == 39


def test_validate_rejects_value_after_last_official_year_gap():
    full = make_full()
    # un trou en 2023 alors que 2024 est publié : la série est incohérente
    full.loc[(full.Province == "QC") & (full.Annee == 2023), "EmissionGES_MtCO2e"] = None
    with pytest.raises(ValueError, match="manquent"):
        validate(full, years=YEARS)


def test_validate_rejects_duplicates():
    full = make_full()
    full.iloc[0] = full.iloc[1]
    with pytest.raises(ValueError):
        validate(full, years=YEARS)
