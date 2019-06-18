USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_SalesTable]    Script Date: 29.05.2018 15:52:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_SALESQUOTATIONLINE'
			AND TYPE = 'V'
	)
	DROP VIEW [VLT_DB_POWERBI_SALESQUOTATIONLINE];
GO

CREATE VIEW [DBO].[VLT_DB_POWERBI_SALESQUOTATIONLINE]
AS
	SELECT SalesQuotationLine.QUOTATIONID,
		   SalesQuotationLine.ITEMID,
		   SalesQuotationLine.NAME,
		   SalesQuotationLine.SALESQTY,
		   CASE
			   WHEN SalesQuotationLine.CURRENCYCODE = 'ATS' THEN SalesQuotationLine.LINEAMOUNT * 13.7603
			   ELSE SalesQuotationLine.LINEAMOUNT * 1
		   END AS LINEAMOUNT,
		   --SalesQuotationLine.LINEAMOUNT,
		   SalesQuotationLine.NVOPTIONALITEM,
		   SalesQuotationLine.QUOTATIONSTATUS,
		   CASE
			   WHEN SalesQuotationLine.QUOTATIONSTATUS = 0 THEN 'Erstellt'
			   WHEN SalesQuotationLine.QUOTATIONSTATUS = 1 THEN 'Versendet'
			   WHEN SalesQuotationLine.QUOTATIONSTATUS = 2 THEN 'Umgewandelt'
			   WHEN SalesQuotationLine.QUOTATIONSTATUS = 3 THEN 'Verloren'
			   WHEN SalesQuotationLine.QUOTATIONSTATUS = 4 THEN 'Storniert'
		   END AS QuotationStatusDesc,
		   SalesQuotationLine.QUOTATIONID + SalesQuotationLine.DATAAREAID AS FKQuotationId
	FROM dbo.SalesQuotationLine AS SalesQuotationLine
	WHERE SalesQuotationLine.DATAAREAID = '100'
GO