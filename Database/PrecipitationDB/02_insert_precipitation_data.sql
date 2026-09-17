USE PrecipitationDB;
GO

-- Donnees de precipitations annuelles
-- Source : Environnement et Changement climatique Canada

INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (9, 1, 323.84);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (9, 2, 396.88);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (9, 3, 361.94);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (10, 1, 943.96);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (10, 2, 1164.18);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (10, 3, 1076.13);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (7, 1, 332.66);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (7, 2, 501.18);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (7, 3, 383.08);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (4, 1, 1268.22);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (4, 2, 1020.66);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (4, 3, 916.41);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (1, 1, 1086.56);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (1, 2, 1061.97);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (1, 3, 1043.69);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (3, 1, 1497.19);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (3, 2, 1138.68);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (3, 3, 1028.30);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (12, 1, 192.74);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (12, 2, 185.83);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (12, 3, 181.19);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (13, 1, 204.03);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (13, 2, 221.00);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (13, 3, 178.11);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (6, 1, 743.79);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (6, 2, 791.38);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (6, 3, 690.06);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (2, 1, 1084.01);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (2, 2, 868.01);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (2, 3, 831.47);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (5, 1, 902.92);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (5, 2, 832.78);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (5, 3, 794.63);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (8, 1, 270.01);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (8, 2, 386.03);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (8, 3, 307.02);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (11, 1, 309.20);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (11, 2, 304.24);
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) VALUES (11, 3, 242.89);

GO

-- Verification
SELECT p.CodeProvince, a.ValeurAnnee, pr.PrecipitationAnnuelle FROM Precipitation pr JOIN Province p ON pr.ProvinceID = p.ProvinceID JOIN Annee a ON pr.AnneeID = a.AnneeID ORDER BY p.CodeProvince, a.ValeurAnnee;