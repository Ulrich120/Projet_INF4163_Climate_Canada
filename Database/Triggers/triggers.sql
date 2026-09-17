/* PROJET INF4163 - DECLENCHEURS */


/* TRIGGER 1 - TEMPERATURE
   Refuse une température annuelle hors d'une plage réaliste. */

USE TemperatureDB;
GO

CREATE OR ALTER TRIGGER dbo.trg_ValidateTemperature
ON dbo.Temperature
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM inserted
        WHERE
            TemperatureMoyenne < -100
            OR TemperatureMoyenne > 70
    )
    BEGIN
        RAISERROR(
            'Temperature invalide : la valeur doit etre comprise entre -100 et 70 degres Celsius.',
            16,
            1
        );

        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO


/* TRIGGER 2 - PRECIPITATIONS
   Refuse toute précipitation négative. */

USE PrecipitationDB;
GO

CREATE OR ALTER TRIGGER dbo.trg_ValidatePrecipitation
ON dbo.Precipitation
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM inserted
        WHERE PrecipitationAnnuelle < 0
    )
    BEGIN
        RAISERROR(
            'Precipitation invalide : une precipitation ne peut pas etre negative.',
            16,
            1
        );

        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO


/* TRIGGER 3 - POLLUTION
   Refuse une émission négative.
   NULL reste autorisé pour 2025. */

USE PollutionDB;
GO

CREATE OR ALTER TRIGGER dbo.trg_ValidatePollution
ON dbo.Pollution
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS
    (
        SELECT 1
        FROM inserted
        WHERE
            EmissionGES_MtCO2e IS NOT NULL
            AND EmissionGES_MtCO2e < 0
    )
    BEGIN
        RAISERROR(
            'Emission invalide : les emissions de GES ne peuvent pas etre negatives.',
            16,
            1
        );

        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO
