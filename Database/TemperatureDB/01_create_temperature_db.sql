/* TemperatureDB - creation de la base et des tables (rejouable : ne recree que ce qui manque) */

IF DB_ID('TemperatureDB') IS NULL
    CREATE DATABASE TemperatureDB;
GO

USE TemperatureDB;
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

IF OBJECT_ID('dbo.SourceDonnee', 'U') IS NULL
    CREATE TABLE dbo.SourceDonnee
    (
        SourceID          INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_SourceDonnee PRIMARY KEY,
        NomSource         NVARCHAR(150) NOT NULL,
        AdresseWeb        NVARCHAR(500) NULL,
        DateConsultation  DATE NULL,
        DescriptionSource NVARCHAR(500) NULL
    );
GO

IF OBJECT_ID('dbo.StationMeteo', 'U') IS NULL
    CREATE TABLE dbo.StationMeteo
    (
        StationID   INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_StationMeteo PRIMARY KEY,
        ProvinceID  INT NOT NULL CONSTRAINT FK_StationMeteo_Province REFERENCES dbo.Province(ProvinceID),
        NomStation  NVARCHAR(100) NOT NULL,
        Ville       NVARCHAR(100) NULL,
        CodeStation NVARCHAR(30) NULL CONSTRAINT UQ_StationMeteo_CodeStation UNIQUE
    );
GO

/* TemperatureMoyenne est NULL quand la serie annuelle est incomplete (moins de 12 mois de donnees) */
IF OBJECT_ID('dbo.Temperature', 'U') IS NULL
    CREATE TABLE dbo.Temperature
    (
        TemperatureID      INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Temperature PRIMARY KEY,
        ProvinceID         INT NOT NULL CONSTRAINT FK_Temperature_Province REFERENCES dbo.Province(ProvinceID),
        AnneeID            INT NOT NULL CONSTRAINT FK_Temperature_Annee REFERENCES dbo.Annee(AnneeID),
        TemperatureMoyenne DECIMAL(5,2) NULL,
        StationID          INT NULL CONSTRAINT FK_Temperature_StationMeteo REFERENCES dbo.StationMeteo(StationID),
        SourceID           INT NULL CONSTRAINT FK_Temperature_SourceDonnee REFERENCES dbo.SourceDonnee(SourceID),
        CONSTRAINT UQ_Temperature_Province_Annee UNIQUE (ProvinceID, AnneeID)
    );
GO
