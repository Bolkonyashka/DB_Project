USE BD_Project_DB
GO

-- –егионы и их коды
IF OBJECT_ID( 'dbo.streets', 'U' ) IS NOT NULL
	DROP TABLE dbo.streets
GO

CREATE TABLE dbo.streets
( NAME varchar(40), SOCRNAME varchar(30), 
  SS varchar(2) NOT NULL, RRR varchar(3) NOT NULL, GGG varchar(3) NOT NULL, PPP varchar(3) NOT NULL, YYYY varchar(4) NOT NULL,
  FULLNAME varchar(80) NOT NULL,
  CODE varchar(11) NOT NULL, [INDEX]  varchar(6) 
 )
GO

CREATE INDEX idxStreetsCode ON dbo.streets(CODE)
GO

INSERT INTO dbo.streets
SELECT l.NAME, lower(l.SOCRNAME), 
	   l.SS, l.RRR, l.GGG, l.PPP, l.YYYY,
	   l.NAME + ' ' + lower(l.SOCRNAME),
	   l.SS + l.RRR + l.GGG + l.PPP, s.[INDEX]
FROM dbo.separatedStreetCodes l INNER JOIN dbo.STREET s ON l.SS + l.RRR + l.GGG + l.PPP + l.YYYY + '00' = s.CODE
GO
