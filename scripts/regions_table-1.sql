USE [BD_Project_DB]
GO

-- –егионы и их коды
IF OBJECT_ID( 'dbo.regions', 'U' ) IS NOT NULL
	DROP TABLE dbo.regions
GO

CREATE TABLE dbo.regions 
( NAME varchar(40), SS varchar(2) NOT NULL, SOCRNAME varchar(30), FULLNAME varchar(80), CODE varchar(13), [INDEX]  varchar(6) )
GO

ALTER TABLE dbo.regions
ADD CONSTRAINT PK_RegionSS PRIMARY KEY (SS)
GO

INSERT INTO dbo.regions
SELECT
	NAME, 
	SS, 
	LOWER(SOCRNAME), 
	NAME + ' ' + LOWER(SOCRNAME),
	CODE,
	[INDEX]
FROM 
	dbo.separatedCodes s1
WHERE
	RRR = '000' AND GGG = '000' AND PPP = '000' AND AA = '00'
GO