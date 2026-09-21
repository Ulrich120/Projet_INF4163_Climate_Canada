from pathlib import Path

import pandas as pd
from config import YEARS
from reference import PROVINCE_NAME_TO_CODE

INPUT_FILE = Path("Data/Raw/Pollution/GES_Econ_Can_Prov_Terr.csv")
OUTPUT_DIR = Path("Data/Processed/Pollution")
OUTPUT_FILE = OUTPUT_DIR / "pollution_annual.csv"

# nom de région (français, tel que dans le fichier ECCC) -> code de province
PROVINCE_CODES = PROVINCE_NAME_TO_CODE

TOTAL_SOURCES = [
    "Total",
    "Total provincial de l'inventaire",
    "Total territorial de l'inventaire",
]


def read_source_file():
    encodings = ["utf-8-sig", "utf-8", "cp1252", "latin1"]
    for encoding in encodings:
        try:
            df = pd.read_csv(INPUT_FILE, encoding=encoding, low_memory=False)
            print(f"Encodage utilisé : {encoding}")
            return df
        except UnicodeDecodeError:
            continue

    raise RuntimeError("Impossible de lire le fichier CSV avec les encodages disponibles.")


def extract_official_data(df, years=YEARS):
    print(f"Lignes source : {len(df)}")

    required_columns = [
        "Année", "Région", "Source", "Secteur",
        "Sous-Secteur", "Sous-sous-Secteur", "Total (kt CO2eq)",
    ]
    missing_columns = [c for c in required_columns if c not in df.columns]
    if missing_columns:
        raise ValueError("Colonnes manquantes : " + ", ".join(missing_columns))

    filtered = df[df["Année"].isin(years)].copy()
    print(f"Lignes après filtre sur la période {min(years)}-{max(years)} : {len(filtered)}")

    # uniquement les lignes de total provincial/territorial, pas les sous-totaux sectoriels
    filtered = filtered[filtered["Source"].astype(str).str.strip().isin(TOTAL_SOURCES)].copy()
    print(f"Lignes après filtre Source total : {len(filtered)}")

    filtered = filtered[
        filtered["Secteur"].isna()
        & filtered["Sous-Secteur"].isna()
        & filtered["Sous-sous-Secteur"].isna()
    ].copy()
    print(f"Lignes après suppression des ventilations sectorielles : {len(filtered)}")

    filtered = filtered[filtered["Région"].isin(PROVINCE_CODES.keys())].copy()
    print(f"Lignes après filtre provinces/territoires : {len(filtered)}")

    filtered["Province"] = filtered["Région"].map(PROVINCE_CODES)

    filtered["EmissionGES_ktCO2e"] = pd.to_numeric(filtered["Total (kt CO2eq)"], errors="coerce")
    filtered["EmissionGES_MtCO2e"] = filtered["EmissionGES_ktCO2e"] / 1000

    result = filtered[["Province", "Année", "EmissionGES_MtCO2e"]].copy()
    result = result.rename(columns={"Année": "Annee"})
    result["EmissionGES_MtCO2e"] = result["EmissionGES_MtCO2e"].round(2)

    return result


def add_missing_rows(df, years=YEARS):
    # les années pas encore publiées par ECCC restent NULL plutôt que d'être estimées
    existing = set(zip(df["Province"], df["Annee"], strict=True))
    missing = [
        {"Province": code, "Annee": year, "EmissionGES_MtCO2e": None}
        for code in sorted(PROVINCE_CODES.values())
        for year in years
        if (code, year) not in existing
    ]
    if not missing:
        return df
    return pd.concat([df, pd.DataFrame(missing)], ignore_index=True)


def validate(df, years=YEARS):
    print()
    print("Validation")
    print("----------")
    print(f"Lignes obtenues : {len(df)}")

    expected_rows = len(PROVINCE_CODES) * len(years)
    if len(df) != expected_rows:
        raise ValueError(f"{expected_rows} lignes attendues, {len(df)} obtenues.")

    duplicates = df.duplicated(subset=["Province", "Annee"], keep=False)
    if duplicates.any():
        print(df.loc[duplicates, ["Province", "Annee", "EmissionGES_MtCO2e"]]
              .sort_values(["Province", "Annee"]).to_string(index=False))
        raise ValueError("Doublons province/année détectés.")

    provinces = sorted(df["Province"].unique())
    expected_provinces = sorted(PROVINCE_CODES.values())
    if provinces != expected_provinces:
        raise ValueError(f"Liste des provinces incorrecte.\nAttendu : {expected_provinces}\nObtenu  : {provinces}")

    if sorted(df["Annee"].unique()) != sorted(years):
        raise ValueError(f"Années incorrectes : {sorted(df['Annee'].unique())}")

    counts = df.groupby("Province").size()
    if (counts != len(years)).any():
        raise ValueError(f"Certaines provinces n'ont pas exactement {len(years)} années :\n{counts[counts != len(years)]}")

    # pas de trou : toutes les années jusqu'à la dernière année publiée sont renseignées,
    # toutes les suivantes sont vides
    filled = df.dropna(subset=["EmissionGES_MtCO2e"])
    if filled.empty:
        raise ValueError("Aucune valeur officielle trouvée.")
    last_official = int(filled["Annee"].max())

    before = df[df["Annee"] <= last_official]
    if before["EmissionGES_MtCO2e"].isna().any():
        raise ValueError(f"Des valeurs officielles manquent avant {last_official}.")

    after = df[df["Annee"] > last_official]
    if after["EmissionGES_MtCO2e"].notna().any():
        raise ValueError("Valeurs inattendues après la dernière année officielle.")

    print(f"{len(PROVINCE_CODES)} provinces/territoires : OK")
    print(f"Années {min(years)}-{max(years)} : OK")
    print(f"{min(years)}-{last_official} : données officielles complètes")
    if last_official < max(years):
        label = str(max(years)) if last_official + 1 == max(years) else f"{last_official + 1}-{max(years)}"
        print(f"{label} : NULL (données officielles non disponibles)")
    print(f"{expected_rows} lignes : OK")


def main():
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    source_df = read_source_file()
    annual_df = extract_official_data(source_df)
    annual_df = add_missing_rows(annual_df)
    annual_df = annual_df.sort_values(["Province", "Annee"]).reset_index(drop=True)

    validate(annual_df)

    annual_df.to_csv(OUTPUT_FILE, index=False, encoding="utf-8-sig")

    print()
    print("=" * 70)
    print("AGRÉGATION POLLUTION TERMINÉE")
    print("=" * 70)
    print(f"Fichier : {OUTPUT_FILE}")
    print()
    print("Aperçu :")
    print(annual_df.tail(30).to_string(index=False))


if __name__ == "__main__":
    main()
