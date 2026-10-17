import pytest
from app import main
from fastapi.testclient import TestClient

client = TestClient(main.app)


def test_health():
    response = client.get("/api/health")
    assert response.status_code == 200
    assert response.json()["status"] == "OK"


def test_temperature_endpoint_returns_query_rows(monkeypatch):
    rows = [{"province": "QC", "nomProvince": "Québec", "annee": 2023, "temperature": 1.5}]
    monkeypatch.setattr(main, "execute_query", lambda db, query: rows)
    response = client.get("/api/temperature")
    assert response.status_code == 200
    assert response.json() == rows


def test_results_endpoint_calls_both_procedures(monkeypatch):
    calls = []

    def fake_procedure(db, name):
        calls.append((db, name))
        return [[{"Resultat": name}]]

    monkeypatch.setattr(main, "execute_procedure", fake_procedure)
    response = client.get("/api/results/precipitation")
    assert response.status_code == 200
    assert calls == [
        ("PrecipitationDB", "sp_AnneePlusMoinsPluvieuse"),
        ("PrecipitationDB", "sp_ProvincePlusMoinsPluvieuse"),
    ]


@pytest.mark.parametrize("path", ["/api/temperature", "/api/precipitation", "/api/pollution"])
def test_database_failure_becomes_500(monkeypatch, path):
    def boom(db, query):
        raise RuntimeError("connexion impossible")

    monkeypatch.setattr(main, "execute_query", boom)
    response = client.get(path)
    assert response.status_code == 500
    assert "connexion impossible" in response.json()["detail"]


def test_temperature_anomalies_endpoint_queries_the_anomaly_view(monkeypatch):
    seen = {}

    def fake_query(db, query):
        seen["db"], seen["query"] = db, query
        return [{"province": "CA", "annee": 2000, "anomalie": -0.465}]

    monkeypatch.setattr(main, "execute_query", fake_query)
    response = client.get("/api/temperature/anomalies")
    assert response.status_code == 200
    assert response.json()[0]["province"] == "CA"
    assert seen["db"] == "TemperatureDB"
    assert "vw_TemperatureAnomalie" in seen["query"]


def test_temperature_trends_endpoint_exposes_confidence_interval(monkeypatch):
    rows = [{"province": "QC", "methode": "anomalie_stations_longues", "pente": 0.44, "icBas": 0.01, "icHaut": 0.87}]
    monkeypatch.setattr(main, "execute_query", lambda db, query: rows)
    response = client.get("/api/temperature/trends")
    assert response.status_code == 200
    assert response.json() == rows


@pytest.mark.parametrize("path", ["/api/temperature/anomalies", "/api/temperature/trends"])
def test_anomaly_endpoints_turn_database_errors_into_500(monkeypatch, path):
    def boom(db, query):
        raise RuntimeError("base indisponible")

    monkeypatch.setattr(main, "execute_query", boom)
    assert client.get(path).status_code == 500


def test_precipitation_anomalies_endpoint_queries_the_precipitation_view(monkeypatch):
    seen = {}

    def fake_query(db, query):
        seen["db"], seen["query"] = db, query
        return [{"province": "YT", "annee": 2000, "anomalie": None, "moyenneSimple": 366.54}]

    monkeypatch.setattr(main, "execute_query", fake_query)
    response = client.get("/api/precipitation/anomalies")
    assert response.status_code == 200
    assert response.json()[0]["anomalie"] is None  # le Yukon n'a pas de station de longue durée
    assert seen["db"] == "PrecipitationDB"
    assert "vw_PrecipitationAnomalie" in seen["query"]


def test_precipitation_trends_endpoint(monkeypatch):
    rows = [{"province": "CA", "methode": "anomalie_stations_longues", "pente": -0.93, "icBas": -4.38, "icHaut": 2.51}]
    monkeypatch.setattr(main, "execute_query", lambda db, query: rows)
    response = client.get("/api/precipitation/trends")
    assert response.status_code == 200
    assert response.json() == rows


@pytest.mark.parametrize("path", ["/api/precipitation/anomalies", "/api/precipitation/trends"])
def test_precipitation_anomaly_endpoints_turn_errors_into_500(monkeypatch, path):
    def boom(db, query):
        raise RuntimeError("base indisponible")

    monkeypatch.setattr(main, "execute_query", boom)
    assert client.get(path).status_code == 500


def test_connection_string_uses_windows_authentication_by_default(monkeypatch):
    from app import database

    monkeypatch.delenv("SQL_USER", raising=False)
    connection_string = database.build_connection_string("TemperatureDB")
    assert "DATABASE=TemperatureDB;" in connection_string
    assert "Trusted_Connection=yes;" in connection_string
    assert "UID=" not in connection_string


def test_connection_string_uses_sql_authentication_when_a_user_is_set(monkeypatch):
    from app import database

    monkeypatch.setenv("SQL_USER", "sa")
    monkeypatch.setenv("SQL_PASSWORD", "Secret123!")
    connection_string = database.build_connection_string("PollutionDB")
    assert "UID=sa;PWD=Secret123!;" in connection_string
    assert "Trusted_Connection" not in connection_string
