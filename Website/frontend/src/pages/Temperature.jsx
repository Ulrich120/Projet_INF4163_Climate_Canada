import { useEffect, useMemo, useState } from "react";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  Title,
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
  Title,
  Tooltip,
  Legend,
  Filler,
);

function Temperature() {
  const [data, setData] = useState([]);
  const [results, setResults] = useState(null);
  const [selectedProvince, setSelectedProvince] = useState("QC");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const loadData = async () => {
      try {
        const [dataResponse, resultsResponse] = await Promise.all([
          api.get("/api/temperature"),
          api.get("/api/results/temperature"),
        ]);

        setData(dataResponse.data);
        setResults(resultsResponse.data);
      } catch (err) {
        console.error(err);
        setError("Impossible de charger les données de température.");
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
    return row ? Number(row.temperature) : null;
  };

  const temp2023 = getValue(2023);
  const temp2024 = getValue(2024);
  const temp2025 = getValue(2025);

  const variation =
    temp2023 !== null && temp2025 !== null
      ? (temp2025 - temp2023).toFixed(2)
      : "--";

  const annualAverages = useMemo(() => {
    return [2023, 2024, 2025].map((year) => {
      const values = data
        .filter((item) => item.annee === year)
        .map((item) => Number(item.temperature))
        .filter((value) => !Number.isNaN(value));

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
        label: `Température moyenne — ${selectedProvince}`,
        data: provinceData.map((item) => Number(item.temperature)),
        borderColor: "#2563eb",
        backgroundColor: "rgba(37, 99, 235, 0.14)",
        pointBackgroundColor: "#ffffff",
        pointBorderColor: "#2563eb",
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
        label: "Température moyenne nationale",
        data: annualAverages.map((item) =>
          item.average !== null ? Number(item.average.toFixed(2)) : null,
        ),
        backgroundColor: [
          "rgba(34, 197, 94, 0.65)",
          "rgba(22, 163, 74, 0.75)",
          "rgba(21, 128, 61, 0.85)",
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
          color: "rgba(148, 163, 184, 0.12)",
        },
      },
      y: {
        grid: {
          color: "rgba(148, 163, 184, 0.16)",
        },
      },
    },
  };

  const annualResults = results?.annees?.flat() || [];
  const provinceResults = results?.provinces?.flat() || [];

  const hottestYear = annualResults.find((item) =>
    item.Resultat?.toLowerCase().includes("plus chaude"),
  );

  const coldestYear = annualResults.find((item) =>
    item.Resultat?.toLowerCase().includes("moins chaude"),
  );

  const hottestProvince = provinceResults.find((item) =>
    item.Resultat?.toLowerCase().includes("plus chaude"),
  );

  const coldestProvince = provinceResults.find((item) =>
    item.Resultat?.toLowerCase().includes("moins chaude"),
  );

  if (loading) {
    return (
      <div className="text-center py-5">
        <div className="spinner-border text-primary" />
        <p className="mt-3">Chargement des températures...</p>
      </div>
    );
  }

  return (
    <div>
      <div className="d-flex flex-wrap justify-content-between align-items-end mb-4 gap-3">
        <div>
          <h1 className="page-title mb-2">
            <i className="bi bi-thermometer-high text-danger me-2"></i>
            Températures
          </h1>

          <p className="page-subtitle mb-0">
            Température annuelle moyenne par province et territoire — 2023 à
            2025
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

      <div className="row g-4 mb-4">
        <div className="col-md-4">
          <div className="card kpi-card temperature">
            <div className="card-body p-4">
              <div className="d-flex align-items-center gap-3">
                <div className="kpi-icon temperature">
                  <i className="bi bi-graph-up-arrow"></i>
                </div>

                <div>
                  <div className="fw-semibold text-danger">
                    Température 2025
                  </div>

                  <div className="small text-muted">
                    {selectedProvince} - {selectedProvinceName}
                  </div>

                  <div className="kpi-value mt-2 text-danger">
                    {temp2025?.toFixed(2) ?? "--"} °C
                  </div>

                  <div className="small text-muted mt-1">Moyenne annuelle</div>
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
                  <i className="bi bi-snow"></i>
                </div>

                <div>
                  <div className="fw-semibold text-primary">
                    Température 2024
                  </div>

                  <div className="small text-muted">
                    {selectedProvince} - {selectedProvinceName}
                  </div>

                  <div className="kpi-value mt-2 text-primary">
                    {temp2024?.toFixed(2) ?? "--"} °C
                  </div>

                  <div className="small text-muted mt-1">Moyenne annuelle</div>
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
                  <i className="bi bi-leaf"></i>
                </div>

                <div>
                  <div className="fw-semibold text-success">
                    Variation 2023 → 2025
                  </div>

                  <div className="small text-muted">
                    {selectedProvince} - {selectedProvinceName}
                  </div>

                  <div className="kpi-value mt-2 text-success">
                    {variation} °C
                  </div>

                  <div className="small text-muted mt-1">Évolution totale</div>
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
            <div className="section-header pollution">
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
            <div className="section-header temperature">
              <i className="bi bi-calendar3 me-2"></i>
              Résultats par année
            </div>

            <div className="p-4">
              {hottestYear && (
                <div className="result-item result-hot d-flex justify-content-between align-items-center">
                  <div>
                    <div className="fw-bold">
                      <i className="bi bi-fire me-2 text-danger"></i>
                      Année la plus chaude
                    </div>
                  </div>

                  <div className="text-end">
                    <div className="fw-bold text-danger">
                      {hottestYear.Annee}
                    </div>
                    <div>{hottestYear.TemperatureMoyenne} °C</div>
                  </div>
                </div>
              )}

              {coldestYear && (
                <div className="result-item result-cold d-flex justify-content-between align-items-center">
                  <div className="fw-bold">
                    <i className="bi bi-snow me-2 text-primary"></i>
                    Année la moins chaude
                  </div>

                  <div className="text-end">
                    <div className="fw-bold text-primary">
                      {coldestYear.Annee}
                    </div>
                    <div>{coldestYear.TemperatureMoyenne} °C</div>
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
              {hottestProvince && (
                <div className="result-item result-hot d-flex justify-content-between align-items-center">
                  <div>
                    <div className="fw-bold">
                      <i className="bi bi-fire me-2 text-danger"></i>
                      Province la plus chaude
                    </div>

                    <div className="small text-muted">
                      {hottestProvince.NomProvince}
                    </div>
                  </div>

                  <div className="text-end fw-bold text-danger">
                    {hottestProvince.TemperatureMoyenne} °C
                  </div>
                </div>
              )}

              {coldestProvince && (
                <div className="result-item result-cold d-flex justify-content-between align-items-center">
                  <div>
                    <div className="fw-bold">
                      <i className="bi bi-snow me-2 text-primary"></i>
                      Province la moins chaude
                    </div>

                    <div className="small text-muted">
                      {coldestProvince.NomProvince}
                    </div>
                  </div>

                  <div className="text-end fw-bold text-primary">
                    {coldestProvince.TemperatureMoyenne} °C
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>

      <div className="section-card">
        <div className="section-header purple">
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
                <th>Température moyenne</th>
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
                    <span
                      className={
                        Number(item.temperature) < 0
                          ? "text-primary fw-semibold"
                          : "text-danger fw-semibold"
                      }
                    >
                      {item.temperature} °C
                    </span>
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

export default Temperature;
