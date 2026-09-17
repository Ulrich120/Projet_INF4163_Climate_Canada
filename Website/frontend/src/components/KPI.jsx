function KPI({ icon, title, value, unit, note, type = "temperature" }) {
  return (
    <div className={`card kpi-card ${type}`}>
      <div className="card-body p-4">
        <div className="d-flex align-items-center gap-3">
          <div className={`kpi-icon ${type}`}>
            <i className={`bi ${icon}`}></i>
          </div>

          <div className="flex-grow-1">
            <div className="kpi-label mb-1">{title}</div>

            <div className="kpi-value">
              {value}

              {unit && <span className="fs-6 ms-1 fw-semibold">{unit}</span>}
            </div>

            {note && <div className="small text-muted mt-2">{note}</div>}
          </div>
        </div>
      </div>
    </div>
  );
}

export default KPI;
