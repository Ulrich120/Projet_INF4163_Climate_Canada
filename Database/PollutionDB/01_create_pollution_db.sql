/* PollutionDB - creation de la base et des tables (rejouable : ne recree que ce qui manque) */

IF DB_ID('PollutionDB') IS NULL
    CREATE DATABASE PollutionDB;
GO

USE PollutionDB;
GO

IF OBJECT_ID('dbo.Province', 'U') IS NULL
    CREATE TABLE dbo.Province
    (
        ProvinceID   INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Province PRIMARY KEY,
        CodeProvince CHAR(2) NOT NULL CONSTRAINT UQ_Province_Code UNIQUE,
        NomProvince  NVARCHAR(60) NOT NULL
    );
GO

IF OBJECT_ID('dbo.Annee', 'U') IS NULL
    CREATE TABLE dbo.Annee
    (
        AnneeID     INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Annee PRIMARY KEY,
        ValeurAnnee INT NOT NULL CONSTRAINT UQ_Annee_Valeur UNIQUE
    );
GO

/* EmissionGES_MtCO2e est NULL quand ECCC n'a pas encore publie l'annee (megatonnes de CO2 equivalent) */
IF OBJECT_ID('dbo.Pollution', 'U') IS NULL
    CREATE TABLE dbo.Pollution
    (
        PollutionID        INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Pollution PRIMARY KEY,
        ProvinceID         INT NOT NULL CONSTRAINT FK_Pollution_Province REFERENCES dbo.Province(ProvinceID),
        AnneeID            INT NOT NULL CONSTRAINT FK_Pollution_Annee REFERENCES dbo.Annee(AnneeID),
        EmissionGES_MtCO2e DECIMAL(10,2) NULL,
        CONSTRAINT UQ_Pollution_Province_Annee UNIQUE (ProvinceID, AnneeID)
    );
GO
