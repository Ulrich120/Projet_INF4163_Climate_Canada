"""Figures de synthèse : la moyenne simple trompe, les anomalies par station corrigent.

Usage : python ETL/plot_trends.py [temperature|precipitation]   (sans argument : les deux)
"""

import sys
from dataclasses import dataclass

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import pandas as pd
from config import BASE_DIR, PROCESSED_DIR
from station_anomalies import NATIONAL

FIGURES_DIR = BASE_DIR / "docs" / "figures"
NAIVE_COLOR, ANOMALY_COLOR = "#c0392b", "#1f6f8b"


@dataclass(frozen=True)
class Figure:
    name: str
    folder: str
    output: str
    naive_label: str
    anomaly_label: str
    ylabel: str
    xlabel: str
    left_title: str
    relative: bool  # la valeur simple est en mm : on la ramène en % de sa moyenne pour comparer les formes


FIGURES = {
    "temperature": Figure(
        "temperature", "Temperature", "tendances_temperature.png",
        "Moyenne simple des stations actives", "Anomalie (stations de longue durée)",
        "Écart à la moyenne de la série (°C)",
        "Tendance 2000-2025 (°C par décennie, intervalle de confiance à 95 %)",
        "Québec : un faux refroidissement", relative=False,
    ),
    "precipitation": Figure(
        "precipitation", "Precipitation", "tendances_precipitations.png",
        "Cumul simple des stations actives", "Anomalie (stations de longue durée)",
        "Écart à la moyenne de la série (%)",
        "Tendance 2000-2025 (% de la normale par décennie, intervalle de confiance à 95 %)",
        "Québec : une baisse apparente, sans tendance", relative=True,
    ),
}


def centered(series, relative):
    """Ramène une série à une moyenne nulle pour comparer des formes, pas des niveaux."""
    if relative:
        return (series / series.mean() - 1) * 100
    return series - series.mean()


def plot_comparison(ax, annual, province, title, figure):
    data = annual[annual["Province"] == province].sort_values("Annee")
    ax.plot(data["Annee"], centered(data["MoyenneSimple"], figure.relative), color=NAIVE_COLOR, marker="o", ms=3,
            label=figure.naive_label)
    ax.plot(data["Annee"], centered(data["AnomalieStationsLongues"], relative=False), color=ANOMALY_COLOR,
            marker="o", ms=3, label=figure.anomaly_label)
    ax.axhline(0, color="#888", lw=0.6)
    ax.set_title(title, fontsize=11, loc="left")
    ax.set_ylabel(figure.ylabel)
    ax.legend(frameon=False, fontsize=8, loc="lower left")


def plot_trends(ax, trends, figure):
    data = trends[trends["Methode"] == "anomalie_stations_longues"].dropna(subset=["PenteParDecennie"])
    data = data.sort_values("PenteParDecennie").reset_index(drop=True)
    colors = [ANOMALY_COLOR if p == NATIONAL else "#7fb3c8" for p in data["Province"]]
    ax.hlines(data.index, data["IC95_Bas"], data["IC95_Haut"], color=colors, lw=2)
    ax.scatter(data["PenteParDecennie"], data.index, color=colors, zorder=3)
    ax.axvline(0, color="#888", lw=0.8)
    ax.set_yticks(data.index, [("Canada*" if p == NATIONAL else p) for p in data["Province"]])
    ax.set_xlabel(figure.xlabel, fontsize=9)
    ax.set_title("Tendance par province, méthode par stations", fontsize=11, loc="left")


def draw(figure):
    directory = PROCESSED_DIR / figure.folder
    annual = pd.read_csv(directory / f"{figure.name}_anomaly_annual.csv")
    trends = pd.read_csv(directory / f"{figure.name}_trends.csv")

    long_method = trends[trends["Methode"] == "anomalie_stations_longues"]
    missing = sorted(long_method[long_method["PenteParDecennie"].isna()]["Province"])

    fig, axes = plt.subplots(1, 3, figsize=(17, 5), gridspec_kw={"width_ratios": [1, 1, 1.1]})
    plot_comparison(axes[0], annual, "QC", figure.left_title, figure)
    plot_comparison(axes[1], annual, NATIONAL, "Canada* : la même méthode, à l'échelle du pays", figure)
    plot_trends(axes[2], trends, figure)

    note = ("* Moyenne des provinces à poids égaux (non pondérée par la superficie). "
            "Données : ECCC, sommaires climatiques mensuels.")
    if missing:
        note += f" Sans station de longue durée, non tracé : {', '.join(missing)}."
    fig.text(0.01, 0.005, note, fontsize=8, color="#555")
    fig.tight_layout(rect=(0, 0.03, 1, 1))

    FIGURES_DIR.mkdir(parents=True, exist_ok=True)
    fig.savefig(FIGURES_DIR / figure.output, dpi=130)
    plt.close(fig)
    print(FIGURES_DIR / figure.output)


def main():
    for name in sys.argv[1:] or list(FIGURES):
        draw(FIGURES[name])


if __name__ == "__main__":
    main()
