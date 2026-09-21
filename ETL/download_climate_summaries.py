"""Télécharge les sommaires climatiques mensuels d'ECCC (un CSV par province/mois/année).

Usage : python ETL/download_climate_summaries.py [--reverse]

Les fichiers déjà présents sont ignorés : on peut relancer le script après une coupure.
"""

import os
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

import requests
from config import TEMPERATURE_RAW_DIR, YEARS
from reference import PROVINCE_CODES

BASE_URL = "https://climat.meteo.gc.ca/prods_servs/cdn_climate_summary_report_f.html"
HEADERS = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/120 Safari/537.36"}

WORKERS = 4  # on reste poli avec le serveur d'ECCC
RETRIES = 3


def target_path(province, year, month):
    return TEMPERATURE_RAW_DIR / f"fr_climat_sommaires_{province}_{month:02d}-{year}.csv"


def download_one(province, year, month):
    params = {
        "intYear": year,
        "intMonth": month,
        "prov": province,
        "dataFormat": "csv",
        "btnSubmit": "Télécharger des données",
    }

    last_error = None
    for attempt in range(1, RETRIES + 1):
        try:
            response = requests.get(BASE_URL, params=params, headers=HEADERS, timeout=60)
            response.raise_for_status()
            if "text/csv" not in response.headers.get("Content-Type", ""):
                raise ValueError(f"réponse inattendue : {response.headers.get('Content-Type')}")

            path = target_path(province, year, month)
            tmp = path.with_suffix(f".{os.getpid()}.part")
            tmp.write_bytes(response.content)
            tmp.replace(path)  # écriture atomique : pas de fichier à moitié écrit
            return None
        except Exception as error:
            last_error = error
            time.sleep(2 * attempt)

    return f"{province} {month:02d}-{year} : {last_error}"


def main():
    TEMPERATURE_RAW_DIR.mkdir(parents=True, exist_ok=True)

    todo = [
        (province, year, month)
        for year in YEARS
        for province in PROVINCE_CODES
        for month in range(1, 13)
        if not target_path(province, year, month).exists()
    ]
    if "--reverse" in sys.argv:  # pour lancer un second processus qui part de la fin
        todo.reverse()
    total = len(YEARS) * len(PROVINCE_CODES) * 12
    print(f"{total - len(todo)}/{total} fichiers déjà présents, {len(todo)} à télécharger")

    errors = []
    with ThreadPoolExecutor(max_workers=WORKERS) as pool:
        futures = [pool.submit(download_one, *task) for task in todo]
        for done, future in enumerate(as_completed(futures), start=1):
            error = future.result()
            if error:
                errors.append(error)
            if done % 100 == 0 or done == len(todo):
                print(f"[{done}/{len(todo)}] erreurs : {len(errors)}", flush=True)

    print("\nTéléchargement terminé")
    for error in errors:
        print(f"  échec : {error}")


if __name__ == "__main__":
    main()
