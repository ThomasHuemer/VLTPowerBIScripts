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
		WHERE NAME = 'VLT_DB_POWERBI_ProdRegStatus'
			AND type = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_ProdRegStatus;
GO


CREATE VIEW [dbo].[VLT_DB_POWERBI_ProdRegStatus]
AS
	SELECT
		0		  AS ProdRegStatus,
		'Nicht Angemeldet' AS ProdRegStatusDesc
	UNION
	SELECT
		1		  AS ProdRegStatus,
		'Angemeldet' AS ProdRegStatusDesc
	UNION
	SELECT
		2			   AS ProdRegStatus,
		'Fertiggemeldet' AS ProdRegStatusDesc
	UNION
	SELECT
		3		  AS ProdRegStatus,
		'Für Produktion freigegeben' AS ProdRegStatusDesc
	UNION
	SELECT
		4		  AS ProdRegStatus,
		'Für Produktion gesperrt' AS ProdRegStatusDesc
GO


