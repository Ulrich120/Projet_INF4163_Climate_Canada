from pathlib import Path
import pandas as pd

INPUT_CSV = Path("Data/Processed/Precipitation/precipitation_annual.csv")
OUTPUT_SQL = Path("Data/SQL/Precipitation/insert_precipitation_2023_2025.sql")
OUTPUT_SQL.parent.mkdir(parents=True, exist_ok=True)

PROVINCE_IDS = {
    "NL": 1, "PE": 2, "NS": 3, "NB": 4, "QC": 5, "ON": 6, "MB": 7,
    "SK": 8, "AB": 9, "BC": 10, "YT": 11, "NT": 12, "NU": 13,
}

ANNEE_IDS = {2023: 1, 2024: 2, 2025: 3}


def main():
    df = pd.read_csv(INPUT_CSV)
    if len(df) != 39:
        raise ValueError(f"39 lignes attendues, {len(df)} trouvées.")

    sql_lines = [
        "USE PrecipitationDB;",
        "GO",
        "",
        "-- Donnees de precipitations annuelles",
        "-- Source : Environnement et Changement climatique Canada",
        "",
    ]

    for _, row in df.iterrows():
        province_id = PROVINCE_IDS[row["Province"]]
        annee_id = ANNEE_IDS[int(row["Annee"])]
        precipitation = float(row["PrecipitationAnnuelle"])

        sql_lines.append(
            f"INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) "
            f"VALUES ({province_id}, {annee_id}, {precipitation:.2f});"
        )

    sql_lines += [
        "",
        "GO",
        "",
        "-- Verification",
        "SELECT p.CodeProvince, a.ValeurAnnee, pr.PrecipitationAnnuelle "
        "FROM Precipitation pr "
        "JOIN Province p ON pr.ProvinceID = p.ProvinceID "
        "JOIN Annee a ON pr.AnneeID = a.AnneeID "
        "ORDER BY p.CodeProvince, a.ValeurAnnee;",
    ]

    OUTPUT_SQL.write_text("\n".join(sql_lines), encoding="utf-8")

    print("SCRIPT SQL PRECIPITATION GENERE")
    print(f"Fichier : {OUTPUT_SQL}")
    print(f"INSERT generes : {len(df)}")


if __name__ == "__main__":
    main()
