import pandas as pd
from generate_sql import DOMAINS, build_sql
from reference import PROVINCE_CODES, PROVINCES

YEARS = (2000, 2001)


def test_reference_data_is_consistent():
    assert len(PROVINCES) == 13
    assert len(set(PROVINCE_CODES)) == 13


def test_temperature_script_seeds_reference_tables_and_keeps_incomplete_series_as_null():
    df = pd.DataFrame({
        "Province": ["QC", "QC", "NU"],
        "Annee": [2000, 2001, 2000],
        "TemperatureMoyenne": [1.234, None, -12.5],
    })
    sql, skipped = build_sql(DOMAINS["temperature"], df, years=YEARS)

    assert sql.startswith("USE TemperatureDB;")
    assert "INSERT INTO Province" in sql
    assert "INSERT INTO SourceDonnee" in sql
    assert "(2000),\n    (2001)" in sql
    assert "SELECT p.ProvinceID, a.AnneeID, 1.23, 1 " in sql
    assert "SELECT p.ProvinceID, a.AnneeID, NULL, 1 " in sql
    assert "p.CodeProvince = 'NU' AND a.ValeurAnnee = 2000" in sql
    assert skipped == 0


def test_pollution_script_keeps_null_values():
    df = pd.DataFrame({"Province": ["AB", "AB"], "Annee": [2000, 2001], "EmissionGES_MtCO2e": [200.5, None]})
    sql, skipped = build_sql(DOMAINS["pollution"], df, years=YEARS)

    assert skipped == 0
    assert "SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p" in sql
    assert "INSERT INTO SourceDonnee" not in sql
