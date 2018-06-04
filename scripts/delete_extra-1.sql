USE BD_Project_DB
GO

-- Отдельно обработка Чувашской респ
INSERT INTO dbo.regions
SELECT DISTINCT NAME, '21', SOCR, NAME + SOCR, CODE, [INDEX]
FROM dbo.KLADR
where NAME = 'Чувашская Республика -' and code = '2100000000000'
GO


DELETE FROM [dbo].regions where name = 'Чувашская Республика -'
GO

