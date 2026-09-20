import pytest
from utils import parse_climate_filename


def test_parse_valid_filename():
    meta = parse_climate_filename("fr_climat_sommaires_QC_01-2023.csv")
    assert meta == {"province_code": "QC", "month": 1, "year": 2023}


def test_parse_is_case_insensitive_and_uppercases_province():
    assert parse_climate_filename("fr_climat_sommaires_qc_12-2024.csv")["province_code"] == "QC"


def test_parse_accepts_full_path():
    assert parse_climate_filename("Data/Raw/Temperature/fr_climat_sommaires_ON_06-2025.csv")["month"] == 6


def test_parse_rejects_bad_name():
    with pytest.raises(ValueError):
        parse_climate_filename("nimporte_quoi.csv")


def test_parse_rejects_invalid_month():
    with pytest.raises(ValueError):
        parse_climate_filename("fr_climat_sommaires_QC_13-2023.csv")
