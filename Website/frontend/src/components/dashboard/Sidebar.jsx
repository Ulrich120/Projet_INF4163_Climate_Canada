import { NavLink } from "react-router-dom";

const items = [
  { to: "/", icon: "bi-grid-1x2-fill", label: "Dashboard" },
  { to: "/temperature", icon: "bi-thermometer-high", label: "Température" },
  { to: "/precipitation", icon: "bi-cloud-rain-heavy", label: "Précipitations" },
  { to: "/pollution", icon: "bi-cloud-haze2-fill", label: "Pollution" },
  { to: "/results", icon: "bi-trophy-fill", label: "Résultats" },
  { to: "/team", icon: "bi-people-fill", label: "Équipe" },
];

function Sidebar() {
  return (
    <aside className="dashboard-sidebar">
      <div className="sidebar-brand">
        <div className="sidebar-logo">
          <i className="bi bi-globe-americas"></i>
        </div>

        <div>
          <div className="sidebar-title">Climate Canada</div>
          <div className="sidebar-subtitle">INF4163</div>
        </div>
      </div>

      <nav className="sidebar-nav">
        {items.map((item) => (
          <NavLink
            key={item.to}
            to={item.to}
            end={item.to === "/"}
            className={({ isActive }) =>
              `sidebar-link ${isActive ? "active" : ""}`
            }
          >
            <i className={`bi ${item.icon}`}></i>
            <span>{item.label}</span>
          </NavLink>
        ))}
      </nav>

      <div className="sidebar-bottom">
        <div className="sidebar-source">
          <i className="bi bi-database-fill-check"></i>
          <div>
            <strong>SQL Server</strong>
            <span>Données connectées</span>
          </div>
        </div>
      </div>
    </aside>
  );
}

export default Sidebar;