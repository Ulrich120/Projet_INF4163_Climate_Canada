import { useEffect, useMemo, useState } from "react";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Tooltip,
  Legend,
} from "chart.js";
import { Line } from "react-chartjs-2";

import api from "../api/api";
import CanadaMap from "../components/map/CanadaMap";

ChartJS.register(CategoryScale, LinearScale, PointElement, LineElement, Tooltip, Legend);

function Home() {
  const [temperature, setTemperature] = useState([]);
  const [precipitation, setPrecipitation] = useState([]);
  const [pollution, setPollution] = useState([]);
  const [selectedProvince, setSelectedProvince] = useState("QC");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const loadData = async () => {
      try {
        const [temperatureResponse, precipitationResponse, pollutionResponse] =
          await Promise.all([
            api.get("/api/temperature"),
            api.get("/api/precipitation"),
            api.get("/api/pollution"),
          ]);

        setTemperature(temperatureResponse.data);
        setPrecipitation(precipitationResponse.data);
        setPollution(pollutionResponse.data);
      } catch (err) {
        console.error(err);
        setError("Impossible de charger les données du tableau de bord.");
      } finally {
        setLoading(false);
      }
    };

    loadData();
  }, []);

  const temperatureProvince = useMemo(
    () =>
      temperature
        .filter((item) => item.province === selectedProvince)
        .sort((a, b) => a.annee - b.annee),
    [temperature, selectedProvince],
  );

  const precipitationProvince = useMemo(
    () =>
      precipitation
        .filter((item) => item.province === selectedProvince)
        .sort((a, b) => a.annee - b.annee),
    [precipitation, selectedProvince],
  );

  const pollutionProvince = useMemo(
    () =>
      pollution
        .filter((item) => item.province === selectedProvince)
        .sort((a, b) => a.annee - b.annee),
    [pollution, selectedProvince],
  );

  const provinceName = temperatureProvince[0]?.nomProvince || selectedProvince;

  const getYearValue = (dataset, year, key) => {
    const row = dataset.find((item) => item.annee === year);
    if (!row || row[key] === null || row[key] === undefined) return null;
    return Number(row[key]);
  };

  const latestTemperature = getYearValue(temperatureProvince, 2025, "temperature");
  const latestPrecipitation = getYearValue(precipitationProvince, 2025, "precipitation");
  const latestPollution = getYearValue(pollutionProvince, 2024, "emission");

  const temperatureTrend = temperatureProvince.map((item) => Number(item.temperature));

  const chartData = {
    labels: temperatureProvince.map((item) => item.annee),
    datasets: [
      {
        label: `Température — ${selectedProvince}`,
        data: temperatureTrend,
        borderColor: "#2563eb",
        backgroundColor: "rgba(37,99,235,0.12)",
        pointBackgroundColor: "#ffffff",
        pointBorderColor: "#2563eb",
        pointBorderWidth: 3,
        pointRadius: 6,
        tension: 0.35,
      },
    ],
  };

  const chartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        labels: { usePointStyle: true },
      },
    },
    scales: {
      x: { grid: { display: false } },
      y: { grid: { color: "rgba(148,163,184,0.14)" } },
    },
  };

  if (loading) {
    return (
      <div className="text-center py-5">
        <div className="spinner-border text-success" />
        <p className="mt-3">Chargement du tableau de bord...</p>
      </div>
    );
  }

  return (
    <div>
      <section className="hero-section mb-4">
        <div className="row align-items-center g-4">
          <div className="col-lg-8">
            <span className="badge text-bg-success mb-3">
              <i className="bi bi-database-check me-1"></i>
              Données SQL Server en direct
            </span>

            <h1 className="display-5 fw-bold mb-3">Climate Canada Dashboard</h1>

            <p className="lead text-muted mb-0">
              Analyse interactive des températures, précipitations et émissions de gaz à
              effet de serre au Canada.
            </p>
          </div>

          <div className="col-lg-4 text-lg-end">
            <div className="small text-muted">Province sélectionnée</div>
            <div className="fs-2 fw-bold text-success">{selectedProvince}</div>
            <div className="text-muted">{provinceName}</div>
          </div>
        </div>
      </section>

      {error && <div className="alert alert-danger">{error}</div>}

      <div className="row g-4 mb-4">
        <div className="col-md-6 col-xl-3">
          <DashboardKPI
            icon="bi-thermometer-high"
            label="Température"
            value={latestTemperature !== null ? latestTemperature.toFixed(2) : "--"}
            unit="°C"
            color="#dc2626"
            background="#fff1f2"
            note="2025"
          />
        </div>

        <div className="col-md-6 col-xl-3">
          <DashboardKPI
            icon="bi-cloud-rain-heavy"
            label="Précipitations"
            value={latestPrecipitation !== null ? latestPrecipitation.toFixed(2) : "--"}
            unit="mm"
            color="#0284c7"
            background="#eff6ff"
            note="2025"
          />
        </div>

        <div className="col-md-6 col-xl-3">
          <DashboardKPI
            icon="bi-cloud-haze2-fill"
            label="Émissions GES"
            value={latestPollution !== null ? latestPollution.toFixed(2) : "--"}
            unit="Mt"
            color="#15803d"
            background="#f0fdf4"
            note="Dernière donnée officielle : 2024"
          />
        </div>

        <div className="col-md-6 col-xl-3">
          <DashboardKPI
            icon="bi-geo-alt-fill"
            label="Province"
            value={selectedProvince}
            unit=""
            color="#7c3aed"
            background="#f5f3ff"
            note={provinceName}
          />
        </div>
      </div>

      <div className="row g-4 mb-4">
        <div className="col-xl-7">
          <div className="section-card h-100">
            <div className="section-header pollution">
              <i className="bi bi-map-fill me-2"></i>
              Carte interactive du Canada
            </div>

            <div className="p-4">
              <CanadaMap
                selectedProvince={selectedProvince}
                onProvinceChange={setSelectedProvince}
              />

              <p className="small text-muted text-center mb-0">
                Cliquez sur une province ou un territoire pour actualiser les indicateurs.
              </p>
            </div>
          </div>
        </div>

        <div className="col-xl-5">
          <div className="section-card h-100">
            <div className="section-header rain">
              <i className="bi bi-graph-up-arrow me-2"></i>
              Évolution de la température
            </div>

            <div className="p-4" style={{ height: "440px" }}>
              <Line data={chartData} options={chartOptions} />
            </div>
          </div>
        </div>
      </div>

      <div className="row g-4">
        <div className="col-md-4">
          <QuickModule
            icon="bi-thermometer-high"
            title="Température"
            text="Analyse des températures annuelles moyennes de 2023 à 2025."
            href="/temperature"
            color="#dc2626"
          />
        </div>

        <div className="col-md-4">
          <QuickModule
            icon="bi-cloud-rain-heavy"
            title="Précipitations"
            text="Analyse des précipitations annuelles par province et territoire."
            href="/precipitation"
            color="#0284c7"
          />
        </div>

        <div className="col-md-4">
          <QuickModule
            icon="bi-leaf-fill"
            title="Pollution"
            text="Analyse des émissions provinciales de gaz à effet de serre."
            href="/pollution"
            color="#15803d"
          />
        </div>
      </div>
    </div>
  );
}

