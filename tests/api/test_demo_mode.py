"""Mode démonstration (SQLite) : les valeurs attendues sont celles que SQL Server renvoie pour les mêmes données
(vérifié par deploy/compare_backends.py, qui compare les deux modes route par route)."""

import importlib

import pytest
from build_demo_db import build_database
from compare_backends import differences
from fastapi.testclient import TestClient
from generate_sql import DOMAINS


@pytest.fixture(scope="module")
def demo(tmp_path_factory):
    from app import database, main

    folder = tmp_path_factory.mktemp("demo")
    for domain in DOMAINS.values():
        build_database(domain, folder)

    patch = pytest.MonkeyPatch()
    patch.setattr(database, "DATA_BACKEND", "sqlite")
    patch.setattr(main, "DATA_BACKEND", "sqlite")
    patch.setattr(database, "DEMO_DIR", folder)
    yield TestClient(main.app)
    patch.undo()


def test_health_announces_the_backend(demo):
    assert demo.get("/api/health").json()["donnees"] == "sqlite"


def test_row_counts_match_the_sql_server_databases(demo):
    assert len(demo.get("/api/temperature").json()) == 338
    assert len(demo.get("/api/precipitation").json()) == 338
    assert len(demo.get("/api/pollution").json()) == 338
    assert len(demo.get("/api/temperature/anomalies").json()) == 364
    assert len(demo.get("/api/temperature/trends").json()) == 42


def test_stored_procedure_equivalents_give_the_sql_server_answers(demo):
    temperature = demo.get("/api/results/temperature").json()
    assert temperature["annees"] == [
        [{"Resultat": "Annee la plus chaude", "Annee": 2024, "AnomalieMoyenne": 1.19}],
        [{"Resultat": "Annee la moins chaude", "Annee": 2004, "AnomalieMoyenne": -0.9}],
    ]
    assert temperature["provinces"][0][0]["CodeProvince"] == "BC"
    assert temperature["provinces"][1][0]["TemperatureMoyenne"] == -11.12

    precipitation = demo.get("/api/results/precipitation").json()
    assert precipitation["annees"][0][0]["Annee"] == 2010
    assert precipitation["annees"][1][0]["AnomalieMoyenne_pct"] == -15.93
    assert precipitation["provinces"][0][0]["PrecipitationMoyenne_mm"] == 1232.57

    pollution = demo.get("/api/results/pollution").json()
    assert pollution["annees"][0][0] == {
        "Resultat": "Annee la plus polluee", "Annee": 2007, "EmissionMoyenne_MtCO2e": 59.89,
        "NombreValeursDisponibles": 13,
    }
    assert pollution["provinces"][1][0]["CodeProvince"] == "YT"
    assert pollution["provinces"][0][0]["NombreAnneesDisponibles"] == 25  # 2025 non publié


def test_trends_expose_the_confidence_interval_and_the_missing_province(demo):
    trends = demo.get("/api/temperature/trends").json()
    quebec = next(t for t in trends if t["province"] == "QC" and t["methode"] == "anomalie_stations_longues")
    assert (quebec["pente"], quebec["icBas"]) == (0.4404, 0.0065)

    precipitation = demo.get("/api/precipitation/trends").json()
    yukon = next(t for t in precipitation if t["province"] == "YT" and t["methode"] == "anomalie_stations_longues")
    assert yukon["pente"] is None  # aucune station de longue durée


def test_unpublished_year_stays_null(demo):
    rows = [r for r in demo.get("/api/pollution").json() if r["annee"] == 2025]
    assert len(rows) == 13 and all(r["emission"] is None for r in rows)


def test_the_database_is_opened_read_only(demo):
    from app import database

    connection = database.get_connection("TemperatureDB")
    try:
        with pytest.raises(Exception, match="readonly"):
            connection.execute("DELETE FROM dbo.Province")
    finally:
        connection.close()


def test_comparator_detects_differences():
    assert differences({"a": [1.19]}, {"a": [1.19]}) == []
    assert differences({"a": [1.19]}, {"a": [1.2]}) == [("$.a[0]", 1.19, 1.2)]
    assert differences([1, 2], [1]) == [("$ (longueur)", 2, 1)]
    assert differences({"a": 1}, {"b": 1}) == [("$ (clés)", ["a"], ["b"])]


def test_cors_origins_come_from_the_environment(monkeypatch):
    from app import main

    monkeypatch.setenv("CORS_ORIGINS", "https://demo.vercel.app, https://autre.example")
    try:
        importlib.reload(main)
        assert "https://demo.vercel.app" in main.ALLOWED_ORIGINS
        assert "https://autre.example" in main.ALLOWED_ORIGINS
        assert "http://localhost:5173" in main.ALLOWED_ORIGINS

        client = TestClient(main.app)
        allowed = client.options("/api/health", headers={"Origin": "https://demo.vercel.app",
                                                         "Access-Control-Request-Method": "GET"})
        assert allowed.headers["access-control-allow-origin"] == "https://demo.vercel.app"
        refused = client.options("/api/health", headers={"Origin": "https://pirate.example",
                                                         "Access-Control-Request-Method": "GET"})
        assert "access-control-allow-origin" not in refused.headers
    finally:
        monkeypatch.delenv("CORS_ORIGINS")
        importlib.reload(main)
