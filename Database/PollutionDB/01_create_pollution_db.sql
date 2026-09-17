CREATE DATABASE PollutionDB;
GO

USE PollutionDB;
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

CREATE TABLE PollutionCO2
(
    PollutionID INT IDENTITY(1,1) PRIMARY KEY,
    ProvinceID INT NOT NULL,
    AnneeID INT NOT NULL,
    EmissionCO2 DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_Pollution_Province
        FOREIGN KEY (ProvinceID)
        REFERENCES Province(ProvinceID),

    CONSTRAINT FK_Pollution_Annee
        FOREIGN KEY (AnneeID)
        REFERENCES Annee(AnneeID),

    CONSTRAINT UQ_Pollution UNIQUE (ProvinceID, AnneeID)
);
GO