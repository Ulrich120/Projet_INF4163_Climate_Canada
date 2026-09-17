USE TemperatureDB;
GO

-- Données de température moyenne annuelle
-- Source : Environnement et Changement climatique Canada

INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (9, 1, 4.76, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (9, 2, 3.67, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (9, 3, 3.65, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (10, 1, 9.01, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (10, 2, 8.57, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (10, 3, 8.70, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (7, 1, 2.39, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (7, 2, 3.10, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (7, 3, 1.54, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (4, 1, 6.47, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (4, 2, 6.97, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (4, 3, 5.81, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (1, 1, 4.15, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (1, 2, 5.20, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (1, 3, 4.45, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (3, 1, 7.88, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (3, 2, 8.06, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (3, 3, 7.39, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (12, 1, -3.46, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (12, 2, -4.79, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (12, 3, -4.76, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (13, 1, -10.01, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (13, 2, -9.02, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (13, 3, -9.56, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (6, 1, 6.42, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (6, 2, 7.26, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (6, 3, 5.27, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (2, 1, 7.09, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (2, 2, 7.75, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (2, 3, 6.82, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (5, 1, 3.30, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (5, 2, 4.18, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (5, 3, 2.44, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (8, 1, 3.38, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (8, 2, 3.06, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (8, 3, 2.30, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (11, 1, -1.61, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (11, 2, -2.92, 1);
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) VALUES (11, 3, -2.52, 1);

GO

-- Vérification
SELECT p.CodeProvince, a.ValeurAnnee, t.TemperatureMoyenne FROM Temperature t JOIN Province p ON t.ProvinceID = p.ProvinceID JOIN Annee a ON t.AnneeID = a.AnneeID ORDER BY p.CodeProvince, a.ValeurAnnee;