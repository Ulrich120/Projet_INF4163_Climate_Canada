USE PrecipitationDB;
GO

-- Précipitations annuelles (mm)
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

INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 456.53 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2000;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 375.75 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2001;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 437.28 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2002;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 470.82 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2003;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 515.95 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2004;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 554.21 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2005;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 454.43 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2006;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 446.50 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2007;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 371.76 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2008;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 347.47 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2009;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 380.97 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2010;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 439.58 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2011;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 446.78 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2012;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 447.80 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2013;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 401.00 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2014;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 345.51 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2015;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 436.08 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2016;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 387.08 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2017;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 362.85 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2018;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 415.74 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2019;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 426.28 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2020;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 306.17 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2021;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 365.68 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2022;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 323.84 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2023;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 396.88 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2024;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 361.94 FROM Province p, Annee a WHERE p.CodeProvince = 'AB' AND a.ValeurAnnee = 2025;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1037.07 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2000;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1171.98 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2001;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1047.26 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2002;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1207.45 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2003;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1139.89 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2004;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1253.59 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2005;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1245.06 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2006;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1324.76 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2007;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 967.60 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2008;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1030.68 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2009;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1203.05 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2010;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1245.20 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2011;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1219.15 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2012;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 971.44 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2013;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1139.47 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2014;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1084.84 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2015;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1195.01 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2016;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1060.77 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2017;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1118.63 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2018;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 936.93 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2019;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1268.90 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2020;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1194.42 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2021;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 974.74 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2022;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 943.96 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2023;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1164.18 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2024;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1076.13 FROM Province p, Annee a WHERE p.CodeProvince = 'BC' AND a.ValeurAnnee = 2025;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 613.63 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2000;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 462.67 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2001;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 472.39 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2002;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 437.29 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2003;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 600.13 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2004;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 600.80 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2005;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 429.34 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2006;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 498.42 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2007;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 491.79 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2008;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 479.99 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2009;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 644.72 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2010;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 443.42 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2011;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 524.09 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2012;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 485.68 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2013;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 532.04 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2014;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 490.15 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2015;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 559.02 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2016;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 383.83 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2017;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 391.18 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2018;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 453.82 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2019;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 408.84 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2020;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 374.00 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2021;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 560.16 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2022;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 332.66 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2023;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 501.18 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2024;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 383.08 FROM Province p, Annee a WHERE p.CodeProvince = 'MB' AND a.ValeurAnnee = 2025;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1103.00 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2000;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 839.07 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2001;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1154.46 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2002;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1163.40 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2003;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 940.77 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2004;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1306.57 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2005;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1138.02 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2006;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1058.59 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2007;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1277.05 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2008;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1195.53 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2009;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1141.78 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2010;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1180.79 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2011;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1017.23 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2012;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1133.59 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2013;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1383.15 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2014;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1150.64 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2015;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1037.68 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2016;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1041.62 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2017;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1247.42 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2018;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1222.30 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2019;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 874.52 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2020;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1006.66 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2021;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1249.29 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2022;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1268.22 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2023;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1020.66 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2024;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 916.41 FROM Province p, Annee a WHERE p.CodeProvince = 'NB' AND a.ValeurAnnee = 2025;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1278.00 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2000;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1036.68 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2001;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1191.88 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2002;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1140.55 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2003;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1254.55 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2004;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1128.94 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2005;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1109.01 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2006;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1074.83 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2007;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1094.11 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2008;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1119.82 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2009;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1119.65 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2010;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1107.15 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2011;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1054.61 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2012;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1175.21 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2013;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1098.31 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2014;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1005.57 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2015;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1161.64 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2016;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 990.23 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2017;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1148.44 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2018;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1025.36 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2019;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1006.38 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2020;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1073.43 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2021;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1158.68 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2022;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1086.56 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2023;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1061.97 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2024;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1043.69 FROM Province p, Annee a WHERE p.CodeProvince = 'NL' AND a.ValeurAnnee = 2025;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1323.89 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2000;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 992.41 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2001;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1406.04 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2002;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1286.89 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2003;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1122.68 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2004;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1349.72 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2005;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1154.64 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2006;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1093.66 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2007;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1347.49 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2008;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1285.89 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2009;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1252.18 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2010;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1369.74 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2011;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1127.67 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2012;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1172.00 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2013;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1272.37 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2014;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1229.90 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2015;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1115.68 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2016;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1121.97 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2017;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1366.82 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2018;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1344.93 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2019;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1027.62 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2020;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1256.77 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2021;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1361.60 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2022;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1497.19 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2023;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1138.68 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2024;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1028.30 FROM Province p, Annee a WHERE p.CodeProvince = 'NS' AND a.ValeurAnnee = 2025;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 271.01 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2000;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 302.97 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2001;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 274.55 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2002;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 275.92 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2003;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 220.27 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2004;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 311.05 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2005;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 218.60 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2006;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 240.83 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2007;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 245.47 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2008;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 270.91 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2009;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 268.51 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2010;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 284.89 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2011;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 290.20 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2012;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 240.04 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2013;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 251.86 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2014;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 301.21 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2015;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 277.94 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2016;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 255.91 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2017;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 243.69 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2018;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 292.59 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2019;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 301.99 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2020;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 254.12 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2021;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 223.97 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2022;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 192.74 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2023;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 185.83 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2024;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 181.19 FROM Province p, Annee a WHERE p.CodeProvince = 'NT' AND a.ValeurAnnee = 2025;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 237.41 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2000;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 251.65 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2001;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 237.92 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2002;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 246.93 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2003;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 234.91 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2004;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 289.92 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2005;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 186.43 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2006;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 164.09 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2007;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 231.19 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2008;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 228.21 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2009;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 229.60 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2010;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 232.84 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2011;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 239.82 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2012;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 204.21 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2013;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 209.15 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2014;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 191.58 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2015;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 192.92 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2016;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 184.89 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2017;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 178.34 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2018;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 214.95 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2019;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 139.49 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2020;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 203.55 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2021;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 172.20 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2022;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 204.03 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2023;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 221.00 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2024;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 178.11 FROM Province p, Annee a WHERE p.CodeProvince = 'NU' AND a.ValeurAnnee = 2025;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 947.77 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2000;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 861.34 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2001;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 813.84 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2002;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 922.02 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2003;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 906.83 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2004;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 831.08 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2005;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 936.49 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2006;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 774.83 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2007;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1016.49 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2008;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 885.85 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2009;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 806.77 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2010;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 900.77 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2011;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 751.65 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2012;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 924.17 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2013;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 838.03 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2014;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 737.87 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2015;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 758.01 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2016;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 911.06 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2017;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 783.97 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2018;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 832.28 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2019;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 737.15 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2020;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 730.66 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2021;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 737.99 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2022;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 743.79 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2023;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 791.38 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2024;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 690.06 FROM Province p, Annee a WHERE p.CodeProvince = 'ON' AND a.ValeurAnnee = 2025;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1166.30 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2000;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 850.08 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2001;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1263.23 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2002;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1059.87 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2003;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 954.41 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2004;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1105.58 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2005;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1024.18 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2006;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 983.70 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2007;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1257.66 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2008;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1294.35 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2009;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1242.51 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2010;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1173.12 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2011;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 882.84 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2012;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 971.48 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2013;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1156.32 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2014;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1152.11 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2015;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 970.90 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2016;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 922.21 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2017;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1019.22 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2018;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1146.33 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2019;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 739.17 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2020;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1145.31 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2021;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1113.16 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2022;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1084.01 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2023;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 868.01 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2024;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 831.47 FROM Province p, Annee a WHERE p.CodeProvince = 'PE' AND a.ValeurAnnee = 2025;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1038.77 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2000;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 864.41 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2001;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 914.65 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2002;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1075.94 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2003;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 937.31 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2004;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1079.05 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2005;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1128.45 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2006;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1032.27 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2007;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1121.31 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2008;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 982.22 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2009;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 994.29 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2010;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 1083.20 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2011;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 896.89 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2012;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 942.32 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2013;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 951.66 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2014;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 898.37 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2015;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 929.14 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2016;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 969.17 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2017;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 887.17 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2018;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 901.09 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2019;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 846.98 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2020;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 780.88 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2021;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 973.92 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2022;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 902.92 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2023;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 832.78 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2024;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 794.63 FROM Province p, Annee a WHERE p.CodeProvince = 'QC' AND a.ValeurAnnee = 2025;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 451.68 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2000;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 270.50 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2001;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 437.32 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2002;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 347.86 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2003;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 458.01 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2004;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 486.67 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2005;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 432.02 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2006;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 391.58 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2007;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 369.97 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2008;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 389.49 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2009;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 549.97 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2010;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 408.95 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2011;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 445.51 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2012;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 372.26 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2013;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 443.87 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2014;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 372.69 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2015;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 477.06 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2016;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 306.35 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2017;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 322.02 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2018;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 365.20 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2019;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 335.10 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2020;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 285.71 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2021;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 363.90 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2022;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 270.01 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2023;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 386.03 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2024;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 307.02 FROM Province p, Annee a WHERE p.CodeProvince = 'SK' AND a.ValeurAnnee = 2025;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 366.54 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2000;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 312.53 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2001;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 307.80 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2002;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 324.79 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2003;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 313.03 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2004;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 355.79 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2005;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 316.10 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2006;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 254.54 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2007;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 364.06 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2008;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 363.24 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2009;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 321.29 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2010;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 388.19 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2011;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 350.72 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2012;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 363.48 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2013;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 314.43 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2014;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 319.22 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2015;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 280.84 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2016;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 281.16 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2017;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 255.05 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2018;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 265.02 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2019;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 329.73 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2020;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 289.19 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2021;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 335.92 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2022;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 309.20 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2023;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 304.24 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2024;
INSERT INTO Precipitation (ProvinceID, AnneeID, PrecipitationAnnuelle) SELECT p.ProvinceID, a.AnneeID, 242.89 FROM Province p, Annee a WHERE p.CodeProvince = 'YT' AND a.ValeurAnnee = 2025;
GO

-- Vérification
SELECT COUNT(*) AS NombreLignes FROM Precipitation;
