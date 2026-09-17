from pathlib import Path

import pandas as pd

from config import TEMPERATURE_RAW_DIR, PROCESSED_DIR
from extractor import read_temperature_file
from transformer import calculate_monthly_province_summary
from utils import parse_climate_filename

OUTPUT_DIR = PROCESSED_DIR / "Temperature"
MONTHLY_OUTPUT = OUTPUT_DIR / "temperature_monthly.csv"
ANNUAL_OUTPUT = OUTPUT_DIR / "temperature_annual.csv"


def build_monthly_dataset():
    files = sorted(TEMPERATURE_RAW_DIR.glob("fr_climat_sommaires_*.csv"))
    if not files:
        raise FileNotFoundError(f"Aucun fichier CSV trouvé dans {TEMPERATURE_RAW_DIR}")

    rows = []
    print(f"Fichiers à traiter : {len(files)}")

    for index, file_path in enumerate(files, start=1):
        metadata = parse_climate_filename(file_path)
        df = read_temperature_file(file_path)
        summary = calculate_monthly_province_summary(df)

        # le code province tiré du nom de fichier doit matcher celui des données,
        # sinon on a probablement un fichier mal nommé ou corrompu
        if summary["province"] != metadata["province_code"]:
            raise ValueError(
                f"Incohérence province dans {file_path.name} : "
                f"{metadata['province_code']} != {summary['province']}"
            )

        rows.append({
            "Province": metadata["province_code"],
            "Annee": metadata["year"],
            "Mois": metadata["month"],
            "TemperatureMoyenne": summary["temperature_moyenne"],
            "NombreStations": summary["nb_stations_temperature"],
            "FichierSource": file_path.name,
        })

        if index % 25 == 0 or index == len(files):
            print(f"Traitement : {index}/{len(files)}")

    return pd.DataFrame(rows)


def validate_monthly_dataset(monthly_df):
    expected_rows = 13 * 3 * 12
    if len(monthly_df) != expected_rows:
        raise ValueError(f"Nombre de lignes incorrect : {len(monthly_df)} au lieu de {expected_rows}")

    duplicates = monthly_df.duplicated(subset=["Province", "Annee", "Mois"])
    if duplicates.any():
        raise ValueError(f"Doublons détectés :\n{monthly_df.loc[duplicates, ['Province', 'Annee', 'Mois']]}")

    missing_temperature = monthly_df["TemperatureMoyenne"].isna().sum()

    print()
    print("Validation mensuelle")
    print("--------------------")
    print(f"Lignes : {len(monthly_df)}")
    print(f"Températures mensuelles manquantes : {missing_temperature}")

    months_per_group = monthly_df.groupby(["Province", "Annee"]).size()
    invalid_groups = months_per_group[months_per_group != 12]
    if not invalid_groups.empty:
        raise ValueError(f"Certaines provinces/années n'ont pas exactement 12 mois :\n{invalid_groups}")

    print("Chaque province/année possède 12 mois : OK")


def build_annual_dataset(monthly_df):
    annual_df = monthly_df.groupby(["Province", "Annee"], as_index=False).agg(
        TemperatureMoyenne=("TemperatureMoyenne", "mean"),
        MoisDisponibles=("TemperatureMoyenne", "count"),
        StationsMoyennes=("NombreStations", "mean"),
    )
    annual_df["TemperatureMoyenne"] = annual_df["TemperatureMoyenne"].round(2)
    annual_df["StationsMoyennes"] = annual_df["StationsMoyennes"].round(1)
    return annual_df


def validate_annual_dataset(annual_df):
    expected_rows = 13 * 3
    if len(annual_df) != expected_rows:
        raise ValueError(f"Nombre annuel incorrect : {len(annual_df)} au lieu de {expected_rows}")

    incomplete = annual_df[annual_df["MoisDisponibles"] != 12]

    print()
    print("Validation annuelle")
    print("-------------------")
    print(f"Lignes : {len(annual_df)}")

    if incomplete.empty:
        print("39 séries annuelles complètes : OK")
    else:
        print("ATTENTION : séries avec moins de 12 températures mensuelles :")
        print(incomplete.to_string(index=False))


def main():
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    monthly_df = build_monthly_dataset()
    validate_monthly_dataset(monthly_df)
    monthly_df = monthly_df.sort_values(["Province", "Annee", "Mois"])
    monthly_df.to_csv(MONTHLY_OUTPUT, index=False, encoding="utf-8-sig")

    annual_df = build_annual_dataset(monthly_df)
    validate_annual_dataset(annual_df)
    annual_df = annual_df.sort_values(["Province", "Annee"])
    annual_df.to_csv(ANNUAL_OUTPUT, index=False, encoding="utf-8-sig")

    print()
    print("=" * 70)
    print("AGRÉGATION TERMINÉE")
    print("=" * 70)
    print(f"Mensuel : {MONTHLY_OUTPUT}")
    print(f"Annuel  : {ANNUAL_OUTPUT}")
    print()
    print("Aperçu des données annuelles :")
    print(annual_df.to_string(index=False))


if __name__ == "__main__":
    main()
