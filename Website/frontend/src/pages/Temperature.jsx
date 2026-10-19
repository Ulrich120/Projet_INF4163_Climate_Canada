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
import LoadingNotice from "../components/LoadingNotice";
import {
  lastWithData,
  mean,
  round2,
  signed,
  toNumber,
  trendLine,
  trendVerdict,
  yearsIn,
} from "../utils/series";

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

const METHOD = "anomalie_stations_longues";
const NATIONAL = "CA";

function Temperature() {
  const [data, setData] = useState([]);
  const [anomalies, setAnomalies] = useState([]);
  const [trends, setTrends] = useState([]);
  const [results, setResults] = useState(null);
  const [selectedProvince, setSelectedProvince] = useState("QC");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const loadData = async () => {
      try {
        const [dataResponse, anomalyResponse, trendResponse, resultsResponse] =
          await Promise.all([
            api.get("/api/temperature"),
            api.get("/api/temperature/anomalies"),
            api.get("/api/temperature/trends"),
            api.get("/api/results/temperature"),
          ]);

        setData(dataResponse.data);
        setAnomalies(anomalyResponse.data);
        setTrends(trendResponse.data);
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

  const provinceAnomalies = useMemo(() => {
    return anomalies
      .filter((item) => item.province === selectedProvince)
      .sort((a, b) => a.annee - b.annee);
  }, [anomalies, selectedProvince]);

  const nationalAnomalies = useMemo(() => {
    return anomalies
      .filter((item) => item.province === NATIONAL)
      .sort((a, b) => a.annee - b.annee);
  }, [anomalies]);

  const selectedProvinceName = provinceData[0]?.nomProvince || selectedProvince;

  const years = useMemo(() => yearsIn(anomalies), [anomalies]);
  const periodLabel = years.length ? `${years[0]} à ${years[years.length - 1]}` : "";

  const latest = lastWithData(provinceAnomalies, "anomalie");

  const provinceTrend = trends.find(
    (item) => item.province === selectedProvince && item.methode === METHOD,
  );
  const nationalTrend = trends.find(
    (item) => item.province === NATIONAL && item.methode === METHOD,
  );
  const provinceVerdict = trendVerdict(provinceTrend);
  const nationalVerdict = trendVerdict(nationalTrend);

  const observed = provinceAnomalies.map((item) => toNumber(item.moyenneSimple));
  const observedMean = mean(observed);

  const lineChartData = {
    labels: provinceAnomalies.map((item) => item.annee),
    datasets: [
      {
        label: `Anomalie — ${selectedProvince}`,
        data: provinceAnomalies.map((item) => toNumber(item.anomalie)),
        spanGaps: false,
        borderColor: "#2563eb",
        backgroundColor: "rgba(37, 99, 235, 0.14)",
        pointBackgroundColor: "#ffffff",
        pointBorderColor: "#2563eb",
        pointBorderWidth: 2,
        pointRadius: 4,
        pointHoverRadius: 7,
        tension: 0.25,
      },
      {
        label: "Tendance",
        data: trendLine(provinceAnomalies, "anomalie"),
        borderColor: "#0f172a",
        borderDash: [6, 4],
        borderWidth: 2,
        pointRadius: 0,
      },
      {
        label: "Moyenne simple des stations (centrée, non fiable)",
        data: observed.map((value) =>
          value === null ? null : round2(value - observedMean),
        ),
        borderColor: "rgba(220, 38, 38, 0.55)",
        borderDash: [2, 3],
        borderWidth: 1.5,
        pointRadius: 0,
      },
    ],
  };

  const annualChartData = {
    labels: nationalAnomalies.map((item) => item.annee),
    datasets: [
      {
        label: "Anomalie nationale (moyenne des provinces)",
        data: nationalAnomalies.map((item) => toNumber(item.anomalie)),
        backgroundColor: nationalAnomalies.map((item) =>
          toNumber(item.anomalie) >= 0
            ? "rgba(220, 38, 38, 0.75)"
            : "rgba(37, 99, 235, 0.75)",
        ),
        borderRadius: 6,
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
        title: { display: true, text: "Écart à la moyenne des stations (°C)" },
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
      <LoadingNotice label="Chargement des températures..." color="text-primary" />
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
            Anomalies et tendances par province et territoire — {periodLabel}
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

      <div className="alert alert-info border-0 shadow-sm">
        <i className="bi bi-info-circle-fill me-2"></i>
        <strong>Comment lire ces chiffres.</strong> Le réseau de stations change
        d'une année à l'autre : la moyenne simple des stations actives n'est donc
        pas comparable dans le temps (courbe rouge pointillée). Une anomalie
        compare chaque station à sa propre moyenne, et c'est elle qui sert à
        calculer la tendance. Sur {years.length} ans, une tendance dont
        l'intervalle de confiance à 95 % contient zéro est non concluante.
      </div>

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
                    Anomalie {latest?.annee ?? ""}
                  </div>

                  <div className="small text-muted">
                    {selectedProvince} - {selectedProvinceName}
                  </div>

                  <div className="kpi-value mt-2 text-danger">
                    {signed(latest?.value)} °C
                  </div>

                  <div className="small text-muted mt-1">
                    Écart à la moyenne des stations
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
                <div className="kpi-icon rain">
                  <i className="bi bi-activity"></i>
                </div>

                <div>
                  <div className="fw-semibold text-primary">
                    Tendance {periodLabel.replace(" à ", "–")}
                  </div>

                  <div className="small text-muted">
                    {selectedProvince} - {selectedProvinceName}
                  </div>

                  <div className="kpi-value mt-2 text-primary">
                    {signed(provinceTrend?.pente)}
                    <span className="fs-6 ms-1">°C / décennie</span>
                  </div>

                  <div className="small text-muted mt-1">
                    {provinceVerdict
                      ? `${provinceVerdict.label} · ${provinceVerdict.interval}`
                      : "Série trop courte"}
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
                  <i className="bi bi-globe-americas"></i>
                </div>

                <div>
                  <div className="fw-semibold text-success">
                    Tendance Canada*
                  </div>

                  <div className="small text-muted">
                    Moyenne des provinces, poids égaux
                  </div>

                  <div className="kpi-value mt-2 text-success">
                    {signed(nationalTrend?.pente)}
                    <span className="fs-6 ms-1">°C / décennie</span>
                  </div>

                  <div className="small text-muted mt-1">
                    {nationalVerdict
                      ? `${nationalVerdict.label} · ${nationalVerdict.interval}`
                      : "Série trop courte"}
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
              Anomalie — {selectedProvince} - {selectedProvinceName}
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
              Anomalie nationale par année
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
              Résultats par année (anomalie nationale)
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
                    <div>{signed(hottestYear.AnomalieMoyenne)} °C</div>
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
                    <div>{signed(coldestYear.AnomalieMoyenne)} °C</div>
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
                <th>Anomalie</th>
                <th>Moyenne des stations actives</th>
              </tr>
            </thead>

            <tbody>
              {provinceData.map((item, index) => {
                const anomaly = toNumber(
                  provinceAnomalies.find((row) => row.annee === item.annee)?.anomalie,
                );

                return (
                  <tr key={`${item.province}-${item.annee}-${index}`}>
                    <td>
                      <span className="province-badge">{item.province}</span>
                    </td>

                    <td>{item.nomProvince}</td>

                    <td className="fw-semibold">{item.annee}</td>

                    <td>
                      {anomaly === null ? (
                        <span className="badge text-bg-secondary">
                          Non disponible
                        </span>
                      ) : (
                        <span
                          className={
                            anomaly < 0
                              ? "text-primary fw-semibold"
                              : "text-danger fw-semibold"
                          }
                        >
                          {signed(anomaly)} °C
                        </span>
                      )}
                    </td>

                    <td className="text-muted">
                      {toNumber(item.temperature) === null
                        ? "Série incomplète"
                        : `${item.temperature} °C`}
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

export default Temperature;
