USE [VLT_AX500105_P]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT
			1
		FROM sys.views
		WHERE NAME = 'VLT_DB_POWERBI_PRODTABLE'
			AND type = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_PRODTABLE;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_PRODTABLE]
AS
	SELECT
		pt.PRODID											   AS 'Produktionsnummer',
		dbo.VLT_DB_GETDATETIMEWITHTIMEZONE(pt.CREATEDDATETIME) AS 'Erstelldatum',
		pt.CREATEDDATETIME										AS 'CreatedDateTime',
		pt.INVENTREFTYPE									   AS 'RefType',
		pt.INVENTREFID										   AS 'Referenznummer',
		pt.PRODSTATUS										   AS 'StatusNr',
		vdpps.ProdSTATUSDesc								   AS 'Status',
		pt.ITEMID											   AS 'Artikel',
		pt.QTYSCHED											   AS 'Menge',
		pt.DLVDATE											   AS 'Lieferdatum'
	FROM dbo.PRODTABLE AS pt
	JOIN VLT_DB_POWERBI_ProdStatus vdpps ON (pt.PRODSTATUS = vdpps.PRODSTATUS)
	WHERE pt.DATAAREAID = '100'
		AND pt.CREATEDDATETIME > DATETIMEFROMPARTS(YEAR(GETDATE()) - 3, 1, 1, 0, 0, 0, 0)
		AND pt.INVENTREFTYPE = 1

GO

