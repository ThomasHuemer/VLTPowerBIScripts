USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_NvProdPoolWeek]    Script Date: 26.08.2020 00:43:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT
			1
		FROM sys.views
		WHERE NAME = 'VLT_DB_POWERBI_NvProdPoolWeek'
			AND type = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_NvProdPoolWeek;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_NvProdPoolWeek]
AS

	SELECT
		ppw.PRODPOOLID,
		ppw.PRODWEEKCAPACITY																													   
		AS PRODWEEKCAPACITY,
		CONVERT(DATE, dbo.VLT_DB_GETDATETIMEWITHTIMEZONE(ppw.WEEKSTARTINg)) AS WEEKSTARTING,
		DATEPART(ISO_WEEK, ppw.WEEKSTARTING)																										   AS Weeknumber,
		DATEPART(YEAR, ppw.WEEKSTARTING)																										   AS YearStart,
		DATEPART(MONTH, ppw.WEEKSTARTING)																										   AS MonthStart,
		CONVERT(VARCHAR(4), DATEPART(YEAR, ppw.WEEKSTARTING)) + (select right('00' + cast(DATEPART(ISO_WEEK, ppw.WEEKSTARTING) as varchar(2)), 2))  AS FKYearWeek,
		ppw.PRODPOOLID + CONVERT(VARCHAR(4), DATEPART(YEAR, ppw.WEEKSTARTING)) + (select right('00' + cast(DATEPART(ISO_WEEK, ppw.WEEKSTARTING) as varchar(2)), 2))  AS FKPoolYearWeek
	FROM dbo.NVPRODPOOLWEEK ppw
	WHERE ppw.DATAAREAID = '100'

GO


