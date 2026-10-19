"""Mode démonstration : équivalents des procédures stockées T-SQL (Database/Procedures/stored_procedures.sql).

Les bases SQLite du mode démonstration (ETL/build_demo_db.py) n'ont pas de procédures stockées : chaque procédure
est réécrite ici, avec les mêmes noms de colonnes, le même tri et les mêmes arrondis (calcul en Decimal, comme
l'arithmétique décimale de SQL Server). deploy/compare_backends.py vérifie que les deux modes répondent pareil.
"""

from decimal import ROUND_HALF_UP, Decimal


def _dec(value):
    return Decimal(str(value))


def _rounded(value, places=2):
    return float(value.quantize(Decimal(1).scaleb(-places), rounding=ROUND_HALF_UP))


def _national_years(connection, table, high, low, column):
    """Meilleure et pire année selon l'anomalie nationale (ProvinceID NULL), égalité : année la plus ancienne."""
    rows = connection.execute(
        f"""
        SELECT a.ValeurAnnee, t.AnomalieStationsLongues
        FROM {table} t INNER JOIN Annee a ON t.AnneeID = a.AnneeID
        WHERE t.ProvinceID IS NULL AND t.AnomalieStationsLongues IS NOT NULL
        """
    ).fetchall()
    best = max(rows, key=lambda row: (_dec(row[1]), -row[0]))
    worst = min(rows, key=lambda row: (_dec(row[1]), row[0]))
    return [
        [{"Resultat": high, "Annee": best[0], column: _rounded(_dec(best[1]))}],
        [{"Resultat": low, "Annee": worst[0], column: _rounded(_dec(worst[1]))}],
    ]


def _province_averages(connection, table, value_column):
    """Moyenne par province sur toutes les années renseignées : [(code, nom, moyenne, nombre d'années)]."""
    rows = connection.execute(
        f"""
        SELECT p.CodeProvince, p.NomProvince, t.{value_column}
        FROM {table} t INNER JOIN Province p ON t.ProvinceID = p.ProvinceID
        WHERE t.{value_column} IS NOT NULL
        """
    ).fetchall()
    grouped = {}
    for code, name, value in rows:
        grouped.setdefault((code, name), []).append(_dec(value))
    return [(code, name, sum(values) / len(values), len(values)) for (code, name), values in grouped.items()]


def _province_extremes(connection, table, value_column, high, low, output_column, count_column=None):
    averages = _province_averages(connection, table, value_column)
    best = min(averages, key=lambda item: (-item[2], item[0]))
    worst = min(averages, key=lambda item: (item[2], item[0]))

    def row(label, item):
        result = {"Resultat": label, "CodeProvince": item[0], "NomProvince": item[1], output_column: _rounded(item[2])}
        if count_column:
            result[count_column] = item[3]
        return result

    return [[row(high, best)], [row(low, worst)]]


def _pollution_years(connection):
    rows = connection.execute(
        """
        SELECT a.ValeurAnnee, t.EmissionGES_MtCO2e
        FROM Pollution t INNER JOIN Annee a ON t.AnneeID = a.AnneeID
        WHERE t.EmissionGES_MtCO2e IS NOT NULL
        """
    ).fetchall()
    grouped = {}
    for year, value in rows:
        grouped.setdefault(year, []).append(_dec(value))
    averages = [(year, sum(values) / len(values), len(values)) for year, values in grouped.items()]
    best = min(averages, key=lambda item: (-item[1], item[0]))
    worst = min(averages, key=lambda item: (item[1], item[0]))

    def row(label, item):
        return {"Resultat": label, "Annee": item[0], "EmissionMoyenne_MtCO2e": _rounded(item[1]),
                "NombreValeursDisponibles": item[2]}

    return [[row("Annee la plus polluee", best)], [row("Annee la moins polluee", worst)]]


PROCEDURES = {
    "sp_AnneePlusMoinsChaude": lambda c: _national_years(
        c, "TemperatureAnomalie", "Annee la plus chaude", "Annee la moins chaude", "AnomalieMoyenne"),
    "sp_ProvincePlusMoinsChaude": lambda c: _province_extremes(
        c, "Temperature", "TemperatureMoyenne", "Province la plus chaude", "Province la moins chaude",
        "TemperatureMoyenne"),
    "sp_AnneePlusMoinsPluvieuse": lambda c: _national_years(
        c, "PrecipitationAnomalie", "Annee la plus pluvieuse", "Annee la moins pluvieuse", "AnomalieMoyenne_pct"),
    "sp_ProvincePlusMoinsPluvieuse": lambda c: _province_extremes(
        c, "Precipitation", "PrecipitationAnnuelle", "Province la plus pluvieuse", "Province la moins pluvieuse",
        "PrecipitationMoyenne_mm"),
    "sp_AnneePlusMoinsPolluee": _pollution_years,
    "sp_ProvincePlusMoinsPolluee": lambda c: _province_extremes(
        c, "Pollution", "EmissionGES_MtCO2e", "Province la plus polluee", "Province la moins polluee",
        "EmissionMoyenne_MtCO2e", count_column="NombreAnneesDisponibles"),
}


def run_procedure(connection, procedure_name):
    """Même forme que les résultats multiples d'une procédure SQL Server : une liste de listes de lignes."""
    return PROCEDURES[procedure_name](connection)