function DashboardKPI({ icon, label, value, unit, color, background, note }) {
  return (
    <div
      className="h-100 rounded-4 p-4"
      style={{
        background,
        border: `1px solid ${color}20`,
        boxShadow: "0 10px 25px rgba(15,23,42,0.06)",
      }}
    >
      <div
        className="rounded-circle d-grid place-items-center mb-3"
        style={{
          width: 50,
          height: 50,
          placeItems: "center",
          background: color,
          color: "white",
          fontSize: "1.25rem",
        }}
      >
        <i className={`bi ${icon}`}></i>
      </div>

      <div className="small text-muted">{label}</div>

      <div className="fs-2 fw-bold" style={{ color }}>
        {value}
        {unit && <span className="fs-6 ms-1">{unit}</span>}
      </div>

      <div className="small text-muted mt-2">{note}</div>
    </div>
  );
}

function QuickModule({ icon, title, text, href, color }) {
  return (
    <a href={href} className="text-decoration-none">
      <div className="section-card h-100 p-4 module-link" style={{ borderTop: `4px solid ${color}` }}>
        <div
          className="rounded-circle d-grid mb-3"
          style={{ width: 48, height: 48, placeItems: "center", color: "white", background: color }}
        >
          <i className={`bi ${icon}`}></i>
        </div>

        <h3 className="h5 fw-bold" style={{ color }}>
          {title}
        </h3>

        <p className="text-muted mb-3">{text}</p>

        <span className="fw-semibold" style={{ color }}>
          Explorer
          <i className="bi bi-arrow-right ms-2"></i>
        </span>
      </div>
    </a>
  );
}

export default Home;
