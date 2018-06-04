USE [BD_Project_DB]
GO

-- Города и их коды
IF OBJECT_ID( 'dbo.cities', 'U' ) IS NOT NULL
	DROP TABLE dbo.cities
GO

CREATE TABLE dbo.cities
( NAME varchar(40), SOCRNAME varchar(30), 
  SS varchar(2) NOT NULL, RRR varchar(3) NOT NULL, GGG varchar(3) NOT NULL,
  FULLNAME varchar(80) NOT NULL, CUR_FULLNAME varchar(240), 
  CODE varchar(5) NOT NULL, [INDEX]  varchar(6) 
 )
GO

ALTER TABLE dbo.cities
ADD CONSTRAINT PK_CityGGG PRIMARY KEY (CODE, GGG, FULLNAME)
GO

CREATE INDEX idxCityCode ON dbo.cities(CODE)
GO

INSERT INTO dbo.cities
    SELECT DISTINCT 
	gg.NAME,lower(gg.SOCRNAME),
	gg.SS, gg.RRR, gg.GGG,
	gg.NAME + ' ' + lower(gg.SOCRNAME), gg.NAME + ' ' + lower(gg.SOCRNAME) + ' ' + r.FULLNAME,
	r.SS + '000', gg.[INDEX]
FROM 
	dbo.separatedCodes gg INNER JOIN dbo.regions r ON r.SS = gg.SS
WHERE
	RRR = '000' AND GGG != '000' AND PPP = '000' AND AA = '00'
GO

INSERT INTO dbo.cities 
	SELECT DISTINCT 
	gg.NAME,lower(gg.SOCRNAME),
	gg.SS, gg.RRR, gg.GGG,
	gg.NAME + ' ' + lower(gg.SOCRNAME), gg.NAME + ' ' + lower(gg.SOCRNAME) + ' ' + d.CUR_FULLNAME,
	d.CODE + d.RRR, gg.[INDEX]
FROM 
	dbo.separatedCodes gg INNER JOIN dbo.distincts d ON d.RRR = gg.RRR
WHERE
	gg.RRR != '000' AND gg.GGG != '000' AND gg.PPP = '000' AND gg.AA = '00' AND gg.SS = d.SS
GO

INSERT INTO dbo.cities 
SELECT DISTINCT 
	gg.NAME,lower(gg.SOCRNAME),
	gg.SS, gg.RRR, gg.GGG,
	gg.NAME + ' ' + lower(gg.SOCRNAME), gg.NAME + ' ' + lower(gg.SOCRNAME),
	gg.SS + gg.RRR, gg.[INDEX]
FROM 
	dbo.separatedCodes gg INNER JOIN dbo.regions r ON r.SS = gg.SS
WHERE
	gg.RRR = '000' AND gg.GGG = '000' AND gg.PPP = '000' AND gg.AA = '00' AND gg.SOCRNAME = 'Город'
GO