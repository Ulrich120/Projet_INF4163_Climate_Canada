#!/bin/bash
# Crée les trois bases du projet dans le conteneur SQL Server : mêmes scripts et même ordre que
# Database/setup.ps1. Rejouable : ne fait rien si tout est déjà en place.
set -euo pipefail

SQLCMD=(/opt/mssql-tools18/bin/sqlcmd -C -S db -U sa -P "$MSSQL_SA_PASSWORD" -b)
DATABASES=(TemperatureDB PrecipitationDB PollutionDB)

query() {
    "${SQLCMD[@]}" -h -1 -W -Q "SET NOCOUNT ON; $1" | tr -d '[:space:]'
}

# la dernière chose créée par l'initialisation est la vue vw_Pollution : si elle existe, tout est fait
if [ "$(query "SELECT CASE WHEN DB_ID('PollutionDB') IS NOT NULL AND OBJECT_ID('PollutionDB.dbo.vw_Pollution') IS NOT NULL THEN 1 ELSE 0 END")" = "1" ]; then
    echo "Bases déjà initialisées, rien à faire."
    exit 0
fi

# une initialisation interrompue laisse des bases à moitié remplies (les INSERT ne sont pas rejouables) :
# on repart de zéro
for db in "${DATABASES[@]}"; do
    "${SQLCMD[@]}" -Q "IF DB_ID('$db') IS NOT NULL BEGIN ALTER DATABASE $db SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE $db; END"
done

run() {
    echo "-> $1"
    "${SQLCMD[@]}" -i "/database/$1" > /dev/null
}

for db in "${DATABASES[@]}"; do
    for file in $(cd /database && ls "$db"/*.sql | sort); do
        run "$file"
    done
done

run Procedures/stored_procedures.sql
run Triggers/triggers.sql
run Views/create_views.sql

echo "Bases créées."
