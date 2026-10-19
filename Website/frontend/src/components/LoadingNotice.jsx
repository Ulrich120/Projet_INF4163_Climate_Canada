import { useEffect, useState } from "react";

// Après quelques secondes, on explique l'attente : la démo en ligne tourne sur une offre gratuite
// qui met le serveur en veille après 15 minutes d'inactivité (le réveil prend environ une minute).
function LoadingNotice({ label, color = "text-success" }) {
  const [slow, setSlow] = useState(false);

  useEffect(() => {
    const timer = setTimeout(() => setSlow(true), 4000);
    return () => clearTimeout(timer);
  }, []);

  return (
    <div className="text-center py-5">
      <div className={`spinner-border ${color}`} />
      <p className="mt-3">{label}</p>

      {slow && (
        <p className="small text-muted mb-0">
          Le serveur de démonstration se réveille après une période d'inactivité :
          cela peut prendre jusqu'à une minute.
        </p>
      )}
    </div>
  );
}

export default LoadingNotice;
