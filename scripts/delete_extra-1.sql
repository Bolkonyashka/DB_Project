USE BD_Project_DB
GO

-- �������� ��������� ��������� ����
INSERT INTO dbo.regions
SELECT DISTINCT NAME, '21', SOCR, NAME + SOCR, CODE, [INDEX]
FROM dbo.KLADR
where NAME = '��������� ���������� -' and code = '2100000000000'
GO


DELETE FROM [dbo].regions where name = '��������� ���������� -'
GO

