import { NavLink } from "react-router-dom";

function Navbar() {
  const linkClass = ({ isActive }) => `nav-link ${isActive ? "active" : ""}`;

  return (
    <nav className="navbar navbar-expand-lg main-navbar">
      <div className="container">
        <NavLink className="navbar-brand" to="/">
          <i className="bi bi-globe-americas me-2"></i>
          Climate Canada
        </NavLink>

        <button
          className="navbar-toggler border-0"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#mainNavbar"
        >
          <span className="navbar-toggler-icon"></span>
        </button>

        <div className="collapse navbar-collapse" id="mainNavbar">
          <ul className="navbar-nav ms-auto align-items-lg-center">
            <li className="nav-item">
              <NavLink className={linkClass} to="/">
                <i className="bi bi-house-door me-1"></i>
                Accueil
              </NavLink>
            </li>

            <li className="nav-item">
              <NavLink className={linkClass} to="/temperature">
                <i className="bi bi-thermometer-half me-1"></i>
                Température
              </NavLink>
            </li>

            <li className="nav-item">
              <NavLink className={linkClass} to="/precipitation">
                <i className="bi bi-cloud-rain me-1"></i>
                Précipitations
              </NavLink>
            </li>

            <li className="nav-item">
              <NavLink className={linkClass} to="/pollution">
                <i className="bi bi-leaf me-1"></i>
                Pollution
              </NavLink>
            </li>

            <li className="nav-item">
              <NavLink className={linkClass} to="/results">
                <i className="bi bi-trophy me-1"></i>
                Résultats
              </NavLink>
            </li>

            <li className="nav-item">
              <NavLink className={linkClass} to="/team">
                <i className="bi bi-people me-1"></i>
                Équipe
              </NavLink>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  );
}

export default Navbar;
