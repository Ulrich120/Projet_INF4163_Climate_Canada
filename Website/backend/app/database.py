import pyodbc

# à adapter au nom de ton instance locale (SELECT @@SERVERNAME; dans SSMS)
SERVER = r"Ulrich\SQLEXPRESS"
DRIVER = "ODBC Driver 18 for SQL Server"

DATABASES = {
    "temperature": "TemperatureDB",
    "pollution": "PollutionDB",
    "precipitation": "PrecipitationDB",
}


def get_connection(database_name: str):
    connection_string = (
        f"DRIVER={{{DRIVER}}};"
        f"SERVER={SERVER};"
        f"DATABASE={database_name};"
        "Trusted_Connection=yes;"
        "TrustServerCertificate=yes;"
    )
    return pyodbc.connect(connection_string, timeout=10)


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
