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
