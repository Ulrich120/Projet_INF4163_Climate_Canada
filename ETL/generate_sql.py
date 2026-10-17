"""Génère les scripts SQL de chargement (Database/<X>DB/02_insert_*.sql) à partir des CSV annuels.

Usage : python ETL/generate_sql.py [temperature|precipitation|pollution]   (sans argument : les trois)
"""

import sys
from dataclasses import dataclass

import pandas as pd
from config import DATABASE_DIR, PROCESSED_DIR, YEARS
from reference import reference_sql


@dataclass(frozen=True)
class Domain:
    name: str
    database: str
    table: str
    csv: str
    column: str
    label: str
    nullable: bool  # la colonne SQL accepte-t-elle NULL ?
    has_source: bool = False


DOMAINS = {
    "temperature": Domain("temperature", "TemperatureDB", "Temperature",
                          "Temperature/temperature_annual.csv", "TemperatureMoyenne",
                          "Température moyenne annuelle (°C)", nullable=True, has_source=True),
    "precipitation": Domain("precipitation", "PrecipitationDB", "Precipitation",
                            "Precipitation/precipitation_annual.csv", "PrecipitationAnnuelle",
                            "Précipitations annuelles (mm)", nullable=True),
    "pollution": Domain("pollution", "PollutionDB", "Pollution",
                        "Pollution/pollution_annual.csv", "EmissionGES_MtCO2e",
                        "Émissions annuelles de GES (Mt CO2e), NULL = donnée officielle non publiée",
                        nullable=True),
}


def build_sql(domain, df, years=YEARS):
    """Retourne le contenu du script SQL et le nombre de lignes ignorées (valeur vide, colonne NOT NULL)."""
    lines = [
        f"USE {domain.database};",
        "GO",
        "",
        f"-- {domain.label}",
        f"-- Période {min(years)}-{max(years)}. Source : Environnement et Changement climatique Canada",
        "-- Fichier généré par ETL/generate_sql.py, ne pas modifier à la main.",
        "",
        *reference_sql(years, with_source=domain.has_source),
    ]

    columns = "ProvinceID, AnneeID, " + domain.column + (", SourceID" if domain.has_source else "")
    skipped = []

    for row in df.sort_values(["Province", "Annee"]).itertuples(index=False):
        value = getattr(row, domain.column)
        if pd.isna(value):
            if not domain.nullable:
                skipped.append((row.Province, int(row.Annee)))
                continue
            value_sql = "NULL"
        else:
            value_sql = f"{float(value):.2f}"

        source_sql = ", 1" if domain.has_source else ""
        lines.append(
            f"INSERT INTO {domain.table} ({columns}) "
            f"SELECT p.ProvinceID, a.AnneeID, {value_sql}{source_sql} FROM Province p, Annee a "
            f"WHERE p.CodeProvince = '{row.Province}' AND a.ValeurAnnee = {int(row.Annee)};"
        )

    if skipped:
        lines += ["", "-- Séries annuelles incomplètes, non chargées : " + ", ".join(f"{p} {y}" for p, y in skipped)]

    lines += [
        "GO",
        "",
        "-- Vérification",
        f"SELECT COUNT(*) AS NombreLignes FROM {domain.table};",
    ]
    return "\n".join(lines) + "\n", len(skipped)


def generate(domain_name):
    domain = DOMAINS[domain_name]
    df = pd.read_csv(PROCESSED_DIR / domain.csv)
    sql, skipped = build_sql(domain, df)

    output = DATABASE_DIR / domain.database / f"02_insert_{domain.name}_data.sql"
    output.write_text(sql, encoding="utf-8")

    print(f"{output.relative_to(DATABASE_DIR.parent)} : {len(df) - skipped} INSERT, {skipped} série(s) ignorée(s)")


ANOMALY_COLUMNS = [
    ("AnomalieStationsLongues", "AnomalieStationsLongues", 3),
    ("AnomalieToutesStations", "AnomalieToutesStations", 3),
    ("MoyenneSimple", "MoyenneSimple", 3),
    ("NbStationsLongues", "NbStationsLongues", 1),
]
TREND_COLUMNS = [("PenteParDecennie", 4), ("IC95_Bas", 4), ("IC95_Haut", 4), ("PValeur", 6)]
NATIONAL = "CANADA"  # ProvinceID NULL dans les tables d'anomalies et de tendances


