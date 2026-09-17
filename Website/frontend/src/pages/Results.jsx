import { useEffect, useState } from "react";

import api from "../api/api";

function Results() {
  const [temperature, setTemperature] = useState(null);
  const [precipitation, setPrecipitation] = useState(null);
  const [pollution, setPollution] = useState(null);

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const loadResults = async () => {
      try {
        const [temperatureResponse, precipitationResponse, pollutionResponse] =
          await Promise.all([
            api.get("/api/results/temperature"),
            api.get("/api/results/precipitation"),
            api.get("/api/results/pollution"),
          ]);

        setTemperature(temperatureResponse.data);
        setPrecipitation(precipitationResponse.data);
        setPollution(pollutionResponse.data);
      } catch (err) {
        console.error(err);
        setError(
          "Impossible de charger les résultats des procédures stockées.",
        );
      } finally {
        setLoading(false);
      }
    };

    loadResults();
  }, []);

  const findResult = (items, phrase) => {
    const list = items?.flat() || [];

    return list.find((item) =>
      item.Resultat?.toLowerCase().includes(phrase.toLowerCase()),
    );
  };

  if (loading) {
    return (
      <div className="text-center py-5">
        <div className="spinner-border text-success" />
        <p className="mt-3">Exécution des procédures stockées...</p>
      </div>
    );
  }

  const hottestYear = findResult(temperature?.annees, "plus chaude");

  const coldestYear = findResult(temperature?.annees, "moins chaude");

  const hottestProvince = findResult(temperature?.provinces, "plus chaude");

  const coldestProvince = findResult(temperature?.provinces, "moins chaude");

  const wettestYear = findResult(precipitation?.annees, "plus pluvieuse");

  const driestYear = findResult(precipitation?.annees, "moins pluvieuse");

  const wettestProvince = findResult(
    precipitation?.provinces,
    "plus pluvieuse",
  );

  const driestProvince = findResult(
    precipitation?.provinces,
    "moins pluvieuse",
  );

  const mostPollutedYear = findResult(pollution?.annees, "plus polluee");

  const leastPollutedYear = findResult(pollution?.annees, "moins polluee");

  const mostPollutedProvince = findResult(pollution?.provinces, "plus polluee");

  const leastPollutedProvince = findResult(
    pollution?.provinces,
    "moins polluee",
  );

  return (
    <div>
      <div className="mb-4">
        <h1 className="page-title mb-2">
          <i className="bi bi-trophy-fill text-warning me-2"></i>
          Résultats des analyses
        </h1>

        <p className="page-subtitle mb-0">
          Résultats obtenus directement à partir des procédures stockées SQL
          Server.
        </p>
      </div>

      {error && <div className="alert alert-danger">{error}</div>}

      {/* Température */}

      <div className="section-card mb-4">
        <div className="section-header temperature">
          <i className="bi bi-thermometer-high me-2"></i>
          Température
        </div>

        <div className="p-4">
          <div className="row g-4">
            <div className="col-md-6 col-xl-3">
              <ResultCard
                icon="bi-fire"
                title="Année la plus chaude"
                mainValue={hottestYear?.Annee}
                secondaryValue={
                  hottestYear ? `${hottestYear.TemperatureMoyenne} °C` : "--"
                }
                type="hot"
              />
            </div>

            <div className="col-md-6 col-xl-3">
              <ResultCard
                icon="bi-snow"
                title="Année la moins chaude"
                mainValue={coldestYear?.Annee}
                secondaryValue={
                  coldestYear ? `${coldestYear.TemperatureMoyenne} °C` : "--"
                }
                type="cold"
              />
            </div>

            <div className="col-md-6 col-xl-3">
              <ResultCard
                icon="bi-geo-alt-fill"
                title="Province la plus chaude"
                mainValue={hottestProvince?.CodeProvince}
                secondaryValue={
                  hottestProvince
                    ? `${hottestProvince.NomProvince} — ${hottestProvince.TemperatureMoyenne} °C`
                    : "--"
                }
                type="hot"
              />
            </div>

            <div className="col-md-6 col-xl-3">
              <ResultCard
                icon="bi-snow2"
                title="Province la moins chaude"
                mainValue={coldestProvince?.CodeProvince}
                secondaryValue={
                  coldestProvince
                    ? `${coldestProvince.NomProvince} — ${coldestProvince.TemperatureMoyenne} °C`
                    : "--"
                }
                type="cold"
              />
            </div>
          </div>
        </div>
      </div>

      {/* Précipitations */}

      <div className="section-card mb-4">
        <div className="section-header rain">
          <i className="bi bi-cloud-rain-heavy me-2"></i>
          Précipitations
        </div>

        <div className="p-4">
          <div className="row g-4">
            <div className="col-md-6 col-xl-3">
              <ResultCard
                icon="bi-cloud-rain-heavy"
                title="Année la plus pluvieuse"
                mainValue={wettestYear?.Annee}
                secondaryValue={
                  wettestYear
                    ? `${wettestYear.PrecipitationMoyenne_mm} mm`
                    : "--"
                }
                type="rain"
              />
            </div>

            <div className="col-md-6 col-xl-3">
              <ResultCard
                icon="bi-sun-fill"
                title="Année la moins pluvieuse"
                mainValue={driestYear?.Annee}
                secondaryValue={
                  driestYear ? `${driestYear.PrecipitationMoyenne_mm} mm` : "--"
                }
                type="dry"
              />
            </div>

            <div className="col-md-6 col-xl-3">
              <ResultCard
                icon="bi-droplet-fill"
                title="Province la plus pluvieuse"
                mainValue={wettestProvince?.CodeProvince}
                secondaryValue={
                  wettestProvince
                    ? `${wettestProvince.NomProvince} — ${wettestProvince.PrecipitationMoyenne_mm} mm`
                    : "--"
                }
                type="rain"
              />
            </div>

            <div className="col-md-6 col-xl-3">
              <ResultCard
                icon="bi-brightness-high-fill"
                title="Province la moins pluvieuse"
                mainValue={driestProvince?.CodeProvince}
                secondaryValue={
                  driestProvince
                    ? `${driestProvince.NomProvince} — ${driestProvince.PrecipitationMoyenne_mm} mm`
                    : "--"
                }
                type="dry"
              />
            </div>
          </div>
        </div>
      </div>

      {/* Pollution */}

      <div className="section-card">
        <div className="section-header pollution">
          <i className="bi bi-cloud-haze2-fill me-2"></i>
          Pollution
        </div>

        <div className="p-4">
          <div className="row g-4">
            <div className="col-md-6 col-xl-3">
              <ResultCard
                icon="bi-cloud-haze2"
                title="Année la plus polluée"
                mainValue={mostPollutedYear?.Annee}
                secondaryValue={
                  mostPollutedYear
                    ? `${mostPollutedYear.EmissionMoyenne_MtCO2e} Mt CO₂e`
                    : "--"
                }
                type="polluted"
              />
            </div>

            <div className="col-md-6 col-xl-3">
              <ResultCard
                icon="bi-leaf-fill"
                title="Année la moins polluée"
                mainValue={leastPollutedYear?.Annee}
                secondaryValue={
                  leastPollutedYear
                    ? `${leastPollutedYear.EmissionMoyenne_MtCO2e} Mt CO₂e`
                    : "--"
                }
                type="green"
              />
            </div>

            <div className="col-md-6 col-xl-3">
              <ResultCard
                icon="bi-building-fill"
                title="Province la plus polluée"
                mainValue={mostPollutedProvince?.CodeProvince}
                secondaryValue={
                  mostPollutedProvince
                    ? `${mostPollutedProvince.NomProvince} — ${mostPollutedProvince.EmissionMoyenne_MtCO2e} Mt CO₂e`
                    : "--"
                }
                type="polluted"
              />
            </div>

            <div className="col-md-6 col-xl-3">
              <ResultCard
                icon="bi-tree-fill"
                title="Province la moins polluée"
                mainValue={leastPollutedProvince?.CodeProvince}
                secondaryValue={
                  leastPollutedProvince
                    ? `${leastPollutedProvince.NomProvince} — ${leastPollutedProvince.EmissionMoyenne_MtCO2e} Mt CO₂e`
                    : "--"
                }
                type="green"
              />
            </div>
          </div>

          <div className="alert alert-warning border-0 mt-4 mb-0">
            <i className="bi bi-info-circle-fill me-2"></i>
            Les résultats de pollution pour 2025 ne sont pas inclus dans les
            moyennes, puisque les données officielles provinciales ne sont pas
            encore publiées.
          </div>
        </div>
      </div>
    </div>
  );
}

