from pathlib import Path
import pandas as pd

from config import PROCESSED_DIR, SQL_DIR

INPUT_FILE = PROCESSED_DIR / "Temperature" / "temperature_annual.csv"
OUTPUT_DIR = SQL_DIR / "Temperature"
OUTPUT_FILE = OUTPUT_DIR / "insert_temperature_2023_2025.sql"

PROVINCE_IDS = {
    "NL": 1, "PE": 2, "NS": 3, "NB": 4, "QC": 5, "ON": 6, "MB": 7,
    "SK": 8, "AB": 9, "BC": 10, "YT": 11, "NT": 12, "NU": 13,
}

ANNEE_IDS = {2023: 1, 2024: 2, 2025: 3}


def main():
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    df = pd.read_csv(INPUT_FILE)
    if len(df) != 39:
        raise ValueError(f"39 lignes attendues, {len(df)} trouvées.")

    sql_lines = [
        "USE TemperatureDB;",
        "GO",
        "",
        "-- Données de température moyenne annuelle",
        "-- Source : Environnement et Changement climatique Canada",
        "",
    ]

    for _, row in df.iterrows():
        province_id = PROVINCE_IDS[row["Province"]]
        annee_id = ANNEE_IDS[int(row["Annee"])]
        temperature = float(row["TemperatureMoyenne"])

        sql_lines.append(
            f"INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) "
            f"VALUES ({province_id}, {annee_id}, {temperature:.2f}, 1);"
        )

    sql_lines += [
        "",
        "GO",
        "",
        "-- Vérification",
        "SELECT p.CodeProvince, a.ValeurAnnee, t.TemperatureMoyenne "
        "FROM Temperature t "
        "JOIN Province p ON t.ProvinceID = p.ProvinceID "
        "JOIN Annee a ON t.AnneeID = a.AnneeID "
        "ORDER BY p.CodeProvince, a.ValeurAnnee;",
    ]

    OUTPUT_FILE.write_text("\n".join(sql_lines), encoding="utf-8")

    print("SCRIPT SQL GÉNÉRÉ")
    print(f"Fichier : {OUTPUT_FILE}")
    print(f"INSERT générés : {len(df)}")


if __name__ == "__main__":
    main()
