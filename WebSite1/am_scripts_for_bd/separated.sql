USE [master]
GO

-- Регионы и их коды
IF OBJECT_ID( 'dbo.regions', 'U' ) IS NOT NULL
	DROP TABLE dbo.regions
GO

/*
	Дополнительно:
		1) В приложении к описанию БД "KLADR" содержится не самая актуальная
		информация о том, каков полный список регионов РФ на 2016 год, в то
		время как в самой БД содержится актуальная информация
		2) Дополнительно к списку приложения среди регионов также должны быть
		выбраны Крым (Республика), Севастополь (Федерального значения Город) после
		присоединения Крыма к России, а также по дополнительному соглашению
		с республикой Казахстан Байконур (город), который приобретает статус
		Города Федерального Значения РФ на время его аренды
*/
CREATE VIEW dbo.regions ( NAME, SS, SOCRNAME, FULLNAME, CODE, [INDEX] )
WITH SCHEMABINDING
AS
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
