from pathlib import Path

import pandas as pd

INPUT_FILE = Path("Data/Raw/Pollution/GES_Econ_Can_Prov_Terr.csv")
OUTPUT_DIR = Path("Data/Processed/Pollution")
OUTPUT_FILE = OUTPUT_DIR / "pollution_annual.csv"

# période exigée par le projet
YEARS = [2023, 2024, 2025]

# 2025 n'est pas encore publié dans le fichier officiel au moment du projet
OFFICIAL_YEARS = [2023, 2024]

PROVINCE_CODES = {
    "Terre-Neuve-et-Labrador": "NL",
    "Île-du-Prince-Édouard": "PE",
    "Nouvelle-Écosse": "NS",
    "Nouveau-Brunswick": "NB",
    "Québec": "QC",
    "Ontario": "ON",
    "Manitoba": "MB",
    "Saskatchewan": "SK",
    "Alberta": "AB",
    "Colombie-Britannique": "BC",
    "Yukon": "YT",
    "Territoires du Nord-Ouest": "NT",
    "Nunavut": "NU",
}

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


def extract_official_data(df):
    print(f"Lignes source : {len(df)}")

    required_columns = [
        "Année", "Région", "Source", "Secteur",
        "Sous-Secteur", "Sous-sous-Secteur", "Total (kt CO2eq)",
    ]
    missing_columns = [c for c in required_columns if c not in df.columns]
    if missing_columns:
        raise ValueError("Colonnes manquantes : " + ", ".join(missing_columns))

    # on ne garde que 2023-2024 (2025 est ajouté à part, voir add_2025_rows)
    filtered = df[df["Année"].isin(OFFICIAL_YEARS)].copy()
    print(f"Lignes après filtre années 2023-2024 : {len(filtered)}")

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


def add_2025_rows(df):
    # les données provinciales consolidées de 2025 ne sont pas encore publiées par ECCC,
    # donc on garde des lignes NULL plutôt que d'inventer un chiffre
    rows_2025 = [
        {"Province": code, "Annee": 2025, "EmissionGES_MtCO2e": None}
        for code in sorted(PROVINCE_CODES.values())
    ]
    return pd.concat([df, pd.DataFrame(rows_2025)], ignore_index=True)


def validate(df):
    print()
    print("Validation")
    print("----------")
    print(f"Lignes obtenues : {len(df)}")

    expected_rows = 39  # 13 provinces x 3 années
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

    years = sorted(df["Annee"].unique())
    if years != YEARS:
        raise ValueError(f"Années incorrectes : {years}")

    counts = df.groupby("Province").size()
    if (counts != 3).any():
        raise ValueError(f"Certaines provinces n'ont pas exactement 3 années :\n{counts[counts != 3]}")

    official_data = df[df["Annee"].isin([2023, 2024])]
    if official_data["EmissionGES_MtCO2e"].isna().sum() != 0:
        raise ValueError("Des valeurs officielles 2023 ou 2024 sont manquantes.")

    data_2025 = df[df["Annee"] == 2025]
    if len(data_2025) != 13:
        raise ValueError("13 lignes attendues pour 2025.")
    if data_2025["EmissionGES_MtCO2e"].isna().sum() != 13:
        raise ValueError("Les 13 valeurs de 2025 doivent être NULL.")

    print("13 provinces/territoires : OK")
    print("Années 2023-2025 : OK")
    print("3 années par province : OK")
    print("2023 : données officielles complètes")
    print("2024 : données officielles complètes")
    print("2025 : 13 valeurs NULL (données officielles non disponibles)")
    print("39 lignes : OK")


def main():
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    source_df = read_source_file()
    annual_df = extract_official_data(source_df)
    annual_df = add_2025_rows(annual_df)
    annual_df = annual_df.sort_values(["Province", "Annee"]).reset_index(drop=True)

    validate(annual_df)

    annual_df.to_csv(OUTPUT_FILE, index=False, encoding="utf-8-sig")

    print()
    print("=" * 70)
    print("AGRÉGATION POLLUTION TERMINÉE")
    print("=" * 70)
    print(f"Fichier : {OUTPUT_FILE}")
    print()
    print("Aperçu annuel :")
    print(annual_df.to_string(index=False))


if __name__ == "__main__":
    main()
