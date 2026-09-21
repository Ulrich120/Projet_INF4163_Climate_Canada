/* PrecipitationDB - creation de la base et des tables (rejouable : ne recree que ce qui manque) */

IF DB_ID('PrecipitationDB') IS NULL
    CREATE DATABASE PrecipitationDB;
GO

USE PrecipitationDB;
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

/* PrecipitationAnnuelle (mm) est NULL quand la serie annuelle est incomplete (moins de 12 mois de donnees) */
IF OBJECT_ID('dbo.Precipitation', 'U') IS NULL
    CREATE TABLE dbo.Precipitation
    (
        PrecipitationID      INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Precipitation PRIMARY KEY,
        ProvinceID           INT NOT NULL CONSTRAINT FK_Precipitation_Province REFERENCES dbo.Province(ProvinceID),
        AnneeID              INT NOT NULL CONSTRAINT FK_Precipitation_Annee REFERENCES dbo.Annee(AnneeID),
        PrecipitationAnnuelle DECIMAL(10,2) NULL,
        CONSTRAINT UQ_Precipitation_Province_Annee UNIQUE (ProvinceID, AnneeID)
    );
GO
