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


/* Anomalies par station : c'est la serie a utiliser pour une tendance (la moyenne simple de
   vw_Temperature n'est pas comparable d'une annee a l'autre). ProvinceID NULL = Canada. */
CREATE OR ALTER VIEW dbo.vw_TemperatureAnomalie AS
SELECT
    t.ProvinceID,
    ISNULL(p.CodeProvince, 'CA') AS CodeProvince,
    ISNULL(p.NomProvince, N'Canada (moyenne des provinces)') AS NomProvince,
    a.AnneeID,
    a.ValeurAnnee AS Annee,
    t.AnomalieStationsLongues,
    t.AnomalieToutesStations,
    t.MoyenneSimple
FROM dbo.TemperatureAnomalie t
LEFT JOIN dbo.Province p ON t.ProvinceID = p.ProvinceID
INNER JOIN dbo.Annee a ON t.AnneeID = a.AnneeID;
GO

CREATE OR ALTER VIEW dbo.vw_TemperatureTendance AS
SELECT
    t.ProvinceID,
    ISNULL(p.CodeProvince, 'CA') AS CodeProvince,
    ISNULL(p.NomProvince, N'Canada (moyenne des provinces)') AS NomProvince,
    t.Methode,
    t.PenteParDecennie,
    t.IC95_Bas,
    t.IC95_Haut,
    t.PValeur,
    t.NbAnnees
FROM dbo.TemperatureTendance t
LEFT JOIN dbo.Province p ON t.ProvinceID = p.ProvinceID;
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


/* Anomalies en % de la normale de la station : serie a utiliser pour une tendance (le cumul simple
   de vw_Precipitation n'est pas comparable d'une annee a l'autre). ProvinceID NULL = Canada. */
CREATE OR ALTER VIEW dbo.vw_PrecipitationAnomalie AS
SELECT
    t.ProvinceID,
    ISNULL(p.CodeProvince, 'CA') AS CodeProvince,
    ISNULL(p.NomProvince, N'Canada (moyenne des provinces)') AS NomProvince,
    a.AnneeID,
    a.ValeurAnnee AS Annee,
    t.AnomalieStationsLongues,
    t.AnomalieToutesStations,
    t.MoyenneSimple
FROM dbo.PrecipitationAnomalie t
LEFT JOIN dbo.Province p ON t.ProvinceID = p.ProvinceID
INNER JOIN dbo.Annee a ON t.AnneeID = a.AnneeID;
GO

CREATE OR ALTER VIEW dbo.vw_PrecipitationTendance AS
SELECT
    t.ProvinceID,
    ISNULL(p.CodeProvince, 'CA') AS CodeProvince,
    ISNULL(p.NomProvince, N'Canada (moyenne des provinces)') AS NomProvince,
    t.Methode,
    t.PenteParDecennie,
    t.IC95_Bas,
    t.IC95_Haut,
    t.PValeur,
    t.NbAnnees
FROM dbo.PrecipitationTendance t
LEFT JOIN dbo.Province p ON t.ProvinceID = p.ProvinceID;
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
