USE [VLT_AX500105_P]
GO

IF EXISTS (
		SELECT
			1
		FROM sys.VIEWS
		WHERE NAME = 'VLT_DB_WINDREAM_INVOICES_NOT_IN_WD'
			AND type = 'V'
	)
	DROP VIEW [VLT_DB_WINDREAM_INVOICES_NOT_IN_WD];
GO

/****** Object:  View [dbo].[VLT_DB_PIM_ItemVirtualPath]    Script Date: 10.08.2018 08:56:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VLT_DB_WINDREAM_INVOICES_NOT_IN_WD]
AS
	SELECT
		cij.SALESID																																					AS 'Auftrag',
		cij.INVOICINGNAME																																			AS 'Name',
		cij.NVCOMPANYID																																				AS 'Firmenkennung',
		cij.EMAILSALESINVOICE_ADDON																																	AS 'E-Mail',
		cij.INVOICEDATE																																				AS 'Rechnungsdatum',
		cij.INVOICEID																																				AS 'AX Rechnungsnummer'		
	FROM CUSTINVOICEJOUR cij	
	WHERE NOT EXISTS (SELECT [szText28] FROM [VMVALMAR01\WINDREAM].[windream60].[dbo].[BaseAttributes] BA WHERE ba.[szText28] = cij.INVOICEID)
	AND cij.invoiceDate >= DATEADD(YEAR,-1,GETDATE())
GO


