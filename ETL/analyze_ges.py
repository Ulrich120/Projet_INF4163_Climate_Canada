"""Analyse des émissions de GES : d'où vient la baisse nationale ?

Le total national de l'inventaire est décomposé par secteur économique (lignes « Canada » du fichier ECCC),
puis rapproché de la somme des 13 provinces et territoires de pollution_annual.csv.

Usage : python ETL/analyze_ges.py
Sorties : Data/Processed/Pollution/ges_secteurs.csv et docs/figures/ges_secteurs.png
"""

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import pandas as pd
from config import BASE_DIR, END_YEAR, POLLUTION_RAW_DIR, PROCESSED_DIR, START_YEAR

INPUT_FILE = POLLUTION_RAW_DIR / "GES_Econ_Can_Prov_Terr.csv"
PROVINCES_FILE = PROCESSED_DIR / "Pollution" / "pollution_annual.csv"
OUTPUT_FILE = PROCESSED_DIR / "Pollution" / "ges_secteurs.csv"
FIGURE_FILE = BASE_DIR / "docs" / "figures" / "ges_secteurs.png"

NATIONAL_TOTAL = "Total national de l'inventaire"
BASE_YEAR = 2005  # année de référence des engagements climatiques du Canada
LAST_YEAR = 2024  # dernière année publiée par ECCC
ELECTRICITY = "Électricité"

# les noms courts tiennent dans la légende du graphique
SHORT_NAMES = {
    "Industrie manufacturière légère, construction et exploitation forestière": "Industrie légère et construction",
}


def read_national_sectors():
    """Émissions nationales (Mt CO₂e) par secteur : lignes « Canada » sans ventilation plus fine."""
    raw = pd.read_csv(INPUT_FILE, encoding="cp1252")
    raw["Mt"] = pd.to_numeric(raw["Total (kt CO2eq)"], errors="coerce") / 1000

    national = raw[
        (raw["Région"] == "Canada")
        & raw["Secteur"].isna()
        & raw["Sous-Secteur"].isna()
        & raw["Sous-sous-Secteur"].isna()
        & raw["Année"].between(START_YEAR, END_YEAR)
    ]
    table = national.pivot_table(index="Année", columns="Source", values="Mt", aggfunc="sum")
    return table.drop(columns=["Total"], errors="ignore").rename(columns=SHORT_NAMES)


def reconcile(national_total):
    """Écart (Mt) entre le total national et la somme des provinces, pour chaque année publiée."""
    provinces = pd.read_csv(PROVINCES_FILE, encoding="utf-8-sig").dropna()
    return national_total - provinces.groupby("Annee")["EmissionGES_MtCO2e"].sum()


def decline_breakdown(sectors):
    """Variation 2005 → 2024 par secteur, avec la part de la variation nationale."""
    sectors = sectors.drop(columns=[NATIONAL_TOTAL])
    change = (sectors.loc[LAST_YEAR] - sectors.loc[BASE_YEAR]).sort_values()
    table = pd.DataFrame({
        "2005": sectors.loc[BASE_YEAR],
        "2024": sectors.loc[LAST_YEAR],
        "variation_Mt": change,
        "variation_pct": 100 * change / sectors.loc[BASE_YEAR],
    }).loc[change.index]
    table["part_de_la_variation_pct"] = 100 * table["variation_Mt"] / change.sum()
    return table


def plot_sectors(sectors, breakdown):
    fig, (left, right) = plt.subplots(1, 2, figsize=(13, 5.2), gridspec_kw={"width_ratios": [1.25, 1]})

    stacked = sectors.drop(columns=[NATIONAL_TOTAL])
    order = stacked.loc[BASE_YEAR].sort_values(ascending=False).index
    left.stackplot(stacked.index, [stacked[name] for name in order], labels=order, alpha=0.9)
    left.set_title("Émissions nationales par secteur, 2000-2024")
    left.set_ylabel("Mt CO₂e")
    left.set_xlim(START_YEAR, LAST_YEAR)
    left.axvline(2020, color="black", linewidth=0.8, linestyle=":")
    left.annotate("2020", (2020, 5), xytext=(2020.3, 5), fontsize=9)
    left.legend(loc="upper center", bbox_to_anchor=(0.5, -0.12), ncol=3, fontsize=8, frameon=False)

    colors = ["#1f6f8b" if value < 0 else "#c0392b" for value in breakdown["variation_Mt"]]
    right.barh(breakdown.index, breakdown["variation_Mt"], color=colors)
    right.axvline(0, color="black", linewidth=0.8)
    right.set_title(f"Variation {BASE_YEAR} → {LAST_YEAR} par secteur")
    right.set_xlabel("Mt CO₂e")
    for position, value in enumerate(breakdown["variation_Mt"]):
        right.text(value + (1.5 if value >= 0 else -1.5), position, f"{value:+.1f}",
                   va="center", ha="left" if value >= 0 else "right", fontsize=9)
    right.set_xlim(breakdown["variation_Mt"].min() * 1.2, breakdown["variation_Mt"].max() + 12)
    right.tick_params(axis="y", labelsize=8)

    for axis in (left, right):
        axis.spines[["top", "right"]].set_visible(False)
    fig.tight_layout()
    FIGURE_FILE.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(FIGURE_FILE, dpi=150)
    plt.close(fig)


def main():
    sectors = read_national_sectors()
    sectors.to_csv(OUTPUT_FILE, encoding="utf-8-sig", float_format="%.3f")

    total = sectors[NATIONAL_TOTAL]
    gap = reconcile(total)
    print(f"Écart total national - somme des provinces : max {gap.abs().max():.3f} Mt sur {len(gap)} années")

    breakdown = decline_breakdown(sectors)
    print(f"\nTotal national : {total[BASE_YEAR]:.1f} Mt en {BASE_YEAR}, {total[LAST_YEAR]:.1f} Mt en {LAST_YEAR} "
          f"({total[LAST_YEAR] - total[BASE_YEAR]:+.1f} Mt, {100 * (total[LAST_YEAR] / total[BASE_YEAR] - 1):+.1f} %)")
    print(breakdown.round(1).to_string())

    without_power = total - sectors[ELECTRICITY]
    print(f"\nSans l'électricité : {without_power[BASE_YEAR]:.1f} → {without_power[LAST_YEAR]:.1f} Mt "
          f"({100 * (without_power[LAST_YEAR] / without_power[BASE_YEAR] - 1):+.1f} %)")

    plot_sectors(sectors, breakdown)
    print(f"\nFigure : {FIGURE_FILE.relative_to(BASE_DIR)}")


if __name__ == "__main__":
    main()
