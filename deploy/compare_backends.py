"""Compare les réponses de deux instances de l'API (par ex. SQL Server et mode démonstration SQLite).

Usage : python deploy/compare_backends.py http://localhost:8080 http://localhost:8001
Code de sortie 0 si toutes les réponses JSON sont identiques, 1 sinon.
"""

import json
import sys
import urllib.request

ENDPOINTS = [
    "/api/temperature",
    "/api/temperature/anomalies",
    "/api/temperature/trends",
    "/api/results/temperature",
    "/api/precipitation",
    "/api/precipitation/anomalies",
    "/api/precipitation/trends",
    "/api/results/precipitation",
    "/api/pollution",
    "/api/results/pollution",
]


def fetch(base, path):
    with urllib.request.urlopen(base.rstrip("/") + path, timeout=120) as response:
        return json.load(response)


def differences(left, right, path="$", limit=5):
    """Premières différences entre deux structures JSON (chemin, valeur gauche, valeur droite)."""
    found = []
    if type(left) is not type(right):
        return [(path, left, right)]
    if isinstance(left, dict):
        if left.keys() != right.keys():
            return [(path + " (clés)", sorted(left), sorted(right))]
        for key in left:
            found += differences(left[key], right[key], f"{path}.{key}", limit)
    elif isinstance(left, list):
        if len(left) != len(right):
            return [(path + " (longueur)", len(left), len(right))]
        for index, (a, b) in enumerate(zip(left, right, strict=True)):
            found += differences(a, b, f"{path}[{index}]", limit)
    elif left != right:
        return [(path, left, right)]
    return found[:limit]


def main():
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    left_url, right_url = sys.argv[1:]

    failures = 0
    for endpoint in ENDPOINTS:
        left, right = fetch(left_url, endpoint), fetch(right_url, endpoint)
        diff = differences(left, right)
        if diff:
            failures += 1
            print(f"DIFFÉRENT  {endpoint}")
            for path, a, b in diff:
                print(f"    {path} : {a!r} contre {b!r}")
        else:
            print(f"identique  {endpoint} ({len(left)} éléments)")

    print(f"\n{len(ENDPOINTS) - failures}/{len(ENDPOINTS)} réponses identiques")
    sys.exit(1 if failures else 0)


if __name__ == "__main__":
    main()
