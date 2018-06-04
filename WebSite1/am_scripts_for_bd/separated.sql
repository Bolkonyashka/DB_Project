USE [master]
GO

-- ������� � �� ����
IF OBJECT_ID( 'dbo.regions', 'U' ) IS NOT NULL
	DROP TABLE dbo.regions
GO

/*
	�������������:
		1) � ���������� � �������� �� "KLADR" ���������� �� ����� ����������
		���������� � ���, ����� ������ ������ �������� �� �� 2016 ���, � ��
		����� ��� � ����� �� ���������� ���������� ����������
		2) ������������� � ������ ���������� ����� �������� ����� ������ ����
		������� ���� (����������), ����������� (������������ �������� �����) �����
		������������� ����� � ������, � ����� �� ��������������� ����������
		� ����������� ��������� �������� (�����), ������� ����������� ������
		������ ������������ �������� �� �� ����� ��� ������
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
