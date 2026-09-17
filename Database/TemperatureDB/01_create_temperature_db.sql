USE [TemperatureDB]
GO

/****** Objet : Table [dbo].[Annee] Date de script : 10/08/2026 07:42:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Annee](
	[AnneeID] [int] IDENTITY(1,1) NOT NULL,
	[ValeurAnnee] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AnneeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ValeurAnnee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Objet : Table [dbo].[Province] Date de script : 10/08/2026 07:42:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Province](
	[ProvinceID] [int] IDENTITY(1,1) NOT NULL,
	[CodeProvince] [char](2) NOT NULL,
	[NomProvince] [nvarchar](60) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProvinceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[CodeProvince] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Objet : Table [dbo].[SourceDonnee] Date de script : 10/08/2026 07:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SourceDonnee](
	[SourceID] [int] IDENTITY(1,1) NOT NULL,
	[NomSource] [nvarchar](150) NOT NULL,
	[AdresseWeb] [nvarchar](500) NULL,
	[DateConsultation] [date] NULL,
	[DescriptionSource] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Objet : Table [dbo].[StationMeteo] Date de script : 10/08/2026 07:42:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[StationMeteo](
	[StationID] [int] IDENTITY(1,1) NOT NULL,
	[ProvinceID] [int] NOT NULL,
	[NomStation] [nvarchar](100) NOT NULL,
	[Ville] [nvarchar](100) NULL,
	[CodeStation] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[StationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_StationMeteo_CodeStation] UNIQUE NONCLUSTERED 
(
	[CodeStation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Objet : Table [dbo].[Temperature] Date de script : 10/08/2026 07:42:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Temperature](
	[TemperatureID] [int] IDENTITY(1,1) NOT NULL,
	[ProvinceID] [int] NOT NULL,
	[AnneeID] [int] NOT NULL,
	[TemperatureMoyenne] [decimal](5, 2) NOT NULL,
	[StationID] [int] NULL,
	[SourceID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TemperatureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Temperature_Province_Annee] UNIQUE NONCLUSTERED 
(
	[ProvinceID] ASC,
	[AnneeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[StationMeteo]  WITH CHECK ADD  CONSTRAINT [FK_StationMeteo_Province] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Province] ([ProvinceID])
GO

ALTER TABLE [dbo].[StationMeteo] CHECK CONSTRAINT [FK_StationMeteo_Province]
GO

ALTER TABLE [dbo].[Temperature]  WITH CHECK ADD  CONSTRAINT [FK_Temperature_Annee] FOREIGN KEY([AnneeID])
REFERENCES [dbo].[Annee] ([AnneeID])
GO

ALTER TABLE [dbo].[Temperature] CHECK CONSTRAINT [FK_Temperature_Annee]
GO

ALTER TABLE [dbo].[Temperature]  WITH CHECK ADD  CONSTRAINT [FK_Temperature_Province] FOREIGN KEY([ProvinceID])
REFERENCES [dbo].[Province] ([ProvinceID])
GO

ALTER TABLE [dbo].[Temperature] CHECK CONSTRAINT [FK_Temperature_Province]
GO

ALTER TABLE [dbo].[Temperature]  WITH CHECK ADD  CONSTRAINT [FK_Temperature_SourceDonnee] FOREIGN KEY([SourceID])
REFERENCES [dbo].[SourceDonnee] ([SourceID])
GO

ALTER TABLE [dbo].[Temperature] CHECK CONSTRAINT [FK_Temperature_SourceDonnee]
GO

ALTER TABLE [dbo].[Temperature]  WITH CHECK ADD  CONSTRAINT [FK_Temperature_StationMeteo] FOREIGN KEY([StationID])
REFERENCES [dbo].[StationMeteo] ([StationID])
GO

ALTER TABLE [dbo].[Temperature] CHECK CONSTRAINT [FK_Temperature_StationMeteo]
GO

/****** Objet : StoredProcedure [dbo].[sp_AnneePlusMoinsChaude] Date de script : 10/08/2026 07:42:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_AnneePlusMoinsChaude]
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH X AS
    (
        SELECT
            a.ValeurAnnee AS Annee,
            AVG(CAST(t.TemperatureMoyenne AS DECIMAL(10,2))) AS Moyenne
        FROM dbo.Temperature t
        JOIN dbo.Annee a ON a.AnneeID = t.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        GROUP BY a.ValeurAnnee
    )
    SELECT TOP 1
        'Annee la plus chaude' AS Resultat,
        Annee,
        CAST(Moyenne AS DECIMAL(10,2)) AS TemperatureMoyenne
    FROM X
    ORDER BY Moyenne DESC;

    ;WITH X AS
    (
        SELECT
            a.ValeurAnnee AS Annee,
            AVG(CAST(t.TemperatureMoyenne AS DECIMAL(10,2))) AS Moyenne
        FROM dbo.Temperature t
        JOIN dbo.Annee a ON a.AnneeID = t.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        GROUP BY a.ValeurAnnee
    )
    SELECT TOP 1
        'Annee la moins chaude' AS Resultat,
        Annee,
        CAST(Moyenne AS DECIMAL(10,2)) AS TemperatureMoyenne
    FROM X
    ORDER BY Moyenne ASC;
END;
GO
/****** Objet : StoredProcedure [dbo].[sp_ProvincePlusMoinsChaude] Date de script : 10/08/2026 07:42:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[sp_ProvincePlusMoinsChaude]
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH X AS
    (
        SELECT
            p.CodeProvince,
            p.NomProvince,
            AVG(CAST(t.TemperatureMoyenne AS DECIMAL(10,2))) AS Moyenne
        FROM dbo.Temperature t
        JOIN dbo.Province p ON p.ProvinceID = t.ProvinceID
        JOIN dbo.Annee a ON a.AnneeID = t.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        GROUP BY p.CodeProvince, p.NomProvince
    )
    SELECT TOP 1
        'Province la plus chaude' AS Resultat,
        CodeProvince,
        NomProvince,
        CAST(Moyenne AS DECIMAL(10,2)) AS TemperatureMoyenne
    FROM X
    ORDER BY Moyenne DESC;

    ;WITH X AS
    (
        SELECT
            p.CodeProvince,
            p.NomProvince,
            AVG(CAST(t.TemperatureMoyenne AS DECIMAL(10,2))) AS Moyenne
        FROM dbo.Temperature t
        JOIN dbo.Province p ON p.ProvinceID = t.ProvinceID
        JOIN dbo.Annee a ON a.AnneeID = t.AnneeID
        WHERE a.ValeurAnnee BETWEEN 2023 AND 2025
        GROUP BY p.CodeProvince, p.NomProvince
    )
    SELECT TOP 1
        'Province la moins chaude' AS Resultat,
        CodeProvince,
        NomProvince,
        CAST(Moyenne AS DECIMAL(10,2)) AS TemperatureMoyenne
    FROM X
    ORDER BY Moyenne ASC;
END;
GO
