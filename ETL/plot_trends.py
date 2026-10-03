"""Figure de synthèse : la moyenne simple trompe, les anomalies par station corrigent."""

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import pandas as pd
from config import BASE_DIR, PROCESSED_DIR
from station_anomalies import NATIONAL

OUTPUT = BASE_DIR / "docs" / "figures" / "tendances_temperature.png"
TEMPERATURE_DIR = PROCESSED_DIR / "Temperature"

NAIVE_COLOR, ANOMALY_COLOR = "#c0392b", "#1f6f8b"


def centered(series):
    """Ramène une série à une moyenne nulle pour comparer des formes, pas des niveaux."""
    return series - series.mean()


def plot_comparison(ax, annual, province, title):
    data = annual[annual["Province"] == province].sort_values("Annee")
    ax.plot(data["Annee"], centered(data["MoyenneSimple"]), color=NAIVE_COLOR, marker="o", ms=3,
            label="Moyenne simple des stations actives")
    ax.plot(data["Annee"], centered(data["AnomalieStationsLongues"]), color=ANOMALY_COLOR, marker="o", ms=3,
            label="Anomalie (stations de longue durée)")
    ax.axhline(0, color="#888", lw=0.6)
    ax.set_title(title, fontsize=11, loc="left")
    ax.set_ylabel("Écart à la moyenne de la série (°C)")
    ax.legend(frameon=False, fontsize=8, loc="lower left")


def plot_trends(ax, trends):
    data = trends[trends["Methode"] == "anomalie_stations_longues"].copy()
    data = data.sort_values("PenteParDecennie").reset_index(drop=True)
    colors = [ANOMALY_COLOR if p == NATIONAL else "#7fb3c8" for p in data["Province"]]
    ax.hlines(data.index, data["IC95_Bas"], data["IC95_Haut"], color=colors, lw=2)
    ax.scatter(data["PenteParDecennie"], data.index, color=colors, zorder=3)
    ax.axvline(0, color="#888", lw=0.8)
    ax.set_yticks(data.index, [("Canada*" if p == NATIONAL else p) for p in data["Province"]])
    ax.set_xlabel("Tendance 2000-2025 (°C par décennie, intervalle de confiance à 95 %)")
    ax.set_title("Tendance par province, méthode par stations", fontsize=11, loc="left")


def main():
    annual = pd.read_csv(TEMPERATURE_DIR / "temperature_anomaly_annual.csv")
    trends = pd.read_csv(TEMPERATURE_DIR / "temperature_trends.csv")

    fig, axes = plt.subplots(1, 3, figsize=(17, 5), gridspec_kw={"width_ratios": [1, 1, 1.1]})
    plot_comparison(axes[0], annual, "QC", "Québec : un faux refroidissement")
    plot_comparison(axes[1], annual, NATIONAL, "Canada* : la même méthode, à l'échelle du pays")
    plot_trends(axes[2], trends)
    fig.text(0.01, 0.005, "* Moyenne des provinces à poids égaux (non pondérée par la superficie). "
             "Données : ECCC, sommaires climatiques mensuels.", fontsize=8, color="#555")
    fig.tight_layout(rect=(0, 0.03, 1, 1))

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(OUTPUT, dpi=130)
    print(OUTPUT)


if __name__ == "__main__":
    main()
