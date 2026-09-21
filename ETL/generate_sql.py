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


def main():
    names = sys.argv[1:] or list(DOMAINS)
    for name in names:
        generate(name)


if __name__ == "__main__":
    main()
