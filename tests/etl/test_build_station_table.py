import pandas as pd
import pytest
from build_station_table import read_station_month

HEADER = '"Long","Lat","Nom","ID_Clim","Prov_ou_ter","Tm","P"\n'


def write_file(tmp_path, rows, name="fr_climat_sommaires_QC_07-2010.csv"):
    path = tmp_path / name
    path.write_text("﻿" + HEADER + rows, encoding="utf-8")
    return path


def test_reads_french_decimals_and_keeps_station_ids_as_text(tmp_path):
    path = write_file(
        tmp_path,
        '"-71,197","46,837","BEAUPORT","7010565","QC","22,4","42,8"\n'
        '"-74,167","45,317","COTEAU","0011947","QC","","71,0"\n',
    )
    df = read_station_month(path)

    assert list(df["ID_Clim"]) == ["7010565", "0011947"]  # le zéro initial est conservé
    assert df.loc[0, "Tm"] == pytest.approx(22.4)
    assert pd.isna(df.loc[1, "Tm"])
    assert df.loc[1, "P"] == pytest.approx(71.0)
    assert set(df["Province"]) == {"QC"}
    assert set(df["Annee"]) == {2010}
    assert set(df["Mois"]) == {7}


def test_rejects_file_without_station_id(tmp_path):
    path = tmp_path / "fr_climat_sommaires_QC_07-2010.csv"
    path.write_text('"Long","Lat","Nom","Tm","P"\n"-71","46","X","1,0","2,0"\n', encoding="utf-8")
    with pytest.raises(ValueError, match="colonnes manquantes"):
        read_station_month(path)
