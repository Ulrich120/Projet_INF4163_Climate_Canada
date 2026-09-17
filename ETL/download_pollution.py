from pathlib import Path
import requests

url = (
    "https://www.canada.ca/content/dam/eccc/documents/csv/"
    "cesindicators/ghg-emissions/2026/emissions-ges-regionales-fr.csv"
)

output = Path("Data/Raw/Pollution/emissions_ges_regionales.csv")
output.parent.mkdir(parents=True, exist_ok=True)

print("Téléchargement du fichier officiel ECCC...")
response = requests.get(url, timeout=60, headers={"User-Agent": "Mozilla/5.0"})
response.raise_for_status()

output.write_bytes(response.content)

print("Téléchargement terminé.")
print(f"Fichier : {output}")
print(f"Taille : {len(response.content)} octets")
