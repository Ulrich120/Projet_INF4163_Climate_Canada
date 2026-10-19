// Affiché quand l'API ne répond pas (serveur éteint, en cours de réveil, mauvaise adresse)
function ErrorNotice({ message }) {
  return (
    <div className="alert alert-danger d-flex flex-wrap justify-content-between align-items-center gap-2">
      <span>
        {message} Le serveur ne répond pas ou vient de démarrer : réessaie dans un instant.
      </span>

      <button
        type="button"
        className="btn btn-sm btn-outline-danger"
        onClick={() => window.location.reload()}
      >
        Réessayer
      </button>
    </div>
  );
}

export default ErrorNotice;
