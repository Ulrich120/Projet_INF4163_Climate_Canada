import pandas as pd

FILE = "Data/Raw/Pollution/GES_Econ_Can_Prov_Terr.csv"

encodings = ["utf-8-sig", "utf-8", "cp1252", "latin1"]

df = None
used_encoding = None

for encoding in encodings:
    try:
        df = pd.read_csv(FILE, encoding=encoding, low_memory=False)
        used_encoding = encoding
        break
    except UnicodeDecodeError:
        continue

if df is None:
    raise RuntimeError("Impossible de lire le fichier avec les encodages testés.")

print(f"Encodage utilisé : {used_encoding}")
print(f"Nombre de lignes : {len(df)}")
print(f"Nombre de colonnes : {len(df.columns)}")

print("\n--- Colonnes ---\n")
for column in df.columns:
    print(column)

print("\n--- Aperçu ---\n")
print(df.head(10).to_string())

print("\n--- Valeurs uniques par colonne ---\n")
for column in df.columns:
    values = df[column].dropna().astype(str).unique()
    print(f"\n{column} ({len(values)} valeurs uniques)")
    for value in values[:40]:
        print(value)
