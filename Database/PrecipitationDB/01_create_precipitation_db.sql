CREATE DATABASE PrecipitationDB;
GO

USE PrecipitationDB;
GO

CREATE TABLE Province
(
    ProvinceID INT IDENTITY(1,1) PRIMARY KEY,
    CodeProvince CHAR(2) NOT NULL UNIQUE,
    NomProvince NVARCHAR(60) NOT NULL
);

CREATE TABLE Annee
(
    AnneeID INT IDENTITY(1,1) PRIMARY KEY,
    ValeurAnnee INT NOT NULL UNIQUE
);

CREATE TABLE Precipitation
(
    PrecipitationID INT IDENTITY(1,1) PRIMARY KEY,
    ProvinceID INT NOT NULL,
    AnneeID INT NOT NULL,
    PrecipitationMoyenne DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_Precipitation_Province
        FOREIGN KEY (ProvinceID)
        REFERENCES Province(ProvinceID),

    CONSTRAINT FK_Precipitation_Annee
        FOREIGN KEY (AnneeID)
        REFERENCES Annee(AnneeID),

    CONSTRAINT UQ_Precipitation UNIQUE (ProvinceID, AnneeID)
);
GO