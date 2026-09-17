# Climate Canada — Frontend

Interface React du projet, construite avec Vite. Voir le [README principal](../../README.md) pour le contexte général du projet et comment lancer l'ensemble (backend + frontend + bases de données).

## Lancer en local

Le backend FastAPI doit tourner sur `http://127.0.0.1:8000` (voir `Website/backend/`).

```bash
npm install
npm run dev
```

Vite ouvre l'app sur `http://localhost:5173` (ou un port voisin si occupé).

## Organisation

```
src/
├── api/            client Axios vers l'API FastAPI
├── components/     composants réutilisables (carte, footer, layout de dashboard)
├── layouts/         mise en page globale (sidebar + header)
├── pages/          une page par thème (accueil, température, précipitations, pollution, résultats, équipe)
└── styles/         CSS du dashboard, de la carte et des composants globaux
```

Chaque page charge ses propres données via `api/api.js` au montage (`useEffect`), sans state global partagé — la donnée ne bouge pas assez vite pour justifier un store type Redux/Zustand ici.
