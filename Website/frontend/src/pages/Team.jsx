import dongmoUlrichPhoto from "../assets/team/dongmo-ulrich.jpg";

const members = [
  {
    initials: "DE",
    name: "Diagne El Hadj Talla",
    role: "Présentation & PowerPoint",
    icon: "bi-easel2-fill",
    color: "linear-gradient(135deg,#7c3aed,#a855f7)",
    contributions: [
      "Conception et mise en forme du PowerPoint",
      "Organisation et synthèse du contenu de présentation",
      "Préparation du support visuel pour la démonstration",
      "Participation à la préparation de la présentation orale",
    ],
  },
  {
    initials: "DC",
    name: "Domingo Christophe Jules Ifede Vignon",
    role: "Rapport & Documentation",
    icon: "bi-file-earmark-text-fill",
    color: "linear-gradient(135deg,#0ea5e9,#2563eb)",
    contributions: [
      "Rédaction et mise en forme du rapport final",
      "Organisation de la documentation du projet",
      "Intégration des résultats et captures dans le rapport",
      "Préparation du document final pour la remise",
    ],
  },
  {
    initials: "DU",
    name: "Dongmo Ulrich",
    role: "Conception & Développement",
    photo: dongmoUlrichPhoto,
    icon: "bi-code-slash",
    color: "linear-gradient(135deg,#16a34a,#0ea5e9)",
    contributions: [
      "Collecte et traitement des données climatiques",
      "Développement des scripts ETL Python",
      "Conception des bases de données SQL Server",
      "Développement des procédures stockées et déclencheurs",
      "Développement du backend FastAPI",
      "Développement du frontend React",
      "Intégration SQL Server → FastAPI → React",
      "Tests et validation du système",
    ],
  },
];

const technologies = [
  {
    icon: "bi-database-fill",
    name: "SQL Server",
    description: "Stockage et interrogation des données",
  },
  {
    icon: "bi-filetype-py",
    name: "Python",
    description: "ETL et traitement des données",
  },
  {
    icon: "bi-lightning-charge-fill",
    name: "FastAPI",
    description: "API backend",
  },
  {
    icon: "bi-code-slash",
    name: "React",
    description: "Interface utilisateur",
  },
  {
    icon: "bi-bar-chart-fill",
    name: "Chart.js",
    description: "Visualisation des données",
  },
  {
    icon: "bi-git",
    name: "Git / GitHub",
    description: "Gestion des versions",
  },
];

