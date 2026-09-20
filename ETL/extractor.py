import pandas as pd
from config import TEMPERATURE_FILE_PATTERN, TEMPERATURE_RAW_DIR


def list_temperature_files():
    return sorted(TEMPERATURE_RAW_DIR.glob(TEMPERATURE_FILE_PATTERN))


def read_temperature_file(file_path):
    # les fichiers ECCC ne sont pas tous encodés pareil selon l'année du téléchargement
    encodings = ["utf-8-sig", "utf-8", "cp1252", "latin1"]
    last_error = None

    for encoding in encodings:
        try:
            return pd.read_csv(file_path, encoding=encoding, sep=None, engine="python")
        except UnicodeDecodeError as exc:
            last_error = exc

    raise last_error


def inspect_temperature_files():
    files = list_temperature_files()
    if not files:
        print("Aucun fichier climatique trouvé.")
        return

    print(f"Nombre de fichiers trouvés : {len(files)}")

    for file_path in files:
        print("\n" + "=" * 70)
        print(f"Fichier : {file_path.name}")

        df = read_temperature_file(file_path)
        print(f"Nombre de lignes : {len(df)}")
        print(f"Nombre de colonnes : {len(df.columns)}")

        print("\nColonnes :")
        for column in df.columns:
            print(f" - {column}")

        print("\nAperçu :")
        print(df.head())

        print("\nColonnes climatiques recherchées :")
        for column in ["Tm", "P"]:
            if column in df.columns:
                print(f"{column} : présente | valeurs non nulles = {df[column].notna().sum()}")
            else:
                print(f"{column} : ABSENTE")


if __name__ == "__main__":
    inspect_temperature_files()
