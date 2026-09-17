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
  Filler
);

function Precipitation() {
  const [data, setData] = useState([]);
  const [results, setResults] = useState(null);
  const [selectedProvince, setSelectedProvince] = useState("QC");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const loadData = async () => {
      try {
        const [dataResponse, resultsResponse] = await Promise.all([
          api.get("/api/precipitation"),
          api.get("/api/results/precipitation"),
        ]);

        setData(dataResponse.data);
        setResults(resultsResponse.data);
      } catch (err) {
        console.error(err);
        setError("Impossible de charger les données de précipitation.");
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

  const selectedProvinceName =
    provinceData[0]?.nomProvince || selectedProvince;

  const getValue = (year) => {
    const row = provinceData.find((item) => item.annee === year);
    return row ? Number(row.precipitation) : null;
  };

  const precip2023 = getValue(2023);
  const precip2024 = getValue(2024);
  const precip2025 = getValue(2025);

  const variation =
    precip2023 !== null && precip2025 !== null
      ? (precip2025 - precip2023).toFixed(2)
      : "--";

  const annualAverages = useMemo(() => {
    return [2023, 2024, 2025].map((year) => {
      const values = data
        .filter((item) => item.annee === year)
        .map((item) => Number(item.precipitation))
        .filter((value) => !Number.isNaN(value));

      const average =
        values.length > 0
          ? values.reduce((sum, value) => sum + value, 0) /
            values.length
          : null;

      return { year, average };
    });
  }, [data]);

  const lineChartData = {
    labels: provinceData.map((item) => item.annee),
    datasets: [
      {
        label: `Précipitations — ${selectedProvince}`,
        data: provinceData.map((item) => Number(item.precipitation)),
        borderColor: "#0ea5e9",
        backgroundColor: "rgba(14, 165, 233, 0.16)",
        pointBackgroundColor: "#ffffff",
        pointBorderColor: "#0284c7",
        pointBorderWidth: 3,
        pointRadius: 6,
        pointHoverRadius: 8,
        fill: true,
        tension: 0.35,
      },
    ],
  };

  const annualChartData = {
    labels: annualAverages.map((item) => item.year),
    datasets: [
      {
        label: "Précipitations moyennes nationales",
        data: annualAverages.map((item) =>
          item.average !== null
            ? Number(item.average.toFixed(2))
            : null
        ),
        backgroundColor: [
          "rgba(59,130,246,0.60)",
          "rgba(14,165,233,0.72)",
          "rgba(2,132,199,0.82)",
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

  const wettestYear = annualResults.find((item) =>
    item.Resultat?.toLowerCase().includes("plus pluvieuse")
  );

  const driestYear = annualResults.find((item) =>
    item.Resultat?.toLowerCase().includes("moins pluvieuse")
  );

  const wettestProvince = provinceResults.find((item) =>
    item.Resultat?.toLowerCase().includes("plus pluvieuse")
  );

  const driestProvince = provinceResults.find((item) =>
    item.Resultat?.toLowerCase().includes("moins pluvieuse")
  );

  if (loading) {
    return (
      <div className="text-center py-5">
        <div className="spinner-border text-primary" />
        <p className="mt-3">Chargement des précipitations...</p>
      </div>
    );
  }

  return (
    <div>
      <div className="d-flex flex-wrap justify-content-between align-items-end mb-4 gap-3">
        <div>
          <h1 className="page-title mb-2">
            <i className="bi bi-cloud-rain-heavy text-primary me-2"></i>
            Précipitations
          </h1>

          <p className="page-subtitle mb-0">
            Précipitations annuelles moyennes par province et territoire —
            2023 à 2025
          </p>
        </div>

        <div
          className="dashboard-card p-3"
          style={{ minWidth: "260px" }}
        >
          <label className="form-label fw-semibold text-primary">
            Province / territoire
          </label>

          <select
            className="form-select dashboard-select"
            value={selectedProvince}
            onChange={(event) =>
              setSelectedProvince(event.target.value)
            }
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

      <div className="row g-4 mb-4">
        <div className="col-md-4">
          <div className="card kpi-card rain">
            <div className="card-body p-4">
              <div className="d-flex align-items-center gap-3">
                <div className="kpi-icon rain">
                  <i className="bi bi-cloud-rain"></i>
                </div>

                <div>
                  <div className="fw-semibold text-primary">
                    Précipitations 2025
                  </div>

                  <div className="small text-muted">
                    {selectedProvince} - {selectedProvinceName}
                  </div>

                  <div className="kpi-value mt-2 text-primary">
                    {precip2025?.toFixed(2) ?? "--"} mm
                  </div>

                  <div className="small text-muted mt-1">
                    Total annuel moyen
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="col-md-4">
          <div className="card kpi-card rain">
            <div className="card-body p-4">
              <div className="d-flex align-items-center gap-3">
                <div
                  className="kpi-icon rain"
                  style={{
                    background:
                      "linear-gradient(135deg,#0ea5e9,#22d3ee)",
                  }}
                >
                  <i className="bi bi-droplet-half"></i>
                </div>

                <div>
                  <div className="fw-semibold text-info">
                    Précipitations 2024
                  </div>

                  <div className="small text-muted">
                    {selectedProvince} - {selectedProvinceName}
                  </div>

                  <div className="kpi-value mt-2 text-info">
                    {precip2024?.toFixed(2) ?? "--"} mm
                  </div>

                  <div className="small text-muted mt-1">
                    Total annuel moyen
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="col-md-4">
          <div className="card kpi-card pollution">
            <div className="card-body p-4">
              <div className="d-flex align-items-center gap-3">
                <div className="kpi-icon pollution">
                  <i className="bi bi-arrow-left-right"></i>
                </div>

                <div>
                  <div className="fw-semibold text-success">
                    Variation 2023 → 2025
                  </div>

                  <div className="small text-muted">
                    {selectedProvince} - {selectedProvinceName}
                  </div>

                  <div className="kpi-value mt-2 text-success">
                    {variation} mm
                  </div>

                  <div className="small text-muted mt-1">
                    Évolution totale
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
            <div className="section-header rain">
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
                background:
                  "linear-gradient(90deg,#0284c7,#22d3ee)",
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
            <div className="section-header rain">
              <i className="bi bi-calendar3 me-2"></i>
              Résultats par année
            </div>

            <div className="p-4">
              {wettestYear && (
                <div className="result-item result-cold d-flex justify-content-between align-items-center">
                  <div className="fw-bold">
                    <i className="bi bi-cloud-rain-heavy me-2 text-primary"></i>
                    Année la plus pluvieuse
                  </div>

                  <div className="text-end">
                    <div className="fw-bold text-primary">
                      {wettestYear.Annee}
                    </div>
                    <div>
                      {wettestYear.PrecipitationMoyenne_mm} mm
                    </div>
                  </div>
                </div>
              )}

              {driestYear && (
                <div
                  className="result-item d-flex justify-content-between align-items-center"
                  style={{
                    background: "#fff7ed",
                    border: "1px solid #fed7aa",
                  }}
                >
                  <div className="fw-bold">
                    <i className="bi bi-sun me-2 text-warning"></i>
                    Année la moins pluvieuse
                  </div>

                  <div className="text-end">
                    <div className="fw-bold text-warning">
                      {driestYear.Annee}
                    </div>
                    <div>
                      {driestYear.PrecipitationMoyenne_mm} mm
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
              {wettestProvince && (
                <div className="result-item result-cold d-flex justify-content-between align-items-center">
                  <div>
                    <div className="fw-bold">
                      <i className="bi bi-cloud-rain-heavy me-2 text-primary"></i>
                      Province la plus pluvieuse
                    </div>

                    <div className="small text-muted">
                      {wettestProvince.NomProvince}
                    </div>
                  </div>

                  <div className="text-end fw-bold text-primary">
                    {wettestProvince.PrecipitationMoyenne_mm} mm
                  </div>
                </div>
              )}

              {driestProvince && (
                <div
                  className="result-item d-flex justify-content-between align-items-center"
                  style={{
                    background: "#fff7ed",
                    border: "1px solid #fed7aa",
                  }}
                >
                  <div>
                    <div className="fw-bold">
                      <i className="bi bi-sun me-2 text-warning"></i>
                      Province la moins pluvieuse
                    </div>

                    <div className="small text-muted">
                      {driestProvince.NomProvince}
                    </div>
                  </div>

                  <div className="text-end fw-bold text-warning">
                    {driestProvince.PrecipitationMoyenne_mm} mm
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>

      <div className="section-card">
        <div className="section-header rain">
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
                <th>Précipitations</th>
              </tr>
            </thead>

            <tbody>
              {data.map((item, index) => (
                <tr
                  key={`${item.province}-${item.annee}-${index}`}
                >
                  <td>
                    <span className="province-badge">
                      {item.province}
                    </span>
                  </td>

                  <td>{item.nomProvince}</td>

                  <td className="fw-semibold">
                    {item.annee}
                  </td>

                  <td className="fw-semibold text-primary">
                    {item.precipitation} mm
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

export default Precipitation;