@dataclass(frozen=True)
class AnomalyDomain:
    name: str
    database: str
    folder: str  # sous-dossier de Data/Processed
    anomaly_table: str
    trend_table: str
    unit: str


ANOMALY_DOMAINS = {
    "temperature": AnomalyDomain("temperature", "TemperatureDB", "Temperature",
                                 "TemperatureAnomalie", "TemperatureTendance", "°C"),
    "precipitation": AnomalyDomain("precipitation", "PrecipitationDB", "Precipitation",
                                   "PrecipitationAnomalie", "PrecipitationTendance", "% de la normale"),
}


def sql_number(value, decimals):
    return "NULL" if pd.isna(value) else f"{float(value):.{decimals}f}"


def lookup(province, year):
    """FROM/WHERE qui retrouve les identifiants (le Canada n'a pas de ProvinceID)."""
    if province == NATIONAL:
        return "NULL", f"FROM Annee a WHERE a.ValeurAnnee = {int(year)}"
    return "p.ProvinceID", f"FROM Province p, Annee a WHERE p.CodeProvince = '{province}' AND a.ValeurAnnee = {int(year)}"


def build_anomaly_sql(annual, trends, years=YEARS, domain=ANOMALY_DOMAINS["temperature"]):
    """Script SQL des tables d'anomalies et de tendances (rechargées à chaque exécution)."""
    lines = [
        f"USE {domain.database};",
        "GO",
        "",
        f"-- Anomalies par station et tendances ({domain.name}), période {min(years)}-{max(years)}, unité : {domain.unit}",
        "-- Fichier généré par ETL/generate_sql.py à partir de ETL/station_anomalies.py, ne pas modifier à la main.",
        "-- ProvinceID NULL = Canada (moyenne des provinces à poids égaux).",
        "",
        f"DELETE FROM {domain.trend_table};",
        f"DELETE FROM {domain.anomaly_table};",
        "",
    ]

    columns = ", ".join(["ProvinceID", "AnneeID"] + [sql_name for sql_name, _, _ in ANOMALY_COLUMNS])
    for row in annual.sort_values(["Province", "Annee"]).to_dict("records"):
        province_sql, source = lookup(row["Province"], row["Annee"])
        values = ", ".join(sql_number(row[csv_name], decimals) for _, csv_name, decimals in ANOMALY_COLUMNS)
        lines.append(
            f"INSERT INTO {domain.anomaly_table} ({columns}) "
            f"SELECT {province_sql}, a.AnneeID, {values} {source};"
        )

    lines.append("")
    columns = ", ".join(["ProvinceID", "Methode"] + [name for name, _ in TREND_COLUMNS] + ["NbAnnees"])
    for row in trends.sort_values(["Province", "Methode"]).to_dict("records"):
        province = row["Province"]
        if province == NATIONAL:
            province_sql, source = "NULL", ""
        else:
            province_sql, source = "p.ProvinceID", f"FROM Province p WHERE p.CodeProvince = '{province}'"
        values = ", ".join(sql_number(row[name], decimals) for name, decimals in TREND_COLUMNS)
        lines.append(
            f"INSERT INTO {domain.trend_table} ({columns}) "
            f"SELECT {province_sql}, '{row['Methode']}', {values}, {int(row['NbAnnees'])} {source};"
        )

    lines += [
        "GO",
        "",
        "-- Vérification",
        f"SELECT COUNT(*) AS NombreAnomalies FROM {domain.anomaly_table};",
        f"SELECT COUNT(*) AS NombreTendances FROM {domain.trend_table};",
    ]
    return "\n".join(lines) + "\n"


def generate_anomalies(domain):
    annual = pd.read_csv(PROCESSED_DIR / domain.folder / f"{domain.name}_anomaly_annual.csv")
    trends = pd.read_csv(PROCESSED_DIR / domain.folder / f"{domain.name}_trends.csv")
    output = DATABASE_DIR / domain.database / f"03_insert_{domain.name}_anomalies.sql"
    output.write_text(build_anomaly_sql(annual, trends, domain=domain), encoding="utf-8")
    print(f"{output.relative_to(DATABASE_DIR.parent)} : {len(annual)} anomalies, {len(trends)} tendances")


def main():
    names = sys.argv[1:] or [*DOMAINS, "anomalies"]
    for name in names:
        if name == "anomalies":
            for domain in ANOMALY_DOMAINS.values():
                generate_anomalies(domain)
        else:
            generate(name)


if __name__ == "__main__":
    main()
