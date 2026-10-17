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


def test_anomaly_script_handles_the_national_row_and_missing_values():
    from generate_sql import build_anomaly_sql

    annual = pd.DataFrame({
        "Province": ["QC", "CANADA"],
        "Annee": [2000, 2000],
        "AnomalieStationsLongues": [0.4249, -0.465],
        "AnomalieToutesStations": [0.485, None],
        "MoyenneSimple": [4.883, 1.815],
        "NbStationsLongues": [59.33, None],
    })
    trends = pd.DataFrame({
        "Province": ["QC", "CANADA"],
        "Methode": ["anomalie_stations_longues"] * 2,
        "PenteParDecennie": [0.44, 0.353],
        "IC95_Bas": [0.01, 0.038],
        "IC95_Haut": [0.87, 0.668],
        "PValeur": [0.047, 0.029],
        "NbAnnees": [26, 26],
    })
    sql = build_anomaly_sql(annual, trends, years=(2000,))

    assert sql.startswith("USE TemperatureDB;")
    assert sql.index("DELETE FROM TemperatureTendance") < sql.index("INSERT INTO TemperatureAnomalie")
    assert "SELECT p.ProvinceID, a.AnneeID, 0.425, 0.485, 4.883, 59.3 FROM Province p, Annee a" in sql
    assert "SELECT NULL, a.AnneeID, -0.465, NULL, 1.815, NULL FROM Annee a WHERE a.ValeurAnnee = 2000;" in sql
    assert "SELECT p.ProvinceID, 'anomalie_stations_longues', 0.4400, 0.0100, 0.8700, 0.047000, 26 FROM Province p" in sql
    assert "SELECT NULL, 'anomalie_stations_longues', 0.3530, 0.0380, 0.6680, 0.029000, 26 ;" in sql


def test_precipitation_anomaly_script_targets_its_own_database_and_tables():
    from generate_sql import ANOMALY_DOMAINS, build_anomaly_sql

    annual = pd.DataFrame({
        "Province": ["YT"],
        "Annee": [2000],
        "AnomalieStationsLongues": [None],
        "AnomalieToutesStations": [1.116],
        "MoyenneSimple": [366.54],
        "NbStationsLongues": [None],
    })
    trends = pd.DataFrame({
        "Province": ["YT"],
        "Methode": ["anomalie_stations_longues"],
        "PenteParDecennie": [None],
        "IC95_Bas": [None],
        "IC95_Haut": [None],
        "PValeur": [None],
        "NbAnnees": [0],
    })
    sql = build_anomaly_sql(annual, trends, years=(2000,), domain=ANOMALY_DOMAINS["precipitation"])

    assert sql.startswith("USE PrecipitationDB;")
    assert "DELETE FROM PrecipitationTendance;" in sql and "DELETE FROM PrecipitationAnomalie;" in sql
    assert "TemperatureAnomalie" not in sql
    assert "SELECT p.ProvinceID, a.AnneeID, NULL, 1.116, 366.540, NULL FROM Province p" in sql
    assert "SELECT p.ProvinceID, 'anomalie_stations_longues', NULL, NULL, NULL, NULL, 0 FROM Province p" in sql
