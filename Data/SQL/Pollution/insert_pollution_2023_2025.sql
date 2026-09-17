USE PollutionDB;
GO

-- Emissions annuelles de GES en Mt CO2e
-- Source : Environnement et Changement climatique Canada
-- 2025 : donnee officielle non disponible, valeur NULL

INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (9, 1, 260.08);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (9, 2, 260.14);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (9, 3, NULL);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (10, 1, 57.61);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (10, 2, 56.60);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (10, 3, NULL);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (7, 1, 20.92);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (7, 2, 21.40);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (7, 3, NULL);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (4, 1, 11.45);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (4, 2, 12.76);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (4, 3, NULL);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (1, 1, 8.09);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (1, 2, 8.62);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (1, 3, NULL);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (3, 1, 13.41);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (3, 2, 13.69);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (3, 3, NULL);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (12, 1, 1.36);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (12, 2, 1.35);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (12, 3, NULL);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (13, 1, 0.88);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (13, 2, 0.93);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (13, 3, NULL);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (6, 1, 159.77);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (6, 2, 157.81);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (6, 3, NULL);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (2, 1, 1.54);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (2, 2, 1.49);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (2, 3, NULL);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (5, 1, 77.68);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (5, 2, 77.53);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (5, 3, NULL);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (8, 1, 73.41);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (8, 2, 71.66);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (8, 3, NULL);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (11, 1, 0.67);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (11, 2, 0.72);
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) VALUES (11, 3, NULL);

GO

-- Verification
SELECT p.CodeProvince, a.ValeurAnnee, po.EmissionGES_MtCO2e FROM Pollution po JOIN Province p ON po.ProvinceID = p.ProvinceID JOIN Annee a ON po.AnneeID = a.AnneeID ORDER BY p.CodeProvince, a.ValeurAnnee;