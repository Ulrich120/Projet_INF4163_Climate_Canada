from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from database import get_connection

app = FastAPI(
    title="Climate Canada API",
    description="API du projet INF4163 - Sensibilisation au rechauffement climatique",
    version="1.0.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",
        "http://127.0.0.1:5173",
        "http://localhost:5174",
        "http://127.0.0.1:5174",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


def rows_to_dicts(cursor, rows):
    columns = [column[0] for column in cursor.description]
    return [dict(zip(columns, row)) for row in rows]


def execute_query(database_name, query):
    connection = get_connection(database_name)
    try:
        cursor = connection.cursor()
        cursor.execute(query)
        return rows_to_dicts(cursor, cursor.fetchall())
    finally:
        connection.close()


def execute_procedure(database_name, procedure_name):
    # une procédure peut renvoyer plusieurs result sets (ex: sp_AnneePlusMoinsChaude),
    # d'où la boucle sur cursor.nextset()
    connection = get_connection(database_name)
    try:
        cursor = connection.cursor()
        cursor.execute(f"EXEC dbo.{procedure_name}")

        result_sets = []
        while True:
            if cursor.description:
                result_sets.append(rows_to_dicts(cursor, cursor.fetchall()))
            if not cursor.nextset():
                break

        return result_sets
    finally:
        connection.close()


@app.get("/")
def root():
    return {"message": "Climate Canada API", "status": "running"}


@app.get("/api/health")
def health():
    return {"status": "OK", "service": "Climate Canada API"}


# --- Température ---

@app.get("/api/temperature")
def get_temperature():
    query = """
        SELECT
            p.CodeProvince AS province,
            p.NomProvince AS nomProvince,
            a.ValeurAnnee AS annee,
            t.TemperatureMoyenne AS temperature
        FROM dbo.Temperature t
        INNER JOIN dbo.Province p ON t.ProvinceID = p.ProvinceID
        INNER JOIN dbo.Annee a ON t.AnneeID = a.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        ORDER BY p.CodeProvince, a.ValeurAnnee;
    """
    try:
        return execute_query("TemperatureDB", query)
    except Exception as error:
        raise HTTPException(status_code=500, detail=str(error))


@app.get("/api/results/temperature")
def get_temperature_results():
    try:
        return {
            "annees": execute_procedure("TemperatureDB", "sp_AnneePlusMoinsChaude"),
            "provinces": execute_procedure("TemperatureDB", "sp_ProvincePlusMoinsChaude"),
        }
    except Exception as error:
        raise HTTPException(status_code=500, detail=str(error))


# --- Précipitations ---

@app.get("/api/precipitation")
def get_precipitation():
    query = """
        SELECT
            p.CodeProvince AS province,
            p.NomProvince AS nomProvince,
            a.ValeurAnnee AS annee,
            pr.PrecipitationAnnuelle AS precipitation
        FROM dbo.Precipitation pr
        INNER JOIN dbo.Province p ON pr.ProvinceID = p.ProvinceID
        INNER JOIN dbo.Annee a ON pr.AnneeID = a.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        ORDER BY p.CodeProvince, a.ValeurAnnee;
    """
    try:
        return execute_query("PrecipitationDB", query)
    except Exception as error:
        raise HTTPException(status_code=500, detail=str(error))


@app.get("/api/results/precipitation")
def get_precipitation_results():
    try:
        return {
            "annees": execute_procedure("PrecipitationDB", "sp_AnneePlusMoinsPluvieuse"),
            "provinces": execute_procedure("PrecipitationDB", "sp_ProvincePlusMoinsPluvieuse"),
        }
    except Exception as error:
        raise HTTPException(status_code=500, detail=str(error))


# --- Pollution ---

@app.get("/api/pollution")
def get_pollution():
    query = """
        SELECT
            p.CodeProvince AS province,
            p.NomProvince AS nomProvince,
            a.ValeurAnnee AS annee,
            po.EmissionGES_MtCO2e AS emission
        FROM dbo.Pollution po
        INNER JOIN dbo.Province p ON po.ProvinceID = p.ProvinceID
        INNER JOIN dbo.Annee a ON po.AnneeID = a.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        ORDER BY p.CodeProvince, a.ValeurAnnee;
    """
    try:
        return execute_query("PollutionDB", query)
    except Exception as error:
        raise HTTPException(status_code=500, detail=str(error))


@app.get("/api/results/pollution")
def get_pollution_results():
    try:
        return {
            "annees": execute_procedure("PollutionDB", "sp_AnneePlusMoinsPolluee"),
            "provinces": execute_procedure("PollutionDB", "sp_ProvincePlusMoinsPolluee"),
        }
    except Exception as error:
        raise HTTPException(status_code=500, detail=str(error))
