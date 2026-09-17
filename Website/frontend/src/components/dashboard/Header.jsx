function Header() {
  return (
    <header className="dashboard-header">
      <div>
        <h2 className="dashboard-header-title">
          Climate Canada Dashboard
        </h2>

        <p className="dashboard-header-subtitle">
          Sensibilisation au réchauffement climatique
        </p>
      </div>

      <div className="header-meta">
        <div className="header-status">
          <span className="status-dot"></span>
          API connectée
        </div>

        <div className="header-project">
          <i className="bi bi-mortarboard-fill"></i>
          Projet INF4163
        </div>
      </div>
    </header>
  );
}

export default Header;