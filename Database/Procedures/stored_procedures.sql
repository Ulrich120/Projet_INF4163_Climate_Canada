/* PROJET INF4163 - PROCEDURES STOCKEES
   Sensibilisation au rechauffement climatique */


/* 1. TEMPERATURE - ANNEE LA PLUS / MOINS CHAUDE */

USE TemperatureDB;
GO

CREATE OR ALTER PROCEDURE dbo.sp_AnneePlusMoinsChaude
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH MoyennesAnnuelles AS
    (
        SELECT
            a.ValeurAnnee AS Annee,
            AVG(CAST(t.TemperatureMoyenne AS DECIMAL(10,2)))
                AS TemperatureMoyenne
        FROM Temperature t
        INNER JOIN Annee a
            ON t.AnneeID = a.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        GROUP BY a.ValeurAnnee
    )

    SELECT TOP 1
        'Annee la plus chaude' AS Resultat,
        Annee,
        CAST(TemperatureMoyenne AS DECIMAL(10,2))
            AS TemperatureMoyenne
    FROM MoyennesAnnuelles
    ORDER BY TemperatureMoyenne DESC, Annee ASC;

    ;WITH MoyennesAnnuelles AS
    (
        SELECT
            a.ValeurAnnee AS Annee,
            AVG(CAST(t.TemperatureMoyenne AS DECIMAL(10,2)))
                AS TemperatureMoyenne
        FROM Temperature t
        INNER JOIN Annee a
            ON t.AnneeID = a.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        GROUP BY a.ValeurAnnee
    )

    SELECT TOP 1
        'Annee la moins chaude' AS Resultat,
        Annee,
        CAST(TemperatureMoyenne AS DECIMAL(10,2))
            AS TemperatureMoyenne
    FROM MoyennesAnnuelles
    ORDER BY TemperatureMoyenne ASC, Annee ASC;
END;
GO


/* 2. TEMPERATURE - PROVINCE LA PLUS / MOINS CHAUDE */

CREATE OR ALTER PROCEDURE dbo.sp_ProvincePlusMoinsChaude
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH MoyennesProvinciales AS
    (
        SELECT
            p.CodeProvince,
            p.NomProvince,
            AVG(CAST(t.TemperatureMoyenne AS DECIMAL(10,2)))
                AS TemperatureMoyenne
        FROM Temperature t
        INNER JOIN Province p
            ON t.ProvinceID = p.ProvinceID
        INNER JOIN Annee a
            ON t.AnneeID = a.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        GROUP BY
            p.CodeProvince,
            p.NomProvince
    )

    SELECT TOP 1
        'Province la plus chaude' AS Resultat,
        CodeProvince,
        NomProvince,
        CAST(TemperatureMoyenne AS DECIMAL(10,2))
            AS TemperatureMoyenne
    FROM MoyennesProvinciales
    ORDER BY TemperatureMoyenne DESC, CodeProvince ASC;

    ;WITH MoyennesProvinciales AS
    (
        SELECT
            p.CodeProvince,
            p.NomProvince,
            AVG(CAST(t.TemperatureMoyenne AS DECIMAL(10,2)))
                AS TemperatureMoyenne
        FROM Temperature t
        INNER JOIN Province p
            ON t.ProvinceID = p.ProvinceID
        INNER JOIN Annee a
            ON t.AnneeID = a.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        GROUP BY
            p.CodeProvince,
            p.NomProvince
    )

    SELECT TOP 1
        'Province la moins chaude' AS Resultat,
        CodeProvince,
        NomProvince,
        CAST(TemperatureMoyenne AS DECIMAL(10,2))
            AS TemperatureMoyenne
    FROM MoyennesProvinciales
    ORDER BY TemperatureMoyenne ASC, CodeProvince ASC;
END;
GO


/* 3. POLLUTION - ANNEE LA PLUS / MOINS POLLUEE */

USE PollutionDB;
GO

