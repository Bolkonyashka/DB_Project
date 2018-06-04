USE master
GO

IF OBJECT_ID( 'dbo.getAddress', 'FN' ) IS NOT NULL
	DROP FUNCTION dbo.getAddress
GO

CREATE FUNCTION dbo.getAddress
( @locCode varchar(11), @yyyy varchar(4), @hhhh varchar(4), 
  @houseName varchar(10), @flatName varchar(10)
)
RETURNS varchar(1000)
AS
BEGIN
	DECLARE @index varchar(6), @curIndex varchar(6)
	DECLARE @address varchar(1000)

	DECLARE @name varchar(40), @socr varchar(30)
	DECLARE @ss varchar(2), @rrr varchar(3), @ggg varchar(3), @ppp varchar(3)

	-- Делим код
	SET @ss = SUBSTRING(@locCode, 1, 2)
	SET @rrr = SUBSTRING(@locCode, 3, 3)
	SET @ggg = SUBSTRING(@locCode, 6, 3)
	SET @ppp = SUBSTRING(@locCode, 9, 3)
	SET @index = ''
	SET @address = ''

	DECLARE @current TABLE
	( NAME varchar(40), SOCR varchar(30), [INDEX] varchar(6) )

	IF @yyyy != '0000'
		BEGIN
		INSERT INTO @current SELECT NAME, SOCR, [INDEX] FROM dbo.STREET where CODE = @locCode + @yyyy + '00'
		SET @curIndex = (SELECT MAX([INDEX]) FROM @current)
		SET @name = (SELECT MAX([NAME]) FROM @current)
		SET @socr = (SELECT MAX([SOCR]) FROM @current)

		IF @curIndex IS NOT NULL
			BEGIN
				SET @index = @curIndex
			END
		SET @address = @address + @socr + '. ' + @name

		DELETE FROM @current 
		END

	IF @hhhh != '0000'
		BEGIN
		SET @curIndex = (SELECT MAX([INDEX]) FROM dbo.DOMA where CODE = @locCode + @yyyy + @hhhh)

		IF @curIndex IS NOT NULL
			BEGIN
				SET @index = @curIndex
			END
		SET @address = @address + ', д.' + @houseName
		END

	IF @flatName != ''
		BEGIN
		SET @address = @address + ', кв.' + @flatName 
		END

	SET @address = @address + ',' + CHAR(13)

	-- Обрабатываем населенный пункт
	IF @ppp != '000'
		BEGIN
		INSERT INTO @current SELECT NAME, SOCR, [INDEX] FROM dbo.KLADR where CODE = @locCode + '00'
		SET @curIndex = (SELECT MAX([INDEX]) FROM @current)
		SET @name = (SELECT MAX([NAME]) FROM @current)
		SET @socr = (SELECT MAX([SOCR]) FROM @current)

		IF (@curIndex IS NOT NULL) AND (@index = '')
			BEGIN
				SET @index = @curIndex
			END
		SET @address = @address + @socr + '. ' + @name + ',' + CHAR(13)
		DELETE FROM @current 
		END

	IF @ggg != '000'
		BEGIN
		INSERT INTO @current SELECT NAME, SOCR, [INDEX] FROM dbo.KLADR where CODE = @ss + @rrr + @ggg + '00000'
		SET @curIndex = (SELECT MAX([INDEX]) FROM @current)
		SET @name = (SELECT MAX([NAME]) FROM @current)
		SET @socr = (SELECT MAX([SOCR]) FROM @current)

		IF (@curIndex IS NOT NULL) AND (@index = '')
			BEGIN
				SET @index = @curIndex
			END
		SET @address = @address + @socr + '. ' + @name + ',' + CHAR(13)
		DELETE FROM @current
		END

	IF @rrr != '000'
		BEGIN
		INSERT INTO @current SELECT NAME, SOCR, [INDEX] FROM dbo.KLADR where CODE = @ss + @rrr + '000' + '000' + '00'
		SET @curIndex = (SELECT MAX([INDEX]) FROM @current)
		SET @name = (SELECT MAX([NAME]) FROM @current)
		SET @socr = (SELECT MAX([SOCR]) FROM @current)

		IF (@curIndex IS NOT NULL) AND (@index = '')
			BEGIN
				SET @index = @curIndex
			END
		SET @address = @address + @name + ' ' + @socr + '.' + ',' + CHAR(13)
		DELETE FROM @current
		END

	INSERT INTO @current SELECT NAME, SOCRNAME, [INDEX] FROM dbo.regions where SS = @ss
	SET @curIndex = (SELECT MAX([INDEX]) FROM @current)
	SET @name = (SELECT MAX([NAME]) FROM @current)
	SET @socr = (SELECT MAX([SOCR]) FROM @current)

	IF (@curIndex IS NOT NULL) AND (@index = '')
		BEGIN
			SET @index = @curIndex
		END

	IF (@socr = 'республика') OR (@socr = 'город')
		BEGIN
		SET @address = @address + @socr + ' ' + @name + ' '
		RETURN @address + @index 
		END

	SET @address = @address + @name + ' ' + @socr + ',' + CHAR(13)
	RETURN @address + @index
END
GO

-- SELECT dbo.getAddress( '66000001000', '0176', '0001', '3', '47' )
-- GO
-- 
-- SELECT dbo.getAddress( '01000001000', '0001', '0005', '120', '' )
-- GO
-- 
-- SELECT dbo.getAddress( '22025000022', '0003', '0002', '17', '' )
-- GO
-- 
-- SELECT dbo.getAddress( '66019000072', '0002', '0001', '1', '' )
-- GO