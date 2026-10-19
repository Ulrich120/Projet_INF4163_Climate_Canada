"""Les fichiers de configuration YAML doivent être valides : un deux-points mal placé dans un nom d'étape suffit
à faire rejeter tout un workflow GitHub Actions (le run échoue sans aucun job, donc sans message dans les tests)."""

from pathlib import Path

import pytest
import yaml

ROOT = Path(__file__).resolve().parent.parent


@pytest.mark.parametrize("path", [".github/workflows/ci.yml", "docker-compose.yml", "render.yaml"])
def test_yaml_files_parse(path):
    document = yaml.safe_load((ROOT / path).read_text(encoding="utf-8"))
    assert isinstance(document, dict)


def test_workflow_defines_the_expected_jobs():
    workflow = yaml.safe_load((ROOT / ".github/workflows/ci.yml").read_text(encoding="utf-8"))
    assert set(workflow["jobs"]) == {"python", "frontend", "docker"}
    for job in workflow["jobs"].values():
        assert job["steps"], "un job sans étape"


def test_render_blueprint_points_to_existing_files():
    blueprint = yaml.safe_load((ROOT / "render.yaml").read_text(encoding="utf-8"))
    service = blueprint["services"][0]
    assert (ROOT / service["dockerfilePath"]).is_file()
    assert (ROOT / service["dockerContext"]).is_dir()
    assert service["healthCheckPath"].startswith("/")
    assert service["plan"] == "free"
