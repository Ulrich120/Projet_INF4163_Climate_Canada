USE PollutionDB;
GO

-- Émissions annuelles de GES (Mt CO2e), NULL = donnée officielle non publiée
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

INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 235.60 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2000;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 236.00 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2001;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 237.99 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2002;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 246.46 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2003;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 245.31 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2004;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 251.17 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2005;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 260.23 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2006;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 268.44 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2007;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 266.71 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2008;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 259.87 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2009;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 269.03 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2010;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 277.40 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2011;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 284.66 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2012;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 291.53 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2013;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 293.61 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2014;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 288.55 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2015;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 274.78 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2016;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 284.49 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2017;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 283.40 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2018;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 285.14 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2019;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 264.69 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2020;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 266.93 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2021;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 262.05 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2022;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 260.08 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2023;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 260.14 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2024;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2025;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 63.24 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2000;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 64.56 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2001;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 61.67 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2002;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 61.70 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2003;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 63.82 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2004;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 62.25 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2005;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 60.84 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2006;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 61.68 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2007;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 62.08 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2008;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 58.64 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2009;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 59.48 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2010;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 58.34 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2011;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 58.62 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2012;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 59.51 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2013;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 58.93 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2014;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 58.44 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2015;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 60.49 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2016;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 61.36 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2017;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 63.37 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2018;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 61.94 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2019;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 57.71 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2020;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 58.98 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2021;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 60.14 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2022;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 57.61 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2023;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 56.60 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2024;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2025;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.92 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2000;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 19.76 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2001;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.62 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2002;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.89 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2003;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.11 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2004;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.84 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2005;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.25 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2006;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.47 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2007;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.35 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2008;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 19.85 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2009;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 19.42 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2010;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 19.16 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2011;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.58 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2012;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.03 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2013;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.00 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2014;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.69 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2015;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.05 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2016;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.44 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2017;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 22.25 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2018;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 22.02 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2019;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.20 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2020;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.65 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2021;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.52 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2022;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.92 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2023;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.40 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2024;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2025;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.68 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2000;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 22.53 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2001;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.19 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2002;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.88 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2003;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.54 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2004;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.00 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2005;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 19.13 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2006;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 19.20 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2007;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 18.12 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2008;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 17.78 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2009;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 17.79 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2010;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 17.91 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2011;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 16.33 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2012;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 14.30 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2013;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 14.01 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2014;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 14.06 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2015;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 14.94 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2016;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 13.84 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2017;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 13.67 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2018;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 13.37 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2019;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 11.42 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2020;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 12.03 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2021;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 12.57 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2022;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 11.45 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2023;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 12.76 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2024;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2025;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 9.48 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2000;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 10.19 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2001;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 12.18 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2002;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 12.02 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2003;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 11.22 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2004;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 10.68 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2005;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 10.31 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2006;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 11.23 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2007;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 10.89 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2008;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 10.20 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2009;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 10.25 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2010;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 10.42 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2011;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 10.08 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2012;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 10.18 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2013;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 11.18 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2014;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 11.40 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2015;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 11.46 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2016;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 11.37 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2017;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 11.16 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2018;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 11.34 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2019;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 9.11 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2020;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 8.21 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2021;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 8.29 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2022;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 8.09 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2023;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 8.62 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2024;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2025;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.89 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2000;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.11 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2001;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.38 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2002;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.90 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2003;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 23.02 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2004;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 22.02 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2005;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 21.05 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2006;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 22.63 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2007;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.72 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2008;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.12 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2009;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.09 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2010;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 20.62 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2011;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 19.01 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2012;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 17.99 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2013;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 15.97 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2014;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 16.15 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2015;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 15.42 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2016;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 15.75 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2017;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 16.40 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2018;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 15.63 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2019;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 14.26 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2020;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 14.01 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2021;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 14.13 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2022;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 13.41 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2023;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 13.69 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2024;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2025;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.53 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2000;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.91 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2001;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.59 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2002;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.46 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2003;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.40 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2004;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.72 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2005;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.63 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2006;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.78 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2007;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.60 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2008;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.47 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2009;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.49 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2010;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.49 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2011;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.57 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2012;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.58 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2013;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.54 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2014;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.58 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2015;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.31 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2016;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.41 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2017;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.43 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2018;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.42 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2019;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.22 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2020;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.28 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2021;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.35 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2022;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.36 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2023;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.35 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2024;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2025;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.58 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2000;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.68 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2001;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.73 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2002;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.77 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2003;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.81 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2004;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.64 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2005;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.68 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2006;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.70 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2007;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.68 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2008;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.65 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2009;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.65 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2010;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.73 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2011;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.77 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2012;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.79 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2013;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.74 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2014;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.69 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2015;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.78 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2016;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.79 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2017;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.88 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2018;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.90 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2019;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.78 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2020;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.83 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2021;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.84 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2022;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.88 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2023;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.93 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2024;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2025;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 209.44 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2000;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 201.39 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2001;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 206.22 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2002;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 208.25 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2003;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 204.09 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2004;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 203.40 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2005;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 195.18 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2006;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 199.03 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2007;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 191.21 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2008;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 165.78 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2009;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 173.97 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2010;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 171.99 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2011;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 168.01 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2012;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 168.91 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2013;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 165.07 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2014;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 164.31 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2015;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 164.60 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2016;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 158.99 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2017;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 164.73 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2018;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 165.10 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2019;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 148.62 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2020;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 151.73 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2021;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 158.15 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2022;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 159.77 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2023;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 157.81 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2024;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2025;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.97 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2000;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.88 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2001;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.88 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2002;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.96 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2003;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.96 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2004;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.90 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2005;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.85 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2006;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.92 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2007;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.83 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2008;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.81 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2009;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.84 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2010;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 2.00 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2011;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.92 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2012;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.62 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2013;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.56 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2014;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.53 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2015;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.57 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2016;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.59 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2017;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.56 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2018;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.61 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2019;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.57 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2020;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.60 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2021;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.59 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2022;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.54 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2023;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 1.49 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2024;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2025;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 85.00 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2000;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 83.12 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2001;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 84.46 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2002;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 88.89 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2003;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 88.78 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2004;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 85.29 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2005;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 84.38 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2006;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 86.74 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2007;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 82.95 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2008;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 81.00 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2009;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 78.92 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2010;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 80.53 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2011;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 79.32 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2012;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 78.70 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2013;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 76.63 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2014;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 76.82 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2015;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 76.64 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2016;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 79.08 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2017;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 80.42 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2018;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 82.19 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2019;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 74.99 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2020;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 77.63 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2021;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 79.20 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2022;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 77.68 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2023;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 77.53 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2024;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2025;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 77.82 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2000;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 77.88 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2001;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 79.32 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2002;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 81.51 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2003;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 83.77 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2004;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 82.53 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2005;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 82.00 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2006;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 83.10 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2007;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 82.46 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2008;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 79.37 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2009;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 78.75 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2010;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 78.93 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2011;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 82.65 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2012;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 84.62 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2013;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 87.67 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2014;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 88.63 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2015;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 83.25 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2016;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 88.15 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2017;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 89.40 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2018;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 86.66 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2019;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 74.76 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2020;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 76.78 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2021;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 75.36 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2022;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 73.41 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2023;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 71.66 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2024;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2025;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.53 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2000;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.53 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2001;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.52 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2002;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.51 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2003;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.50 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2004;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.56 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2005;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.61 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2006;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.63 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2007;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.62 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2008;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.58 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2009;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.65 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2010;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.68 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2011;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.68 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2012;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.60 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2013;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.50 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2014;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.53 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2015;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.52 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2016;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.56 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2017;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.64 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2018;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.69 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2019;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.59 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2020;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.65 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2021;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.66 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2022;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.67 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2023;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, 0.72 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2024;
INSERT INTO Pollution (ProvinceID, AnneeID, EmissionGES_MtCO2e) SELECT p.ProvinceID, a.AnneeID, NULL FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2025;
GO

-- Vérification
SELECT COUNT(*) AS NombreLignes FROM Pollution;
