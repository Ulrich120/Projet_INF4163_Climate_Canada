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

function Precipitation() {
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
            api.get("/api/precipitation"),
            api.get("/api/precipitation/anomalies"),
            api.get("/api/precipitation/trends"),
            api.get("/api/results/precipitation"),
          ]);

        setData(dataResponse.data);
        setAnomalies(anomalyResponse.data);
        setTrends(trendResponse.data);
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
  const provinceVerdict = trendVerdict(provinceTrend, 1);
  const nationalVerdict = trendVerdict(nationalTrend, 1);

  // cumul simple (mm) ramené en % de sa propre moyenne pour le comparer à l'anomalie sur le même axe
  const observed = provinceAnomalies.map((item) => toNumber(item.moyenneSimple));
  const observedMean = mean(observed);

  // sans anomalie (province sans station de longue durée), la seule courbe restante serait trompeuse
  const naiveDataset = {
    label: "Cumul simple des stations (en % de sa moyenne, non fiable)",
    data: observed.map((value) =>
      value === null ? null : round2((value / observedMean - 1) * 100),
    ),
    borderColor: "rgba(220, 38, 38, 0.55)",
    borderDash: [2, 3],
    borderWidth: 1.5,
    pointRadius: 0,
  };

  const lineChartData = {
    labels: provinceAnomalies.map((item) => item.annee),
    datasets: [
      {
        label: `Anomalie — ${selectedProvince}`,
        data: provinceAnomalies.map((item) => toNumber(item.anomalie)),
        spanGaps: false,
        borderColor: "#0284c7",
        backgroundColor: "rgba(14, 165, 233, 0.16)",
        pointBackgroundColor: "#ffffff",
        pointBorderColor: "#0284c7",
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
      ...(latest ? [naiveDataset] : []),
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
            ? "rgba(14, 165, 233, 0.75)"
            : "rgba(234, 88, 12, 0.7)",
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
          color: "rgba(148,163,184,0.12)",
        },
      },
      y: {
        title: { display: true, text: "Écart à la normale des stations (%)" },
        grid: {
          color: "rgba(148,163,184,0.16)",
        },
      },
    },
  };

  const annualResults = results?.annees?.flat() || [];
  const provinceResults = results?.provinces?.flat() || [];

  const wettestYear = annualResults.find((item) =>
    item.Resultat?.toLowerCase().includes("plus pluvieuse"),
  );

  const driestYear = annualResults.find((item) =>
    item.Resultat?.toLowerCase().includes("moins pluvieuse"),
  );

  const wettestProvince = provinceResults.find((item) =>
    item.Resultat?.toLowerCase().includes("plus pluvieuse"),
  );

  const driestProvince = provinceResults.find((item) =>
    item.Resultat?.toLowerCase().includes("moins pluvieuse"),
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
            Anomalies et tendances par province et territoire — {periodLabel}
          </p>
        </div>

        <div className="dashboard-card p-3" style={{ minWidth: "260px" }}>
          <label className="form-label fw-semibold text-primary">
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
        d'une année à l'autre : le cumul simple des stations actives n'est donc
        pas comparable dans le temps (courbe rouge pointillée). Une anomalie
        compare chaque station à sa propre normale, en pourcentage, et c'est
        elle qui sert à calculer la tendance. Les relevés auxquels il manque
        plus de 5 jours sont écartés. Sur {years.length} ans, une tendance dont
        l'intervalle de confiance à 95 % contient zéro est non concluante.
      </div>

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
                    Anomalie {latest?.annee ?? ""}
                  </div>

                  <div className="small text-muted">
                    {selectedProvince} - {selectedProvinceName}
                  </div>

                  <div className="kpi-value mt-2 text-primary">
                    {signed(latest?.value, 1)} %
                  </div>

                  <div className="small text-muted mt-1">
                    {latest
                      ? "Écart à la normale des stations"
                      : "Pas assez de stations de longue durée"}
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
                    background: "linear-gradient(135deg,#0ea5e9,#22d3ee)",
                  }}
                >
                  <i className="bi bi-activity"></i>
                </div>

                <div>
                  <div className="fw-semibold text-info">
                    Tendance {periodLabel.replace(" à ", "–")}
                  </div>

                  <div className="small text-muted">
                    {selectedProvince} - {selectedProvinceName}
                  </div>

                  <div className="kpi-value mt-2 text-info">
                    {signed(provinceTrend?.pente, 1)}
                    <span className="fs-6 ms-1">% / décennie</span>
                  </div>

                  <div className="small text-muted mt-1">
                    {provinceVerdict
                      ? `${provinceVerdict.label} · ${provinceVerdict.interval}`
                      : "Pas assez de stations de longue durée"}
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
                    {signed(nationalTrend?.pente, 1)}
                    <span className="fs-6 ms-1">% / décennie</span>
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
            <div
              className="section-header"
              style={{
                background: "linear-gradient(90deg,#0284c7,#22d3ee)",
              }}
            >
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
            <div className="section-header rain">
              <i className="bi bi-calendar3 me-2"></i>
              Résultats par année (anomalie nationale)
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
                    <div>{signed(wettestYear.AnomalieMoyenne_pct, 1)} %</div>
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
                    <div>{signed(driestYear.AnomalieMoyenne_pct, 1)} %</div>
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
                <th>Anomalie</th>
                <th>Cumul des stations actives</th>
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
                              ? "text-warning fw-semibold"
                              : "text-primary fw-semibold"
                          }
                        >
                          {signed(anomaly, 1)} %
                        </span>
                      )}
                    </td>

                    <td className="text-muted">
                      {toNumber(item.precipitation) === null
                        ? "Série incomplète"
                        : `${item.precipitation} mm`}
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

export default Precipitation;
