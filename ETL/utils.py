import re
from pathlib import Path

# ex: fr_climat_sommaires_QC_01-2023.csv
CLIMATE_FILENAME_PATTERN = re.compile(
    r"fr_climat_sommaires_([A-Z]{2})_(\d{2})-(\d{4})\.csv$", re.IGNORECASE
)


def parse_climate_filename(file_path):
    filename = Path(file_path).name
    match = CLIMATE_FILENAME_PATTERN.match(filename)
    if not match:
        raise ValueError(f"Nom de fichier climatique invalide : {filename}")

    province_code = match.group(1).upper()
    month = int(match.group(2))
    year = int(match.group(3))

    if not 1 <= month <= 12:
        raise ValueError(f"Mois invalide : {month}")

    return {"province_code": province_code, "month": month, "year": year}
