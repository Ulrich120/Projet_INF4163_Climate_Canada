# Debian 12 épinglée : le dépôt Microsoft ci-dessous est celui de Debian 12 (python:3.13-slim a suivi Debian 13)
FROM python:3.13-slim-bookworm

# Pilote ODBC de Microsoft : pyodbc en a besoin pour parler à SQL Server.
# Son installation exige d'accepter le contrat de licence : docker-compose.yml transmet ACCEPT_EULA
# depuis le fichier .env (voir README, section Docker).
ARG ACCEPT_EULA
RUN test "$ACCEPT_EULA" = "Y" || (echo "Définir ACCEPT_EULA=Y dans .env pour accepter la licence du pilote ODBC Microsoft" && exit 1)

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl gnupg ca-certificates \
    && curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" \
        > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    # libgssapi-krb5-2 est requis par le pilote ; sans l'installer explicitement, autoremove le retire avec curl
    && ACCEPT_EULA=$ACCEPT_EULA apt-get install -y --no-install-recommends msodbcsql18 libgssapi-krb5-2 \
    && apt-get purge -y curl gnupg \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srv

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

RUN useradd --create-home api
USER api

EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
