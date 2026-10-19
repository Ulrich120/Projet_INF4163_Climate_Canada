import axios from "axios";

// VITE_API_URL permet de pointer vers une autre API (autre port, déploiement)
const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL ?? "http://127.0.0.1:8000",
  // la démo en ligne (offre gratuite) se met en veille : le premier appel peut attendre environ une minute
  timeout: 90000,
});

export default api;
