USE [VLT_AX500105_P]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT
			1
		FROM sys.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_ProdStatus'
			AND type = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_ProdStatus;
GO


CREATE VIEW [dbo].[VLT_DB_POWERBI_ProdStatus]
AS

	SELECT
		0	   AS ProdSTATUS,
		'Erstellt' AS ProdSTATUSDesc
	UNION
	SELECT
		1	   AS ProdSTATUS,
		'Vorkalkuliert' AS ProdSTATUSDesc
	UNION
	SELECT
		2	   AS ProdSTATUS,
		'Eingeplant' AS ProdSTATUSDesc
	UNION
	SELECT
		3	   AS ProdSTATUS,
		'Freigegeben' AS ProdSTATUSDesc
	UNION
	SELECT
		4	   AS ProdSTATUS,
		'Gestartet' AS ProdSTATUSDesc
	UNION
	SELECT
		5	   AS ProdSTATUS,
		'Als fertig gemeldet' AS ProdSTATUSDesc
	UNION
	SELECT
		6	   AS ProdSTATUS,
		'Abgeschlossen' AS ProdSTATUSDesc
GO


