USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_PowerBI_EmplTable]    Script Date: 29.05.2018 15:51:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT
			1
		FROM sys.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_CompanyID'
			AND type = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_CompanyID;
GO


CREATE VIEW [dbo].[VLT_DB_POWERBI_CompanyID]
AS

	SELECT
		'Valetta'	   AS Company		
	UNION
	SELECT
		'Klotzner'	   AS Company
	UNION
	SELECT
		'München'	   AS Company
	
GO


