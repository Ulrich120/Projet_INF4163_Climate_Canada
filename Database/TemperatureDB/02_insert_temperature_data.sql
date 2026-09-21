USE TemperatureDB;
GO

-- Température moyenne annuelle (°C)
-- Période 2000-2025. Source : Environnement et Changement climatique Canada
-- Fichier généré par ETL/generate_sql.py, ne pas modifier à la main.

IF NOT EXISTS (SELECT 1 FROM Province)
    INSERT INTO Province (CodeProvince, NomProvince) VALUES
    ('NL', N'Terre-Neuve-et-Labrador'),
    ('PE', N'Île-du-Prince-Édouard'),
    ('NS', N'Nouvelle-Écosse'),
    ('NB', N'Nouveau-Brunswick'),
    ('QC', N'Québec'),
    ('ON', N'Ontario'),
    ('MB', N'Manitoba'),
    ('SK', N'Saskatchewan'),
    ('AB', N'Alberta'),
    ('BC', N'Colombie-Britannique'),
    ('YT', N'Yukon'),
    ('NT', N'Territoires du Nord-Ouest'),
    ('NU', N'Nunavut');

IF NOT EXISTS (SELECT 1 FROM Annee)
    INSERT INTO Annee (ValeurAnnee) VALUES
    (2000),
    (2001),
    (2002),
    (2003),
    (2004),
    (2005),
    (2006),
    (2007),
    (2008),
    (2009),
    (2010),
    (2011),
    (2012),
    (2013),
    (2014),
    (2015),
    (2016),
    (2017),
    (2018),
    (2019),
    (2020),
    (2021),
    (2022),
    (2023),
    (2024),
    (2025);

IF NOT EXISTS (SELECT 1 FROM SourceDonnee)
    INSERT INTO SourceDonnee (NomSource, AdresseWeb, DateConsultation, DescriptionSource)
    VALUES (N'Environnement et Changement climatique Canada', N'https://climate.weather.gc.ca/', CAST(GETDATE() AS DATE), N'Données climatiques historiques officielles du Canada : températures, précipitations et émissions de gaz à effet de serre par province.');

INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.02, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2000;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.31, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2001;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.89, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2002;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.62, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2003;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.81, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2004;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.23, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2005;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.89, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2006;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.68, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2007;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.55, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2008;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.92, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2009;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.03, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2010;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.63, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2011;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.41, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2012;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.99, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2013;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.55, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2014;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.26, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2015;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.53, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2016;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.40, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2017;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.50, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2018;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.01, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2019;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.89, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2020;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.45, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2021;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.15, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2022;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.76, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2023;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.67, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2024;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.65, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2025;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.97, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2000;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.20, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2001;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.21, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2002;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.74, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2003;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.36, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2004;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.78, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2005;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.65, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2006;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.12, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2007;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.61, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2008;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.02, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2009;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.88, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2010;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.94, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2011;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.49, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2012;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.02, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2013;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.11, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2014;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 9.06, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2015;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.79, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2016;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.66, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2017;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.16, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2018;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.85, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2019;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.09, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2020;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.06, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2021;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.89, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2022;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 9.01, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2023;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.57, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2024;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.70, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2025;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.73, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2000;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.84, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2001;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.17, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2002;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.76, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2003;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 0.61, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2004;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.09, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2005;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.94, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2006;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.27, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2007;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 0.34, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2008;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 0.84, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2009;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.95, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2010;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.03, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2011;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.78, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2012;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -0.06, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2013;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -0.11, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2014;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.47, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2015;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.87, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2016;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.73, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2017;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 0.44, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2018;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 0.05, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2019;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.29, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2020;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.21, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2021;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 0.12, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2022;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.39, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2023;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.10, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2024;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.54, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2025;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.29, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2000;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.08, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2001;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.34, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2002;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.09, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2003;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.77, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2004;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.63, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2005;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.78, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2006;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.83, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2007;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.15, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2008;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.99, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2009;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.90, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2010;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.62, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2011;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.28, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2012;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.20, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2013;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.90, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2014;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.65, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2015;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.82, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2016;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.59, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2017;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.13, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2018;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.54, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2019;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.04, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2020;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.59, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2021;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.16, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2022;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.47, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2023;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.97, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2024;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.81, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2025;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.53, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2000;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.35, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2001;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.19, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2002;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.96, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2003;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.01, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2004;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.22, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2005;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.04, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2006;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.13, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2007;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.60, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2008;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.37, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2009;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.27, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2010;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.35, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2011;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.59, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2012;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.56, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2013;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.03, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2014;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.22, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2015;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.38, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2016;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.25, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2017;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.06, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2018;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.74, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2019;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.40, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2020;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.66, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2021;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.41, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2022;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.15, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2023;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.20, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2024;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.45, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2025;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.00, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2000;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.14, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2001;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.62, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2002;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.63, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2003;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.12, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2004;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.05, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2005;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.13, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2006;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.34, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2007;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.09, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2008;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.65, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2009;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.09, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2010;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.39, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2011;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.17, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2012;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.97, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2013;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.08, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2014;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.34, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2015;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.38, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2016;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.27, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2017;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.98, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2018;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.44, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2019;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.65, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2020;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.08, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2021;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.03, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2022;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.88, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2023;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 8.06, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2024;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.39, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2025;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -7.03, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2000;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -6.04, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2001;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -6.80, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2002;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -6.51, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2003;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -8.47, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2004;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -5.91, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2005;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -5.00, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2006;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -6.75, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2007;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -6.88, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2008;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -6.51, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2009;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -4.17, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2010;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -5.68, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2011;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -5.52, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2012;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -6.51, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2013;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -5.79, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2014;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -5.04, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2015;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -4.38, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2016;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -4.50, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2017;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -5.85, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2018;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -5.38, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2019;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -6.46, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2020;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -6.54, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2021;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -6.28, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2022;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -3.46, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2023;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -4.79, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2024;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -4.76, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2025;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -11.70, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2000;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -10.99, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2001;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -11.82, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2002;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -11.23, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2003;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -13.74, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2004;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -11.51, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2005;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -9.86, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2006;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -11.84, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2007;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -12.03, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2008;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -11.14, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2009;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -8.40, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2010;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -11.16, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2011;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -10.85, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2012;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -11.77, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2013;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -11.59, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2014;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -12.56, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2015;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -10.76, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2016;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -11.31, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2017;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -12.77, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2018;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -10.82, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2019;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -11.32, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2020;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -9.98, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2021;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -11.27, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2022;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -10.01, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2023;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -9.02, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2024;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -9.56, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2025;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.01, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2000;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.20, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2001;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.63, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2002;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.50, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2003;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.53, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2004;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.44, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2005;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.14, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2006;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.11, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2007;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.46, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2008;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.32, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2009;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.08, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2010;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.42, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2011;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.61, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2012;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.32, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2013;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.39, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2014;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.57, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2015;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.73, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2016;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.03, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2017;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.36, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2018;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.51, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2019;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.05, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2020;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.66, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2021;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.15, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2022;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.42, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2023;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.26, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2024;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.27, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2025;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.26, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2000;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.59, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2001;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.89, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2002;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.84, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2003;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.52, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2004;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.24, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2005;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.55, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2006;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.79, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2007;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.34, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2008;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.04, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2009;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.68, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2010;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.62, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2011;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.34, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2012;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.18, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2013;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.20, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2014;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.63, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2015;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.64, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2016;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.53, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2017;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.01, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2018;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.74, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2019;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.03, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2020;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.52, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2021;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.32, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2022;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.09, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2023;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 7.75, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2024;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 6.82, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2025;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.84, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2000;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.88, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2001;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.14, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2002;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.52, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2003;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.50, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2004;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.52, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2005;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.43, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2006;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.72, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2007;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.09, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2008;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.80, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2009;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.87, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2010;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.71, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2011;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 5.28, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2012;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.02, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2013;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.58, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2014;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.50, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2015;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.31, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2016;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.96, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2017;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.21, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2018;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.10, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2019;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.25, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2020;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.44, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2021;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.19, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2022;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.30, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2023;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 4.18, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2024;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.44, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2025;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.06, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2000;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.47, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2001;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.62, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2002;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.36, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2003;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.76, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2004;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.92, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2005;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.52, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2006;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.53, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2007;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.47, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2008;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.06, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2009;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.65, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2010;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.38, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2011;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.97, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2012;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 0.93, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2013;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 0.86, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2014;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.21, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2015;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.62, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2016;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.58, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2017;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.03, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2018;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 0.77, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2019;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.84, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2020;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.62, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2021;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 1.28, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2022;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.38, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2023;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 3.06, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2024;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, 2.30, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2025;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -3.38, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2000;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -3.13, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2001;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -2.95, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2002;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -3.38, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2003;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -3.80, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2004;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -2.63, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2005;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -3.99, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2006;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -3.80, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2007;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -4.59, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2008;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -4.10, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2009;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -2.51, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2010;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -3.90, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2011;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -4.44, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2012;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -3.56, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2013;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -3.05, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2014;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -2.49, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2015;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -1.91, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2016;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -3.27, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2017;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -3.74, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2018;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -2.16, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2019;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -4.33, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2020;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -4.38, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2021;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -3.51, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2022;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -1.61, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2023;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -2.92, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2024;
INSERT INTO Temperature (ProvinceID, AnneeID, TemperatureMoyenne, SourceID) SELECT p.ProvinceID, a.AnneeID, -2.52, 1 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2025;
GO

-- Vérification
SELECT COUNT(*) AS NombreLignes FROM Temperature;
