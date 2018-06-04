USE BD_Project_DB
GO

-- Нас. пункты и их коды
IF OBJECT_ID( 'dbo.locals', 'U' ) IS NOT NULL
	DROP TABLE dbo.locals
GO

CREATE TABLE dbo.locals
( NAME varchar(40), SOCRNAME varchar(30), 
  SS varchar(2) NOT NULL, RRR varchar(3) NOT NULL, GGG varchar(3) NOT NULL, PPP varchar(3) NOT NULL,
  FULLNAME varchar(80) NOT NULL, CUR_FULLNAME varchar(320), 
  CODE varchar(8) NOT NULL, [INDEX]  varchar(6) 
 )
GO

CREATE INDEX idxLocalsCode ON dbo.locals(CODE)
GO

INSERT INTO dbo.locals
SELECT
	pp.NAME, lower(pp.SOCRNAME),
	pp.SS, pp.RRR, pp.GGG, pp.PPP,
	pp.NAME + ' ' + lower(pp.SOCRNAME),
	pp.NAME + ' ' + lower(pp.SOCRNAME) + ' ' + r.FULLNAME,
	pp.SS + pp.RRR + pp.GGG,
	pp.[INDEX]
FROM 
	dbo.separatedCodes pp INNER JOIN dbo.regions r ON r.SS = pp.SS
WHERE
	pp.RRR = '000' AND pp.GGG = '000' AND pp.PPP != '000' AND pp.AA = '00'
GO

INSERT INTO dbo.locals
SELECT DISTINCT
	pp.NAME, lower(pp.SOCRNAME),
	pp.SS, pp.RRR, pp.GGG, pp.PPP,
	pp.NAME + ' ' + lower(pp.SOCRNAME),
	pp.NAME + ' ' + lower(pp.SOCRNAME) + ' ' + d.CUR_FULLNAME,
	pp.SS + pp.RRR + pp.GGG,
	pp.[INDEX]
FROM 
	dbo.separatedCodes pp INNER JOIN dbo.distincts d ON d.RRR = pp.RRR
WHERE
	pp.RRR != '000' AND pp.GGG = '000' AND pp.PPP != '000' AND pp.AA = '00' AND pp.SS = d.SS
GO

INSERT INTO dbo.locals
SELECT DISTINCT
	pp.NAME, lower(pp.SOCRNAME),
	pp.SS, pp.RRR, pp.GGG, pp.PPP,
	pp.NAME + ' ' + lower(pp.SOCRNAME),
	pp.NAME + ' ' + lower(pp.SOCRNAME) + ' ' + gg.CUR_FULLNAME,
	pp.SS + pp.RRR + pp.GGG,
	pp.[INDEX]
FROM 
	dbo.separatedCodes pp INNER JOIN dbo.cities gg ON gg.GGG = pp.GGG
WHERE
	pp.RRR = gg.RRR AND pp.GGG != '000' AND PPP != '000' AND AA = '00' AND pp.SS = gg.SS
GO