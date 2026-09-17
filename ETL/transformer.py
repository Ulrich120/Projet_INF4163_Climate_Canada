import pandas as pd

NUMERIC_COLUMNS = ["Tm", "P"]


def convert_french_decimal(series: pd.Series) -> pd.Series:
    # les fichiers ECCC utilisent la virgule comme séparateur décimal
    return pd.to_numeric(
        series.astype("string").str.strip().str.replace(",", ".", regex=False),
        errors="coerce",
    )


def clean_climate_dataframe(df: pd.DataFrame) -> pd.DataFrame:
    cleaned = df.copy()
    for column in NUMERIC_COLUMNS:
        if column in cleaned.columns:
            cleaned[column] = convert_french_decimal(cleaned[column])
    return cleaned


def calculate_monthly_province_summary(df: pd.DataFrame) -> dict:
    cleaned = clean_climate_dataframe(df)

    has_province = "Prov_ou_ter" in cleaned.columns and not cleaned["Prov_ou_ter"].dropna().empty
    province = cleaned["Prov_ou_ter"].dropna().iloc[0] if has_province else None

    temperature_valid = cleaned["Tm"].dropna()
    precipitation_valid = cleaned["P"].dropna()

    return {
        "province": province,
        "temperature_moyenne": temperature_valid.mean() if not temperature_valid.empty else None,
        "nb_stations_temperature": len(temperature_valid),
        "precipitation_moyenne": precipitation_valid.mean() if not precipitation_valid.empty else None,
        "nb_stations_precipitation": len(precipitation_valid),
    }
