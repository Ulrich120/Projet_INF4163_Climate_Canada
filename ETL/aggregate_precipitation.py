import pandas as pd

from config import TEMPERATURE_RAW_DIR, PROCESSED_DIR
from extractor import read_temperature_file
from transformer import calculate_monthly_province_summary
from utils import parse_climate_filename

OUTPUT_DIR = PROCESSED_DIR / "Precipitation"
MONTHLY_OUTPUT = OUTPUT_DIR / "precipitation_monthly.csv"
ANNUAL_OUTPUT = OUTPUT_DIR / "precipitation_annual.csv"


def build_monthly_dataset():
    files = sorted(TEMPERATURE_RAW_DIR.glob("fr_climat_sommaires_*.csv"))
    if not files:
        raise FileNotFoundError("Aucun fichier climatique trouvé.")

    rows = []
    print(f"Fichiers à traiter : {len(files)}")

    for index, file_path in enumerate(files, start=1):
        metadata = parse_climate_filename(file_path)
        df = read_temperature_file(file_path)
        summary = calculate_monthly_province_summary(df)

        if summary["province"] != metadata["province_code"]:
            raise ValueError(f"Incohérence province : {file_path.name}")

        rows.append({
            "Province": metadata["province_code"],
            "Annee": metadata["year"],
            "Mois": metadata["month"],
            "PrecipitationMoyenne": summary["precipitation_moyenne"],
            "NombreStations": summary["nb_stations_precipitation"],
            "FichierSource": file_path.name,
        })

        if index % 25 == 0 or index == len(files):
            print(f"Traitement : {index}/{len(files)}")

    return pd.DataFrame(rows)


def validate_monthly_dataset(df):
    expected_rows = 13 * 3 * 12
    if len(df) != expected_rows:
        raise ValueError(f"{expected_rows} lignes attendues, {len(df)} trouvées.")

    if df.duplicated(subset=["Province", "Annee", "Mois"]).any():
        raise ValueError("Doublons province/année/mois détectés.")

    missing = df["PrecipitationMoyenne"].isna().sum()

    print()
    print("Validation mensuelle")
    print("--------------------")
    print(f"Lignes : {len(df)}")
    print(f"Précipitations mensuelles manquantes : {missing}")

    groups = df.groupby(["Province", "Annee"]).size()
    if (groups != 12).any():
        raise ValueError("Certaines séries ne possèdent pas exactement 12 mois.")

    print("Chaque province/année possède 12 mois : OK")


def build_annual_dataset(monthly_df):
    annual_df = monthly_df.groupby(["Province", "Annee"], as_index=False).agg(
        PrecipitationAnnuelle=("PrecipitationMoyenne", "sum"),
        MoisDisponibles=("PrecipitationMoyenne", "count"),
        StationsMoyennes=("NombreStations", "mean"),
    )
    annual_df["PrecipitationAnnuelle"] = annual_df["PrecipitationAnnuelle"].round(2)
    annual_df["StationsMoyennes"] = annual_df["StationsMoyennes"].round(1)
    return annual_df


def validate_annual_dataset(df):
    if len(df) != 39:
        raise ValueError(f"39 lignes attendues, {len(df)} trouvées.")

    incomplete = df[df["MoisDisponibles"] != 12]

    print()
    print("Validation annuelle")
    print("-------------------")
    print(f"Lignes : {len(df)}")

    if incomplete.empty:
        print("39 séries annuelles complètes : OK")
    else:
        print("ATTENTION : séries incomplètes :")
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
    print("AGRÉGATION DES PRÉCIPITATIONS TERMINÉE")
    print("=" * 70)
    print(f"Mensuel : {MONTHLY_OUTPUT}")
    print(f"Annuel  : {ANNUAL_OUTPUT}")
    print()
    print("Aperçu annuel :")
    print(annual_df.to_string(index=False))


if __name__ == "__main__":
    main()
