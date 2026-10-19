"""Construit les trois bases SQLite du mode démonstration (lecture seule) à partir des CSV de Data/Processed.

Pourquoi : SQL Server ne s'héberge pas gratuitement (ni sur Render ni ailleurs). La démo en ligne lit donc ces
fichiers SQLite, qui reprennent les mêmes tables, colonnes, identifiants, arrondis et vues que les bases SQL Server.
Un test compare les réponses des deux modes (deploy/compare_backends.py).

Usage : python ETL/build_demo_db.py [dossier_de_sortie]   (par défaut Data/Demo)
"""

import sqlite3
import sys

import pandas as pd
from config import BASE_DIR, PROCESSED_DIR, YEARS
from generate_sql import ANOMALY_COLUMNS, ANOMALY_DOMAINS, DOMAINS, NATIONAL, TREND_COLUMNS
from reference import PROVINCES

DEFAULT_OUTPUT = BASE_DIR / "Data" / "Demo"
NATIONAL_NAME = "Canada (moyenne des provinces)"

PROVINCE_IDS = {code: index for index, (code, _) in enumerate(PROVINCES, start=1)}
YEAR_IDS = {year: index for index, year in enumerate(sorted(YEARS), start=1)}


def number(value, decimals):
    """None pour les valeurs vides, sinon la valeur arrondie comme dans les scripts SQL."""
    return None if pd.isna(value) else round(float(value), decimals)


def create_reference(connection):
    connection.executescript(
        """
        CREATE TABLE Province (ProvinceID INTEGER PRIMARY KEY, CodeProvince TEXT NOT NULL, NomProvince TEXT NOT NULL);
        CREATE TABLE Annee (AnneeID INTEGER PRIMARY KEY, ValeurAnnee INTEGER NOT NULL);
        """
    )
    connection.executemany(
        "INSERT INTO Province VALUES (?, ?, ?)",
        [(PROVINCE_IDS[code], code, name) for code, name in PROVINCES],
    )
    connection.executemany("INSERT INTO Annee VALUES (?, ?)", [(YEAR_IDS[year], year) for year in sorted(YEARS)])


def create_fact(connection, domain):
    column = domain.column
    connection.execute(
        f"CREATE TABLE {domain.table} (ProvinceID INTEGER NOT NULL, AnneeID INTEGER NOT NULL, {column} REAL)"
    )
    df = pd.read_csv(PROCESSED_DIR / domain.csv)
    rows = [
        (PROVINCE_IDS[row.Province], YEAR_IDS[int(row.Annee)], number(getattr(row, column), 2))
        for row in df.itertuples(index=False)
    ]
    connection.executemany(f"INSERT INTO {domain.table} VALUES (?, ?, ?)", rows)
    connection.execute(
        f"""
        CREATE VIEW vw_{domain.table} AS
        SELECT p.ProvinceID, p.CodeProvince, p.NomProvince, a.AnneeID, a.ValeurAnnee AS Annee, t.{column}
        FROM {domain.table} t
        INNER JOIN Province p ON t.ProvinceID = p.ProvinceID
        INNER JOIN Annee a ON t.AnneeID = a.AnneeID
        """
    )


def create_anomalies(connection, domain):
    columns = ", ".join(f"{name} REAL" for name, _, _ in ANOMALY_COLUMNS)
    connection.execute(
        f"CREATE TABLE {domain.anomaly_table} (ProvinceID INTEGER, AnneeID INTEGER NOT NULL, {columns})"
    )
    annual = pd.read_csv(PROCESSED_DIR / domain.folder / f"{domain.name}_anomaly_annual.csv")
    rows = [
        (
            None if row["Province"] == NATIONAL else PROVINCE_IDS[row["Province"]],
            YEAR_IDS[int(row["Annee"])],
            *(number(row[csv_name], decimals) for _, csv_name, decimals in ANOMALY_COLUMNS),
        )
        for row in annual.to_dict("records")
    ]
    marks = ", ".join("?" * (2 + len(ANOMALY_COLUMNS)))
    connection.executemany(f"INSERT INTO {domain.anomaly_table} VALUES ({marks})", rows)

    connection.execute(
        f"""
        CREATE VIEW vw_{domain.anomaly_table} AS
        SELECT t.ProvinceID, IFNULL(p.CodeProvince, 'CA') AS CodeProvince,
               IFNULL(p.NomProvince, '{NATIONAL_NAME}') AS NomProvince,
               a.AnneeID, a.ValeurAnnee AS Annee,
               t.AnomalieStationsLongues, t.AnomalieToutesStations, t.MoyenneSimple
        FROM {domain.anomaly_table} t
        LEFT JOIN Province p ON t.ProvinceID = p.ProvinceID
        INNER JOIN Annee a ON t.AnneeID = a.AnneeID
        """
    )

    trend_columns = ", ".join(f"{name} REAL" for name, _ in TREND_COLUMNS)
    connection.execute(
        f"CREATE TABLE {domain.trend_table} (ProvinceID INTEGER, Methode TEXT NOT NULL, {trend_columns}, NbAnnees INTEGER NOT NULL)"
    )
    trends = pd.read_csv(PROCESSED_DIR / domain.folder / f"{domain.name}_trends.csv")
    rows = [
        (
            None if row["Province"] == NATIONAL else PROVINCE_IDS[row["Province"]],
            row["Methode"],
            *(number(row[name], decimals) for name, decimals in TREND_COLUMNS),
            int(row["NbAnnees"]),
        )
        for row in trends.to_dict("records")
    ]
    marks = ", ".join("?" * (3 + len(TREND_COLUMNS)))
    connection.executemany(f"INSERT INTO {domain.trend_table} VALUES ({marks})", rows)

    connection.execute(
        f"""
        CREATE VIEW vw_{domain.trend_table} AS
        SELECT t.ProvinceID, IFNULL(p.CodeProvince, 'CA') AS CodeProvince,
               IFNULL(p.NomProvince, '{NATIONAL_NAME}') AS NomProvince,
               t.Methode, t.PenteParDecennie, t.IC95_Bas, t.IC95_Haut, t.PValeur, t.NbAnnees
        FROM {domain.trend_table} t
        LEFT JOIN Province p ON t.ProvinceID = p.ProvinceID
        """
    )


def build_database(domain, output_dir):
    path = output_dir / f"{domain.database}.sqlite"
    path.unlink(missing_ok=True)

    connection = sqlite3.connect(path)
    try:
        create_reference(connection)
        create_fact(connection, domain)
        if domain.name in ANOMALY_DOMAINS:
            create_anomalies(connection, ANOMALY_DOMAINS[domain.name])
        connection.commit()
        connection.execute("VACUUM")
    finally:
        connection.close()
    return path


def main():
    output_dir = BASE_DIR / sys.argv[1] if len(sys.argv) > 1 else DEFAULT_OUTPUT
    output_dir.mkdir(parents=True, exist_ok=True)
    for domain in DOMAINS.values():
        path = build_database(domain, output_dir)
        print(f"{path} ({path.stat().st_size // 1024} Ko)")


if __name__ == "__main__":
    main()
