USE BD_Project_DB
GO

-- –егионы и их коды
IF OBJECT_ID( 'dbo.users', 'U' ) IS NOT NULL
	DROP TABLE dbo.users
GO

CREATE TABLE dbo.users
(
	NAME varchar(50) NOT NULL,
	SECONDNAME varchar(50) NOT NULL,
	SIRNAME varchar(50) NOT NULL,
	LOCALITY varchar(50) NOT NULL,
	STREET varchar(4),
	HOUSE varchar(4),
	HOUSENAME varchar(10),
	FLATNAME varchar(10),
	[ADDRESS] varchar(1000) NOT NULL,
	[LOGIN] varchar(50) NOT NULL,
	[PASSWORD] varchar(50) NOT NULL
)
GO

INSERT INTO dbo.users (NAME, SECONDNAME, SIRNAME, LOCALITY, STREET, HOUSE, HOUSENAME, FLATNAME, [ADDRESS], [LOGIN], [PASSWORD] )
VALUES
(
	'Admin', '', '', '66000001000', '0176', '0001', '3', '47', 
	dbo.getAddress( '66000001000', '0176', '0001', '3', '47' ),
	'admin', 'admin'
)
GO