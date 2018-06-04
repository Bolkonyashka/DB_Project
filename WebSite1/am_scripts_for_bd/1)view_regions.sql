USE [master]
GO


IF OBJECT_ID( 'dbo.separatedCodes', 'V' ) IS NOT NULL
	DROP VIEW dbo.separatedCodes
GO

IF OBJECT_ID( 'dbo.uniqueSocr', 'U' ) IS NOT NULL
	DROP TABLE dbo.uniqueSocr
GO


-- ���������� ������������ ����������
CREATE TABLE dbo.uniqueSocr
( SOCRN varchar(10), SOCRNAME varchar(29) )
GO

INSERT INTO dbo.uniqueSocr SELECT DISTINCT [SCNAME], [SOCRNAME] FROM dbo.SOCRBASE
	WHERE [SOCRNAME] <> '���������';
GO

-- ������� � ��������� ����� ���������� ����������
UPDATE dbo.uniqueSocr SET [SOCRNAME] = '������� (���������)' WHERE [SOCRNAME] = '�������';
GO

-- ������� �������������, �������� ����������� ���� ���
-- ������������ �������������
-- ��������������� ����� ������ ���
CREATE VIEW dbo.separatedCodes ( NAME, SS, RRR, GGG, PPP, AA, SOCRNAME, CODE, [INDEX] )
WITH SCHEMABINDING
AS
SELECT
	NAME, 
	SUBSTRING(CODE, 1, 2) AS SS, 
	SUBSTRING(CODE, 3, 3) AS RRR,
	SUBSTRING(CODE, 6, 3) AS GGG,
	SUBSTRING(CODE, 9, 3) AS PPP,
	SUBSTRING(CODE, 12, 2) AS AA,
	SOCRNAME, 
	CODE, 
	[INDEX]
FROM 
	dbo.KLADR INNER JOIN dbo.uniqueSocr ON SOCRN = SOCR 
GO

CREATE UNIQUE CLUSTERED INDEX idx0 ON dbo.separatedCodes( NAME, CODE, SOCRNAME )
GO

