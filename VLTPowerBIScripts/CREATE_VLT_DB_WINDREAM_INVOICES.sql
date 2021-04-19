USE [VLT_AX500105_P]
GO

IF EXISTS (
		SELECT
			1
		FROM sys.VIEWS
		WHERE NAME = 'VLT_DB_WINDREAM_INVOICES'
			AND type = 'V'
	)
	DROP VIEW [VLT_DB_WINDREAM_INVOICES];
GO

/****** Object:  View [dbo].[VLT_DB_PIM_ItemVirtualPath]    Script Date: 10.08.2018 08:56:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VLT_DB_WINDREAM_INVOICES]
AS
	SELECT
		cij.SALESID																																					AS 'Auftrag',
		cij.INVOICINGNAME																																			AS 'Name',
		cij.NVCOMPANYID																																				AS 'Firmenkennung',
		cij.EMAILSALESINVOICE_ADDON																																	AS 'E-Mail',
		cij.INVOICEDATE																																				AS 'Rechnungsdatum',
		cij.INVOICEID																																				AS 'AX Rechnungsnummer',
		[szText28]																																					AS 'Windream RechnungsNr.',
		[dwDocID],
		[decCreationTime],
		--CONVERT(VARCHAR(14), [decCreationTime]) AS 'ErstelldatumZeitString',		
		CONVERT(DATETIME, STUFF(STUFF(STUFF(STUFF(STUFF(CONVERT(VARCHAR(14), [decCreationTime]), 13, 0, ':'), 11, 0, ':'), 9, 0, ' '), 5, 0, '-'), 8, 0, '-'), 120) AS 'ErstelldatumZeit',
		[dwArchiveDate],
		[dwCreationDate],
		[dwCreation_Time],
		[szText27]																																					AS Debitor,
		[szText32]																																					AS Archivstatus,
		szWM_Store																																					AS Speicherort
	FROM CUSTINVOICEJOUR cij
	JOIN [VMVALMAR01\WINDREAM].[windream60].[dbo].[BaseAttributes] BA ON (BA.[szText28] = cij.INVOICEID)
	WHERE BA.[dwObjectTypeID] = 6
		AND BA.[szText30] = 'Rechnung'
		--AND BA.szWM_Store = 'WORK'
		--AND cij.EMAILSALESINVOICE_ADDON != ''
		--AND BA.[szText32] != 'Versendet'
--AND cij.salesid = '642808/1'
--AND [szText28] = '0572530'
GO


