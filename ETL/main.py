from extractor import list_temperature_files, read_temperature_file
from transformer import calculate_monthly_province_summary
from utils import parse_climate_filename


def main():
    files = list_temperature_files()
    if not files:
        print("Aucun fichier climatique trouvé.")
        return

    for file_path in files:
        metadata = parse_climate_filename(file_path)
        df = read_temperature_file(file_path)
        summary = calculate_monthly_province_summary(df)

        print("=" * 70)
        print(f"Fichier : {file_path.name}")
        print(f"Province fichier : {metadata['province_code']}")
        print(f"Province données : {summary['province']}")
        print(f"Mois : {metadata['month']:02d}")
        print(f"Année : {metadata['year']}")
        print(f"Température moyenne provinciale : {summary['temperature_moyenne']:.2f} °C")
        print(f"Stations utilisées (température) : {summary['nb_stations_temperature']}")
        print(f"Précipitation moyenne provinciale : {summary['precipitation_moyenne']:.2f} mm")
        print(f"Stations utilisées (précipitations) : {summary['nb_stations_precipitation']}")


if __name__ == "__main__":
    main()