function ResultCard({ icon, title, mainValue, secondaryValue, type }) {
  const styles = {
    hot: {
      background: "#fff1f2",
      border: "#fecdd3",
      color: "#dc2626",
    },

    cold: {
      background: "#eff6ff",
      border: "#bfdbfe",
      color: "#2563eb",
    },

    rain: {
      background: "#eff6ff",
      border: "#bae6fd",
      color: "#0284c7",
    },

    dry: {
      background: "#fff7ed",
      border: "#fed7aa",
      color: "#ea580c",
    },

    polluted: {
      background: "#fff1f2",
      border: "#fecaca",
      color: "#b91c1c",
    },

    green: {
      background: "#f0fdf4",
      border: "#bbf7d0",
      color: "#15803d",
    },
  };

  const style = styles[type] || styles.green;

  return (
    <div
      className="h-100 rounded-4 p-4"
      style={{
        background: style.background,
        border: `1px solid ${style.border}`,
      }}
    >
      <div
        className="d-flex align-items-center justify-content-center rounded-circle mb-3"
        style={{
          width: "48px",
          height: "48px",
          color: "white",
          background: style.color,
          fontSize: "1.25rem",
        }}
      >
        <i className={`bi ${icon}`}></i>
      </div>

      <div className="small text-muted mb-2">{title}</div>

      <div className="fs-2 fw-bold mb-2" style={{ color: style.color }}>
        {mainValue ?? "--"}
      </div>

      <div className="small">{secondaryValue}</div>
    </div>
  );
}

export default Results;