CREATE OR ALTER PROCEDURE dbo.sp_AnneePlusMoinsPolluee
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH MoyennesAnnuelles AS
    (
        SELECT
            a.ValeurAnnee AS Annee,
            AVG(CAST(po.EmissionGES_MtCO2e AS DECIMAL(12,2)))
                AS EmissionMoyenne,
            COUNT(po.EmissionGES_MtCO2e)
                AS NombreValeursDisponibles
        FROM Pollution po
        INNER JOIN Annee a
            ON po.AnneeID = a.AnneeID
        WHERE
            a.ValeurAnnee BETWEEN 2023 AND 2025
            AND po.EmissionGES_MtCO2e IS NOT NULL
        GROUP BY a.ValeurAnnee
    )

    SELECT TOP 1
        'Annee la plus polluee' AS Resultat,
        Annee,
        CAST(EmissionMoyenne AS DECIMAL(12,2))
            AS EmissionMoyenne_MtCO2e,
        NombreValeursDisponibles
    FROM MoyennesAnnuelles
    ORDER BY EmissionMoyenne DESC, Annee ASC;

    ;WITH MoyennesAnnuelles AS
    (
        SELECT
            a.ValeurAnnee AS Annee,
            AVG(CAST(po.EmissionGES_MtCO2e AS DECIMAL(12,2)))
                AS EmissionMoyenne,
            COUNT(po.EmissionGES_MtCO2e)
                AS NombreValeursDisponibles
        FROM Pollution po
        INNER JOIN Annee a
            ON po.AnneeID = a.AnneeID
        WHERE
            a.ValeurAnnee BETWEEN 2023 AND 2025
            AND po.EmissionGES_MtCO2e IS NOT NULL
        GROUP BY a.ValeurAnnee
    )

    SELECT TOP 1
        'Annee la moins polluee' AS Resultat,
        Annee,
        CAST(EmissionMoyenne AS DECIMAL(12,2))
            AS EmissionMoyenne_MtCO2e,
        NombreValeursDisponibles
    FROM MoyennesAnnuelles
    ORDER BY EmissionMoyenne ASC, Annee ASC;
END;
GO


/* 4. POLLUTION - PROVINCE LA PLUS / MOINS POLLUEE */

CREATE OR ALTER PROCEDURE dbo.sp_ProvincePlusMoinsPolluee
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH MoyennesProvinciales AS
    (
        SELECT
            p.CodeProvince,
            p.NomProvince,
            AVG(CAST(po.EmissionGES_MtCO2e AS DECIMAL(12,2)))
                AS EmissionMoyenne,
            COUNT(po.EmissionGES_MtCO2e)
                AS NombreAnneesDisponibles
        FROM Pollution po
        INNER JOIN Province p
            ON po.ProvinceID = p.ProvinceID
        INNER JOIN Annee a
            ON po.AnneeID = a.AnneeID
        WHERE
            a.ValeurAnnee BETWEEN 2023 AND 2025
            AND po.EmissionGES_MtCO2e IS NOT NULL
        GROUP BY
            p.CodeProvince,
            p.NomProvince
    )

    SELECT TOP 1
        'Province la plus polluee' AS Resultat,
        CodeProvince,
        NomProvince,
        CAST(EmissionMoyenne AS DECIMAL(12,2))
            AS EmissionMoyenne_MtCO2e,
        NombreAnneesDisponibles
    FROM MoyennesProvinciales
    ORDER BY EmissionMoyenne DESC, CodeProvince ASC;

    ;WITH MoyennesProvinciales AS
    (
        SELECT
            p.CodeProvince,
            p.NomProvince,
            AVG(CAST(po.EmissionGES_MtCO2e AS DECIMAL(12,2)))
                AS EmissionMoyenne,
            COUNT(po.EmissionGES_MtCO2e)
                AS NombreAnneesDisponibles
        FROM Pollution po
        INNER JOIN Province p
            ON po.ProvinceID = p.ProvinceID
        INNER JOIN Annee a
            ON po.AnneeID = a.AnneeID
        WHERE
            a.ValeurAnnee BETWEEN 2023 AND 2025
            AND po.EmissionGES_MtCO2e IS NOT NULL
        GROUP BY
            p.CodeProvince,
            p.NomProvince
    )

    SELECT TOP 1
        'Province la moins polluee' AS Resultat,
        CodeProvince,
        NomProvince,
        CAST(EmissionMoyenne AS DECIMAL(12,2))
            AS EmissionMoyenne_MtCO2e,
        NombreAnneesDisponibles
    FROM MoyennesProvinciales
    ORDER BY EmissionMoyenne ASC, CodeProvince ASC;
