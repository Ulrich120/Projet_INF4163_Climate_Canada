"""Assemble tous les CSV mensuels d'ECCC en une seule table station x mois.

Sortie : Data/Interim/stations_monthly.csv.gz (régénérable, non versionné).
C'est la base de l'analyse de tendance, qui suit chaque station dans le temps.
"""

import pandas as pd
from config import INTERIM_DIR, TEMPERATURE_RAW_DIR
from extractor import read_temperature_file
from transformer import convert_french_decimal
from utils import parse_climate_filename

STATIONS_FILE = INTERIM_DIR / "stations_monthly.csv.gz"

KEPT_COLUMNS = ["ID_Clim", "Nom", "Lat", "Long", "Tm", "P"]


def read_station_month(file_path):
    """Une ligne par station pour un fichier province/mois/année."""
    meta = parse_climate_filename(file_path)
    # l'identifiant doit rester du texte : pandas le lirait comme un nombre (zéros initiaux perdus,
    # "1E12345" lu en notation scientifique) et une même station aurait deux identifiants
    df = read_temperature_file(file_path, dtype={"ID_Clim": "string"})

    missing = [c for c in KEPT_COLUMNS if c not in df.columns]
    if missing:
        raise ValueError(f"{file_path.name} : colonnes manquantes {missing}")

    df = df[KEPT_COLUMNS].copy()
    df["ID_Clim"] = df["ID_Clim"].astype("string").str.strip()
    for column in ("Lat", "Long", "Tm", "P"):
        df[column] = convert_french_decimal(df[column])

    df["Province"] = meta["province_code"]
    df["Annee"] = meta["year"]
    df["Mois"] = meta["month"]
    return df


def build_station_table():
    files = sorted(TEMPERATURE_RAW_DIR.glob("fr_climat_sommaires_*.csv"))
    if not files:
        raise FileNotFoundError(f"Aucun fichier dans {TEMPERATURE_RAW_DIR}")

    frames = []
    for index, file_path in enumerate(files, start=1):
        frames.append(read_station_month(file_path))
        if index % 500 == 0 or index == len(files):
            print(f"Lecture : {index}/{len(files)}", flush=True)

    table = pd.concat(frames, ignore_index=True)

    duplicates = table.duplicated(["ID_Clim", "Annee", "Mois"])
    if duplicates.any():
        raise ValueError(f"{duplicates.sum()} doublons station/année/mois")

    return table.sort_values(["Province", "ID_Clim", "Annee", "Mois"]).reset_index(drop=True)


def main():
    INTERIM_DIR.mkdir(parents=True, exist_ok=True)
    table = build_station_table()
    table.to_csv(STATIONS_FILE, index=False, encoding="utf-8")
    print(f"{len(table)} relevés, {table['ID_Clim'].nunique()} stations -> {STATIONS_FILE}")


if __name__ == "__main__":
    main()