function Team() {
  return (
    <div>
      {/* HEADER */}
      <section className="hero-section mb-4">
        <div className="row align-items-center g-4">
          <div className="col-lg-8">
            <span className="badge text-bg-primary mb-3">
              <i className="bi bi-people-fill me-1"></i>
              Équipe du projet
            </span>

            <h1 className="display-5 fw-bold mb-3">Climate Canada</h1>

            <p className="lead text-muted mb-0">
              Projet de fin de session — INF4163 Techniques de bases de données
            </p>
          </div>

          <div className="col-lg-4 text-lg-end">
            <div
              className="d-inline-grid place-items-center rounded-circle"
              style={{
                width: "110px",
                height: "110px",
                background: "linear-gradient(135deg,#22c55e,#0ea5e9,#7c3aed)",
                color: "white",
                fontSize: "2.7rem",
                boxShadow: "0 15px 35px rgba(15,23,42,0.18)",
              }}
            >
              <i className="bi bi-globe-americas"></i>
            </div>
          </div>
        </div>
      </section>

      {/* TEAM MEMBERS */}
      <div className="section-card mb-4">
        <div className="section-header purple">
          <i className="bi bi-people-fill me-2"></i>
          Membres de l'équipe
        </div>

        <div className="p-4">
          <div className="row g-4">
            {members.map((member) => (
              <div className="col-md-6 col-xl-4" key={member.initials}>
                <div
                  className="h-100 rounded-4 p-4"
                  style={{
                    background: "white",
                    border: "1px solid #e5e7eb",
                    boxShadow: "0 12px 30px rgba(15,23,42,0.07)",
                  }}
                >
                  {/* MEMBER HEADER */}
                  <div className="d-flex align-items-center gap-3 mb-3">
                    {member.photo ? (
                      <img
                        src={member.photo}
                        alt={`Photo de ${member.name}`}
                        className="rounded-circle flex-shrink-0"
                        style={{
                          width: "78px",
                          height: "78px",
                          objectFit: "cover",
                          objectPosition: "center",
                          border: "3px solid white",
                          boxShadow: "0 4px 12px rgba(15,23,42,0.18)",
                        }}
                      />
                    ) : (
                      <div
                        className="d-grid place-items-center rounded-circle flex-shrink-0"
                        style={{
                          width: "78px",
                          height: "78px",
                          background: member.color,
                          color: "white",
                          fontWeight: "800",
                          fontSize: "1.4rem",
                        }}
                      >
                        {member.initials}
                      </div>
                    )}

                    <div>
                      <h2 className="h5 fw-bold mb-1">{member.name}</h2>

                      <div className="text-primary fw-semibold small">
                        <i className={`bi ${member.icon} me-1`}></i>
                        {member.role}
                      </div>
                    </div>
                  </div>

                  {/* CONTRIBUTIONS */}
                  <div
                    className="rounded-3 p-3"
                    style={{
                      background: "#f8fafc",
                      border: "1px solid #e2e8f0",
                    }}
                  >
                    <div className="small fw-bold mb-2">
                      <i className="bi bi-check2-circle me-1 text-success"></i>
                      Contribution
                    </div>

                    <ul className="small text-muted ps-3 mb-0">
                      {member.contributions.map((contribution) => (
                        <li className="mb-2" key={contribution}>
                          {contribution}
                        </li>
                      ))}
                    </ul>
                  </div>
                </div>
              </div>
            ))}
          </div>

          {/* TEAMWORK */}
          <div
            className="alert alert-primary border-0 mt-4 mb-0"
            style={{
              background: "linear-gradient(135deg,#eff6ff,#eef2ff)",
            }}
          >
            <div className="d-flex gap-3">
              <i className="bi bi-people-fill fs-4 text-primary"></i>

              <div>
                <div className="fw-bold mb-1">Travail d'équipe</div>

                <div className="small text-muted">
                  Le projet combine la conception et le développement du
                  système, sa documentation ainsi que la préparation de sa
                  présentation finale.
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* TECHNOLOGIES */}
      <div className="section-card mb-4">
        <div className="section-header rain">
          <i className="bi bi-stack me-2"></i>
          Technologies utilisées
        </div>

        <div className="p-4">
          <div className="row g-3">
            {technologies.map((technology) => (
              <div className="col-md-6 col-xl-4" key={technology.name}>
                <div
                  className="d-flex align-items-center gap-3 rounded-4 p-3 h-100"
                  style={{
                    background: "#f8fafc",
                    border: "1px solid #e2e8f0",
                  }}
                >
                  <div
                    className="d-grid place-items-center rounded-3 flex-shrink-0"
                    style={{
                      width: "48px",
                      height: "48px",
                      background: "linear-gradient(135deg,#0ea5e9,#2563eb)",
                      color: "white",
                      fontSize: "1.2rem",
                    }}
                  >
                    <i className={`bi ${technology.icon}`}></i>
                  </div>

                  <div>
                    <div className="fw-bold">{technology.name}</div>

                    <div className="small text-muted">
                      {technology.description}
                    </div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* ARCHITECTURE */}
      <div className="section-card">
        <div className="section-header pollution">
          <i className="bi bi-diagram-3-fill me-2"></i>
          Architecture de la solution
        </div>

        <div className="p-4">
          <div className="row g-4 text-center">
            <ArchitectureBox
              icon="bi-browser-chrome"
              title="Frontend"
              subtitle="React + Vite"
            />

            <ArchitectureArrow />

            <ArchitectureBox
              icon="bi-lightning-charge-fill"
              title="Backend API"
              subtitle="FastAPI"
            />

            <ArchitectureArrow />

            <ArchitectureBox
              icon="bi-database-fill"
              title="Bases de données"
              subtitle="SQL Server"
            />
          </div>

          <div className="alert alert-success border-0 mt-4 mb-0">
            <i className="bi bi-check-circle-fill me-2"></i>
            Le frontend récupère les données environnementales depuis SQL Server
            à travers l'API FastAPI.
          </div>
        </div>
      </div>
    </div>
  );
}

function ArchitectureBox({ icon, title, subtitle }) {
  return (
    <div className="col-md">
      <div
        className="rounded-4 p-4 h-100"
        style={{
          background: "linear-gradient(135deg,#f8fafc,#eef2ff)",
          border: "1px solid #dbeafe",
        }}
      >
        <i className={`bi ${icon} fs-1 text-primary`}></i>

        <h3 className="h5 fw-bold mt-3 mb-1">{title}</h3>

        <div className="text-muted">{subtitle}</div>
      </div>
    </div>
  );
}

function ArchitectureArrow() {
  return (
    <div className="col-md-auto d-none d-md-flex align-items-center">
      <i className="bi bi-arrow-right fs-3 text-muted"></i>
    </div>
  );
}

export default Team;