END;
GO


/* 5. PRECIPITATIONS - ANNEE LA PLUS / MOINS PLUVIEUSE */

USE PrecipitationDB;
GO

CREATE OR ALTER PROCEDURE dbo.sp_AnneePlusMoinsPluvieuse
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH MoyennesAnnuelles AS
    (
        SELECT
            a.ValeurAnnee AS Annee,
            AVG(CAST(pr.PrecipitationAnnuelle AS DECIMAL(12,2)))
                AS PrecipitationMoyenne
        FROM Precipitation pr
        INNER JOIN Annee a
            ON pr.AnneeID = a.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        GROUP BY a.ValeurAnnee
    )

    SELECT TOP 1
        'Annee la plus pluvieuse' AS Resultat,
        Annee,
        CAST(PrecipitationMoyenne AS DECIMAL(12,2))
            AS PrecipitationMoyenne_mm
    FROM MoyennesAnnuelles
    ORDER BY PrecipitationMoyenne DESC, Annee ASC;

    ;WITH MoyennesAnnuelles AS
    (
        SELECT
            a.ValeurAnnee AS Annee,
            AVG(CAST(pr.PrecipitationAnnuelle AS DECIMAL(12,2)))
                AS PrecipitationMoyenne
        FROM Precipitation pr
        INNER JOIN Annee a
            ON pr.AnneeID = a.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        GROUP BY a.ValeurAnnee
    )

    SELECT TOP 1
        'Annee la moins pluvieuse' AS Resultat,
        Annee,
        CAST(PrecipitationMoyenne AS DECIMAL(12,2))
            AS PrecipitationMoyenne_mm
    FROM MoyennesAnnuelles
    ORDER BY PrecipitationMoyenne ASC, Annee ASC;
END;
GO


/* 6. PRECIPITATIONS - PROVINCE LA PLUS / MOINS PLUVIEUSE */

CREATE OR ALTER PROCEDURE dbo.sp_ProvincePlusMoinsPluvieuse
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH MoyennesProvinciales AS
    (
        SELECT
            p.CodeProvince,
            p.NomProvince,
            AVG(CAST(pr.PrecipitationAnnuelle AS DECIMAL(12,2)))
                AS PrecipitationMoyenne
        FROM Precipitation pr
        INNER JOIN Province p
            ON pr.ProvinceID = p.ProvinceID
        INNER JOIN Annee a
            ON pr.AnneeID = a.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        GROUP BY
            p.CodeProvince,
            p.NomProvince
    )

    SELECT TOP 1
        'Province la plus pluvieuse' AS Resultat,
        CodeProvince,
        NomProvince,
        CAST(PrecipitationMoyenne AS DECIMAL(12,2))
            AS PrecipitationMoyenne_mm
    FROM MoyennesProvinciales
    ORDER BY PrecipitationMoyenne DESC, CodeProvince ASC;

    ;WITH MoyennesProvinciales AS
    (
        SELECT
            p.CodeProvince,
            p.NomProvince,
            AVG(CAST(pr.PrecipitationAnnuelle AS DECIMAL(12,2)))
                AS PrecipitationMoyenne
        FROM Precipitation pr
        INNER JOIN Province p
            ON pr.ProvinceID = p.ProvinceID
        INNER JOIN Annee a
            ON pr.AnneeID = a.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        GROUP BY
            p.CodeProvince,
            p.NomProvince
    )

    SELECT TOP 1
        'Province la moins pluvieuse' AS Resultat,
        CodeProvince,
        NomProvince,
        CAST(PrecipitationMoyenne AS DECIMAL(12,2))
            AS PrecipitationMoyenne_mm
    FROM MoyennesProvinciales
    ORDER BY PrecipitationMoyenne ASC, CodeProvince ASC;
END;
GO
