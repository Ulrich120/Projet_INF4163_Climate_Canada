from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

DATA_DIR = BASE_DIR / "Data"
RAW_DIR = DATA_DIR / "Raw"
PROCESSED_DIR = DATA_DIR / "Processed"
DATABASE_DIR = BASE_DIR / "Database"

TEMPERATURE_RAW_DIR = RAW_DIR / "Temperature"
POLLUTION_RAW_DIR = RAW_DIR / "Pollution"
PRECIPITATION_RAW_DIR = RAW_DIR / "Precipitation"

TEMPERATURE_FILE_PATTERN = "fr_climat_sommaires_*.csv"

# période couverte par le projet (v1 du cours : 2023-2025)
START_YEAR = 2000
END_YEAR = 2025
YEARS = list(range(START_YEAR, END_YEAR + 1))
