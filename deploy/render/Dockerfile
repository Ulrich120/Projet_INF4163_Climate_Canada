# Image de la démo en ligne (Render) : l'API en mode SQLite, sans SQL Server ni pilote ODBC.
# Contexte de build : la racine du dépôt (voir render.yaml).

# 1) construit les bases SQLite de démonstration à partir des CSV de Data/Processed
FROM python:3.13-slim-bookworm AS data
WORKDIR /build
RUN pip install --no-cache-dir "pandas==3.0.5" "numpy==2.5.1"
COPY ETL ./ETL
COPY Data/Processed ./Data/Processed
RUN python ETL/build_demo_db.py Data/Demo

# 2) l'API et ces bases, rien d'autre
FROM python:3.13-slim-bookworm
WORKDIR /srv

COPY Website/backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY Website/backend/app ./app
COPY --from=data /build/Data/Demo ./data

ENV DATA_BACKEND=sqlite
RUN useradd --create-home api
USER api

# Render fournit PORT (10000 par défaut) et exige d'écouter sur 0.0.0.0
CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-10000}"]
