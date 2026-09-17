import { useEffect, useMemo, useState } from "react";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  Tooltip,
  Legend,
  Filler,
} from "chart.js";
import { Line, Bar } from "react-chartjs-2";

import api from "../api/api";

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  Tooltip,
  Legend,
  Filler,
);

function Pollution() {
  const [data, setData] = useState([]);
  const [results, setResults] = useState(null);
  const [selectedProvince, setSelectedProvince] = useState("QC");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const loadData = async () => {
      try {
        const [dataResponse, resultsResponse] = await Promise.all([
          api.get("/api/pollution"),
          api.get("/api/results/pollution"),
        ]);

        setData(dataResponse.data);
        setResults(resultsResponse.data);
      } catch (err) {
        console.error(err);
        setError("Impossible de charger les données de pollution.");
      } finally {
        setLoading(false);
      }
    };

    loadData();
  }, []);

  const provinces = useMemo(() => {
    return [...new Set(data.map((item) => item.province))].sort();
  }, [data]);

  const provinceData = useMemo(() => {
    return data
      .filter((item) => item.province === selectedProvince)
      .sort((a, b) => a.annee - b.annee);
  }, [data, selectedProvince]);

  const selectedProvinceName = provinceData[0]?.nomProvince || selectedProvince;

  const getValue = (year) => {
    const row = provinceData.find((item) => item.annee === year);

    if (!row || row.emission === null || row.emission === undefined) {
      return null;
    }

    return Number(row.emission);
  };

  const emission2023 = getValue(2023);
  const emission2024 = getValue(2024);
  const emission2025 = getValue(2025);

  const variation =
    emission2023 !== null && emission2024 !== null
      ? (emission2024 - emission2023).toFixed(2)
      : "--";

  const annualAverages = useMemo(() => {
    return [2023, 2024, 2025].map((year) => {
      const values = data
        .filter((item) => item.annee === year)
        .map((item) => item.emission)
        .filter(
          (value) =>
            value !== null &&
            value !== undefined &&
            !Number.isNaN(Number(value)),
        )
        .map(Number);

      const average =
        values.length > 0
          ? values.reduce((sum, value) => sum + value, 0) / values.length
          : null;

      return {
        year,
        average,
      };
    });
  }, [data]);

  const lineChartData = {
    labels: provinceData.map((item) => item.annee),
    datasets: [
      {
        label: `Émissions GES — ${selectedProvince}`,
        data: provinceData.map((item) =>
          item.emission === null ? null : Number(item.emission),
        ),
        borderColor: "#16a34a",
        backgroundColor: "rgba(34,197,94,0.16)",
        pointBackgroundColor: "#ffffff",
        pointBorderColor: "#16a34a",
        pointBorderWidth: 3,
        pointRadius: 6,
        pointHoverRadius: 8,
        spanGaps: false,
        fill: true,
        tension: 0.35,
      },
    ],
  };

  const annualChartData = {
    labels: annualAverages.map((item) => item.year),
    datasets: [
      {
        label: "Émissions moyennes nationales",
        data: annualAverages.map((item) =>
          item.average !== null ? Number(item.average.toFixed(2)) : null,
        ),
        backgroundColor: [
          "rgba(34,197,94,0.62)",
          "rgba(22,163,74,0.78)",
          "rgba(148,163,184,0.45)",
        ],
        borderRadius: 8,
      },
    ],
  };

  const chartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    interaction: {
      intersect: false,
      mode: "index",
    },
    plugins: {
      legend: {
        position: "top",
        labels: {
          usePointStyle: true,
          boxWidth: 10,
        },
      },
      tooltip: {
        callbacks: {
          label: (context) => {
            if (context.raw === null) {
              return "Donnée non disponible";
            }

            return `${context.dataset.label}: ${context.raw} Mt CO₂e`;
          },
        },
      },
    },
    scales: {
      x: {
        grid: {
          color: "rgba(148,163,184,0.12)",
        },
      },
      y: {
        grid: {
          color: "rgba(148,163,184,0.16)",
        },
      },
    },
  };

  const annualResults = results?.annees?.flat() || [];
  const provinceResults = results?.provinces?.flat() || [];

  const mostPollutedYear = annualResults.find((item) =>
    item.Resultat?.toLowerCase().includes("plus polluee"),
  );

  const leastPollutedYear = annualResults.find((item) =>
    item.Resultat?.toLowerCase().includes("moins polluee"),
  );

  const mostPollutedProvince = provinceResults.find((item) =>
    item.Resultat?.toLowerCase().includes("plus polluee"),
  );

  const leastPollutedProvince = provinceResults.find((item) =>
    item.Resultat?.toLowerCase().includes("moins polluee"),
  );

  if (loading) {
    return (
      <div className="text-center py-5">
        <div className="spinner-border text-success" />
        <p className="mt-3">Chargement des émissions...</p>
      </div>
    );
  }

  return (
    <div>
      <div className="d-flex flex-wrap justify-content-between align-items-end mb-4 gap-3">
        <div>
          <h1 className="page-title mb-2">
            <i className="bi bi-cloud-haze2 text-success me-2"></i>
            Pollution
          </h1>

          <p className="page-subtitle mb-0">
            Émissions annuelles de gaz à effet de serre en Mt CO₂e — 2023 à 2025
          </p>
        </div>

        <div className="dashboard-card p-3" style={{ minWidth: "260px" }}>
          <label className="form-label fw-semibold text-success">
            Province / territoire
          </label>

          <select
            className="form-select dashboard-select"
            value={selectedProvince}
            onChange={(event) => setSelectedProvince(event.target.value)}
          >
            {provinces.map((province) => (
              <option key={province} value={province}>
                {province}
              </option>
            ))}
          </select>
        </div>
      </div>

      {error && <div className="alert alert-danger">{error}</div>}

      <div className="alert alert-warning shadow-sm border-0">
        <i className="bi bi-info-circle-fill me-2"></i>
        Les données officielles provinciales de GES pour 2025 ne sont pas encore
        disponibles. Elles sont affichées comme non disponibles.
      </div>

      <div className="row g-4 mb-4">
        <div className="col-md-4">
          <div className="card kpi-card pollution">
            <div className="card-body p-4">
              <div className="d-flex align-items-center gap-3">
                <div className="kpi-icon pollution">
                  <i className="bi bi-cloud-haze2"></i>
                </div>

                <div>
                  <div className="fw-semibold text-success">Émissions 2024</div>

                  <div className="small text-muted">
                    {selectedProvince} - {selectedProvinceName}
                  </div>

                  <div className="kpi-value mt-2 text-success">
                    {emission2024?.toFixed(2) ?? "--"} Mt
                  </div>

                  <div className="small text-muted mt-1">Mt CO₂e</div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="col-md-4">
          <div className="card kpi-card rain">
            <div className="card-body p-4">
              <div className="d-flex align-items-center gap-3">
                <div className="kpi-icon rain">
                  <i className="bi bi-arrow-left-right"></i>
                </div>

                <div>
                  <div className="fw-semibold text-primary">
                    Variation 2023 → 2024
                  </div>

                  <div className="small text-muted">
                    {selectedProvince} - {selectedProvinceName}
                  </div>

                  <div className="kpi-value mt-2 text-primary">
                    {variation} Mt
                  </div>

                  <div className="small text-muted mt-1">
                    Évolution annuelle
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="col-md-4">
          <div className="card kpi-card temperature">
            <div className="card-body p-4">
              <div className="d-flex align-items-center gap-3">
                <div
                  className="kpi-icon"
                  style={{
                    background: "linear-gradient(135deg,#64748b,#94a3b8)",
                  }}
                >
                  <i className="bi bi-calendar-x"></i>
                </div>

                <div>
                  <div className="fw-semibold text-secondary">
                    Émissions 2025
                  </div>

                  <div className="small text-muted">
                    {selectedProvince} - {selectedProvinceName}
                  </div>

                  <div className="kpi-value mt-2 text-secondary">
                    {emission2025 === null
                      ? "N/D"
                      : `${emission2025.toFixed(2)} Mt`}
                  </div>

                  <div className="small text-muted mt-1">
                    Donnée officielle non publiée
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="row g-4 mb-4">
        <div className="col-lg-6">
          <div className="section-card h-100">
            <div className="section-header pollution">
              <i className="bi bi-graph-up me-2"></i>
              Évolution — {selectedProvince} - {selectedProvinceName}
            </div>

            <div className="p-4" style={{ height: "370px" }}>
              <Line data={lineChartData} options={chartOptions} />
            </div>
          </div>
        </div>

        <div className="col-lg-6">
          <div className="section-card h-100">
            <div
              className="section-header"
              style={{
                background: "linear-gradient(90deg,#15803d,#84cc16)",
              }}
            >
              <i className="bi bi-bar-chart me-2"></i>
              Moyenne nationale par année
            </div>

            <div className="p-4" style={{ height: "370px" }}>
              <Bar data={annualChartData} options={chartOptions} />
            </div>
          </div>
        </div>
      </div>

      <div className="row g-4 mb-4">
        <div className="col-lg-6">
          <div className="section-card h-100">
            <div className="section-header pollution">
              <i className="bi bi-calendar3 me-2"></i>
              Résultats par année
            </div>

            <div className="p-4">
              {mostPollutedYear && (
                <div className="result-item result-hot d-flex justify-content-between align-items-center">
                  <div className="fw-bold">
                    <i className="bi bi-cloud-haze2 me-2 text-danger"></i>
                    Année la plus polluée
                  </div>

                  <div className="text-end">
                    <div className="fw-bold text-danger">
                      {mostPollutedYear.Annee}
                    </div>

                    <div>{mostPollutedYear.EmissionMoyenne_MtCO2e} Mt CO₂e</div>
                  </div>
                </div>
              )}

              {leastPollutedYear && (
                <div className="result-item result-green d-flex justify-content-between align-items-center">
                  <div className="fw-bold">
                    <i className="bi bi-leaf me-2 text-success"></i>
                    Année la moins polluée
                  </div>

                  <div className="text-end">
                    <div className="fw-bold text-success">
                      {leastPollutedYear.Annee}
                    </div>

                    <div>
                      {leastPollutedYear.EmissionMoyenne_MtCO2e} Mt CO₂e
                    </div>
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>

        <div className="col-lg-6">
          <div className="section-card h-100">
            <div className="section-header purple">
              <i className="bi bi-map me-2"></i>
              Résultats par province
            </div>

            <div className="p-4">
              {mostPollutedProvince && (
                <div className="result-item result-hot d-flex justify-content-between align-items-center">
                  <div>
                    <div className="fw-bold">
                      <i className="bi bi-cloud-haze2 me-2 text-danger"></i>
                      Province la plus polluée
                    </div>

                    <div className="small text-muted">
                      {mostPollutedProvince.NomProvince}
                    </div>
                  </div>

                  <div className="text-end fw-bold text-danger">
                    {mostPollutedProvince.EmissionMoyenne_MtCO2e} Mt CO₂e
                  </div>
                </div>
              )}

              {leastPollutedProvince && (
                <div className="result-item result-green d-flex justify-content-between align-items-center">
                  <div>
                    <div className="fw-bold">
                      <i className="bi bi-leaf me-2 text-success"></i>
                      Province la moins polluée
                    </div>

                    <div className="small text-muted">
                      {leastPollutedProvince.NomProvince}
                    </div>
                  </div>

                  <div className="text-end fw-bold text-success">
                    {leastPollutedProvince.EmissionMoyenne_MtCO2e} Mt CO₂e
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>

      <div className="section-card">
        <div className="section-header pollution">
          <i className="bi bi-table me-2"></i>
          Données détaillées
        </div>

        <div className="table-responsive">
          <table className="table table-hover mb-0 data-table">
            <thead>
              <tr>
                <th>Province</th>
                <th>Nom</th>
                <th>Année</th>
                <th>Émissions de GES</th>
              </tr>
            </thead>

            <tbody>
              {data.map((item, index) => (
                <tr key={`${item.province}-${item.annee}-${index}`}>
                  <td>
                    <span className="province-badge">{item.province}</span>
                  </td>

                  <td>{item.nomProvince}</td>

                  <td className="fw-semibold">{item.annee}</td>

                  <td>
                    {item.emission === null ? (
                      <span className="badge text-bg-secondary">
                        Non disponible
                      </span>
                    ) : (
                      <span className="fw-semibold text-success">
                        {item.emission} Mt CO₂e
                      </span>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

export default Pollution;
