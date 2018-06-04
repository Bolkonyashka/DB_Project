USE [BD_Project_DB]
GO

-- Районы и их коды
IF OBJECT_ID( 'dbo.distincts', 'U' ) IS NOT NULL
	DROP TABLE dbo.distincts
GO

CREATE TABLE dbo.distincts
( NAME varchar(40), SOCRNAME varchar(30), 
  SS varchar(2) NOT NULL, RRR varchar(3) NOT NULL, 
  FULLNAME varchar(80) NOT NULL, CUR_FULLNAME varchar(160), 
  CODE varchar(2) NOT NULL, [INDEX]  varchar(6) 
 )
GO

ALTER TABLE dbo.distincts
ADD CONSTRAINT PK_DistinctRRR PRIMARY KEY (CODE, RRR, FULLNAME)
GO

CREATE INDEX idxDistinctCode ON dbo.distincts(CODE)
GO

INSERT INTO dbo.distincts
SELECT DISTINCT 
	sc.NAME, lower(sc.SOCRNAME),
	sc.SS, sc.RRR, 
	sc.NAME + ' ' + lower( sc.SOCRNAME ), sc.NAME + ' ' + lower( sc.SOCRNAME ) + ' ' + ss.FULLNAME,
	ss.SS, sc.[INDEX]
FROM 
	dbo.separatedCodes sc INNER JOIN dbo.regions ss ON ss.SS = sc.SS
WHERE
	RRR != '000' AND GGG = '000' AND PPP = '000' AND AA = '00'
GO