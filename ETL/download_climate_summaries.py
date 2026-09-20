import os
import time

import requests

OUTPUT_FOLDER = "Data/Raw/Temperature"

BASE_URL = "https://climat.meteo.gc.ca/prods_servs/cdn_climate_summary_report_f.html"

PROVINCES = ["NL", "PE", "NS", "NB", "QC", "ON", "MB", "SK", "AB", "BC", "YT", "NT", "NU"]
YEARS = [2023, 2024, 2025]
MONTHS = range(1, 13)

HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
        "(KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36 Edg/151.0.0.0"
    )
}

os.makedirs(OUTPUT_FOLDER, exist_ok=True)

download_count = 0
error_count = 0
total_files = len(PROVINCES) * len(YEARS) * len(MONTHS)

for province in PROVINCES:
    print(f"\n--- Province : {province} ---")

    for year in YEARS:
        for month in MONTHS:
            filename = f"fr_climat_sommaires_{province}_{month:02d}-{year}.csv"
            filepath = os.path.join(OUTPUT_FOLDER, filename)

            if os.path.exists(filepath):
                print("   déjà téléchargé, on passe")
                continue

            params = {
                "intYear": year,
                "intMonth": month,
                "prov": province,
                "dataFormat": "csv",
                "btnSubmit": "Télécharger des données",
            }

            current = download_count + error_count + 1
            print(f"[{current}/{total_files}] {filename}")

            try:
                response = requests.get(BASE_URL, params=params, headers=HEADERS, timeout=60)
                response.raise_for_status()

                content_type = response.headers.get("Content-Type", "")
                if "text/csv" not in content_type:
                    print(f"   réponse inattendue ({content_type}), fichier ignoré")
                    error_count += 1
                    continue

                with open(filepath, "wb") as file:
                    file.write(response.content)
                download_count += 1

            except Exception as e:
                print(f"   échec : {e}")
                error_count += 1

            time.sleep(0.5)  # pour ne pas marteler le site d'ECCC

print("\nTéléchargement terminé")
print(f"Fichiers téléchargés : {download_count}")
print(f"Erreurs : {error_count}")
