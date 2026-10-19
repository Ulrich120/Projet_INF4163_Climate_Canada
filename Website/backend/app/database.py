import os
import sqlite3
from pathlib import Path

from dotenv import load_dotenv

load_dotenv()

# "sqlserver" (par défaut) ou "sqlite" : le mode démonstration lit des bases SQLite en lecture seule
# (voir ETL/build_demo_db.py), pour héberger gratuitement une démo sans SQL Server
DATA_BACKEND = os.getenv("DATA_BACKEND", "sqlserver").lower()
DEMO_DIR = Path(os.getenv("DEMO_DB_DIR", Path(__file__).resolve().parents[1] / "data"))

SERVER = os.getenv("SQL_SERVER", r"localhost\SQLEXPRESS")
DRIVER = os.getenv("SQL_DRIVER", "ODBC Driver 18 for SQL Server")

DATABASES = {
    "temperature": "TemperatureDB",
    "pollution": "PollutionDB",
    "precipitation": "PrecipitationDB",
}


def build_connection_string(database_name: str) -> str:
    # authentification SQL (conteneur Docker, Linux) si SQL_USER est défini,
    # sinon authentification Windows (SQL Server Express local)
    user = os.getenv("SQL_USER")
    if user:
        credentials = f"UID={user};PWD={os.getenv('SQL_PASSWORD', '')};"
    else:
        credentials = "Trusted_Connection=yes;"

    return (
        f"DRIVER={{{DRIVER}}};"
        f"SERVER={SERVER};"
        f"DATABASE={database_name};"
        f"{credentials}"
        "TrustServerCertificate=yes;"
    )


def connect_demo(database_name: str):
    path = (DEMO_DIR / f"{database_name}.sqlite").resolve()
    if not path.exists():
        raise FileNotFoundError(f"Base de démonstration introuvable : {path}")

    # la base est attachée sous le nom "dbo" : les requêtes écrites pour SQL Server (dbo.Temperature,
    # dbo.vw_...) fonctionnent telles quelles
    connection = sqlite3.connect(":memory:", uri=True)
    connection.execute("ATTACH DATABASE ? AS dbo", (f"{path.as_uri()}?mode=ro",))
    return connection


def get_connection(database_name: str):
    if DATA_BACKEND == "sqlite":
        return connect_demo(database_name)

    import pyodbc  # importé ici : le mode démonstration n'a pas besoin du pilote ODBC

    return pyodbc.connect(build_connection_string(database_name), timeout=10)


def test_database(database_name: str):
    connection = get_connection(database_name)
    try:
        cursor = connection.cursor()
        cursor.execute("SELECT DB_NAME() AS DatabaseName")
        row = cursor.fetchone()
        return {"database": row[0], "status": "OK"}
    finally:
        connection.close()


def test_all_databases():
    results = {}
    for key, database_name in DATABASES.items():
        try:
            results[key] = test_database(database_name)
        except Exception as error:
            results[key] = {"database": database_name, "status": "ERROR", "error": str(error)}
    return results


if __name__ == "__main__":
    print("Test des connexions SQL Server")
    print("-" * 40)

    for key, result in test_all_databases().items():
        print(f"{key.upper():15} {result['database']:20} {result['status']}")
        if result["status"] == "ERROR":
            print(f"  -> {result['error']}")
