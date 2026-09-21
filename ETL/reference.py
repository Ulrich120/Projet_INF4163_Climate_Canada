"""Données de référence partagées par les trois bases (mêmes IDs dans chacune)."""

# l'ordre fixe les ProvinceID (1..13) dans les trois bases
PROVINCES = [
    ("NL", "Terre-Neuve-et-Labrador"),
    ("PE", "Île-du-Prince-Édouard"),
    ("NS", "Nouvelle-Écosse"),
    ("NB", "Nouveau-Brunswick"),
    ("QC", "Québec"),
    ("ON", "Ontario"),
    ("MB", "Manitoba"),
    ("SK", "Saskatchewan"),
    ("AB", "Alberta"),
    ("BC", "Colombie-Britannique"),
    ("YT", "Yukon"),
    ("NT", "Territoires du Nord-Ouest"),
    ("NU", "Nunavut"),
]

PROVINCE_CODES = [code for code, _ in PROVINCES]
PROVINCE_NAME_TO_CODE = {name: code for code, name in PROVINCES}

SOURCE_NAME = "Environnement et Changement climatique Canada"
SOURCE_URL = "https://climate.weather.gc.ca/"
SOURCE_DESCRIPTION = (
    "Données climatiques historiques officielles du Canada : températures, "
    "précipitations et émissions de gaz à effet de serre par province."
)


def reference_sql(years, with_source=False):
    """Lignes SQL qui remplissent Province, Annee (et SourceDonnee) si elles sont vides."""
    province_values = ",\n".join(f"    ('{code}', N'{name}')" for code, name in PROVINCES)
    year_values = ",\n".join(f"    ({year})" for year in sorted(years))

    lines = [
        "IF NOT EXISTS (SELECT 1 FROM Province)",
        "    INSERT INTO Province (CodeProvince, NomProvince) VALUES",
        province_values + ";",
        "",
        "IF NOT EXISTS (SELECT 1 FROM Annee)",
        "    INSERT INTO Annee (ValeurAnnee) VALUES",
        year_values + ";",
        "",
    ]

    if with_source:
        lines += [
            "IF NOT EXISTS (SELECT 1 FROM SourceDonnee)",
            "    INSERT INTO SourceDonnee (NomSource, AdresseWeb, DateConsultation, DescriptionSource)",
            f"    VALUES (N'{SOURCE_NAME}', N'{SOURCE_URL}', CAST(GETDATE() AS DATE), N'{SOURCE_DESCRIPTION}');",
            "",
        ]

    return lines
