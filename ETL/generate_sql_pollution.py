from pathlib import Path
import pandas as pd

INPUT_CSV = Path("Data/Processed/Pollution/pollution_annual.csv")
OUTPUT_SQL = Path("Data/SQL/Pollution/insert_pollution_2023_2025.sql")
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
        "USE PollutionDB;",
        "GO",
        "",
        "-- Emissions annuelles de GES en Mt CO2e",
        "-- Source : Environnement et Changement climatique Canada",
        "-- 2025 : donnee officielle non disponible, valeur NULL",
        "",
    ]

    for _, row in df.iterrows():
        province_id = PROVINCE_IDS[row["Province"]]
        annee_id = ANNEE_IDS[int(row["Annee"])]
        emission = row["EmissionGES_MtCO2e"]
        emission_sql = "NULL" if pd.isna(emission) else f"{float(emission):.2f}"

        sql_lines.append(
            f"INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) "
            f"VALUES ({province_id}, {annee_id}, {emission_sql});"
        )

    sql_lines += [
        "",
        "GO",
        "",
        "-- Verification",
        "SELECT p.CodeProvince, a.ValeurAnnee, po.EmissionGES_MtCO2e "
        "FROM Pollution po "
        "JOIN Province p ON po.ProvinceID = p.ProvinceID "
        "JOIN Annee a ON po.AnneeID = a.AnneeID "
        "ORDER BY p.CodeProvince, a.ValeurAnnee;",
    ]

    OUTPUT_SQL.write_text("\n".join(sql_lines), encoding="utf-8")

    print("SCRIPT SQL POLLUTION GENERE")
    print(f"Fichier : {OUTPUT_SQL}")
    print(f"INSERT generes : {len(df)}")
    print(f"Valeurs NULL : {df['EmissionGES_MtCO2e'].isna().sum()}")


if __name__ == "__main__":
    main()
