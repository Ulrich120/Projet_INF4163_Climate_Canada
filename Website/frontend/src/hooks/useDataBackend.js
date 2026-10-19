import { useEffect, useState } from "react";

import api from "../api/api";

// "sqlserver" (version complète) ou "sqlite" (démo en ligne en lecture seule), null tant que l'API n'a pas répondu
function useDataBackend() {
  const [backend, setBackend] = useState(null);

  useEffect(() => {
    api
      .get("/api/health")
      .then((response) => setBackend(response.data.donnees ?? null))
      .catch(() => setBackend(null));
  }, []);

  return backend;
}

export default useDataBackend;
