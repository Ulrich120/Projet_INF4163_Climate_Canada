import pandas as pd
import pytest
from transformer import calculate_monthly_province_summary, convert_french_decimal


def test_convert_french_decimal():
    result = convert_french_decimal(pd.Series(["12,5", " -3,25 ", "abc", None]))
    assert result.iloc[0] == 12.5
    assert result.iloc[1] == -3.25
    assert pd.isna(result.iloc[2])
    assert pd.isna(result.iloc[3])


def test_monthly_summary_ignores_missing_values():
    df = pd.DataFrame({
        "Prov_ou_ter": ["QC", "QC", "QC"],
        "Tm": ["10,0", "20,0", None],
        "P": ["5,0", None, None],
    })
    summary = calculate_monthly_province_summary(df)
    assert summary["province"] == "QC"
    assert summary["temperature_moyenne"] == pytest.approx(15.0)
    assert summary["nb_stations_temperature"] == 2
    assert summary["precipitation_moyenne"] == pytest.approx(5.0)
    assert summary["nb_stations_precipitation"] == 1


def test_monthly_summary_with_no_valid_values_returns_none():
    df = pd.DataFrame({"Prov_ou_ter": ["NU"], "Tm": [None], "P": [None]})
    summary = calculate_monthly_province_summary(df)
    assert summary["temperature_moyenne"] is None
    assert summary["precipitation_moyenne"] is None
    assert summary["nb_stations_temperature"] == 0
