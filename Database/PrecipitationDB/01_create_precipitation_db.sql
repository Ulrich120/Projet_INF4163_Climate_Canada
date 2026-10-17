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

/* Anomalies annuelles par station, en % de la normale de la station (voir Data/README.md).
   ProvinceID NULL = Canada (moyenne des provinces). NULL = pas assez de stations de longue duree.
   MoyenneSimple = cumul annuel simple des stations actives, en mm (non comparable dans le temps). */
IF OBJECT_ID('dbo.PrecipitationAnomalie', 'U') IS NULL
    CREATE TABLE dbo.PrecipitationAnomalie
    (
        AnomalieID              INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PrecipitationAnomalie PRIMARY KEY,
        ProvinceID              INT NULL CONSTRAINT FK_PrecipitationAnomalie_Province REFERENCES dbo.Province(ProvinceID),
        AnneeID                 INT NOT NULL CONSTRAINT FK_PrecipitationAnomalie_Annee REFERENCES dbo.Annee(AnneeID),
        AnomalieStationsLongues DECIMAL(8,3) NULL,
        AnomalieToutesStations  DECIMAL(8,3) NULL,
        MoyenneSimple           DECIMAL(9,3) NULL,
        NbStationsLongues       DECIMAL(7,1) NULL,
        CONSTRAINT UQ_PrecipitationAnomalie_Province_Annee UNIQUE (ProvinceID, AnneeID)
    );
GO

/* Tendance lineaire par province et par methode (pente en % de la normale par decennie pour les anomalies,
   en mm par decennie pour la methode moyenne_simple, IC a 95 %). */
IF OBJECT_ID('dbo.PrecipitationTendance', 'U') IS NULL
    CREATE TABLE dbo.PrecipitationTendance
    (
        TendanceID       INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_PrecipitationTendance PRIMARY KEY,
        ProvinceID       INT NULL CONSTRAINT FK_PrecipitationTendance_Province REFERENCES dbo.Province(ProvinceID),
        Methode          NVARCHAR(40) NOT NULL,
        PenteParDecennie DECIMAL(8,4) NULL,
        IC95_Bas         DECIMAL(8,4) NULL,
        IC95_Haut        DECIMAL(8,4) NULL,
        PValeur          DECIMAL(9,6) NULL,
        NbAnnees         INT NOT NULL,
        CONSTRAINT UQ_PrecipitationTendance_Province_Methode UNIQUE (ProvinceID, Methode)
    );
GO
