from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

DATA_DIR = BASE_DIR / "Data"
RAW_DIR = DATA_DIR / "Raw"
PROCESSED_DIR = DATA_DIR / "Processed"
SQL_DIR = DATA_DIR / "SQL"

TEMPERATURE_RAW_DIR = RAW_DIR / "Temperature"
POLLUTION_RAW_DIR = RAW_DIR / "Pollution"
PRECIPITATION_RAW_DIR = RAW_DIR / "Precipitation"

TEMPERATURE_FILE_PATTERN = "fr_climat_sommaires_*.csv"
