/* Vues d'aggrégation - utilisées par le tableau de bord Power BI
   (mais utilisables aussi depuis SSMS ou n'importe quel client SQL) */

USE TemperatureDB;
GO

CREATE OR ALTER VIEW dbo.vw_Temperature AS
SELECT
    p.ProvinceID,
    p.CodeProvince,
    p.NomProvince,
    a.AnneeID,
    a.ValeurAnnee AS Annee,
    t.TemperatureMoyenne
FROM dbo.Temperature t
INNER JOIN dbo.Province p ON t.ProvinceID = p.ProvinceID
INNER JOIN dbo.Annee a ON t.AnneeID = a.AnneeID;
GO


USE PrecipitationDB;
GO

CREATE OR ALTER VIEW dbo.vw_Precipitation AS
SELECT
    p.ProvinceID,
    p.CodeProvince,
    p.NomProvince,
    a.AnneeID,
    a.ValeurAnnee AS Annee,
    pr.PrecipitationAnnuelle
FROM dbo.Precipitation pr
INNER JOIN dbo.Province p ON pr.ProvinceID = p.ProvinceID
INNER JOIN dbo.Annee a ON pr.AnneeID = a.AnneeID;
GO


USE PollutionDB;
GO

CREATE OR ALTER VIEW dbo.vw_Pollution AS
SELECT
    p.ProvinceID,
    p.CodeProvince,
    p.NomProvince,
    a.AnneeID,
    a.ValeurAnnee AS Annee,
    po.EmissionGES_MtCO2e
FROM dbo.Pollution po
INNER JOIN dbo.Province p ON po.ProvinceID = p.ProvinceID
INNER JOIN dbo.Annee a ON po.AnneeID = a.AnneeID;
GO
