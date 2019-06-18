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
		WHERE NAME = 'VLT_DB_POWERBI_SALESQUOTATIONTABLE'
			AND TYPE = 'V'
	)
	DROP VIEW [VLT_DB_POWERBI_SALESQUOTATIONTABLE];
GO

CREATE VIEW [DBO].[VLT_DB_POWERBI_SALESQUOTATIONTABLE]
AS
	SELECT SalesQuotationTable.QUOTATIONID,
		   SalesQuotationTable.BUSRELACCOUNT,
		   SalesQuotationTable.CUSTACCOUNT,
		   SalesQuotationTable.QUOTATIONNAME,
		   SalesQuotationTable.DELIVERYNAME,
		   SalesQuotationTable.SALESGROUP,
		   SalesQuotationTable.DELIVERYADDRESS,
		   SalesQuotationTable.QUOTATIONSTATUS,
		   CASE
			   WHEN SalesQuotationTable.QUOTATIONSTATUS = 0 THEN 'Erstellt'
			   WHEN SalesQuotationTable.QUOTATIONSTATUS = 1 THEN 'Versendet'
			   WHEN SalesQuotationTable.QUOTATIONSTATUS = 2 THEN 'Umgewandelt'
			   WHEN SalesQuotationTable.QUOTATIONSTATUS = 3 THEN 'Verloren'
			   WHEN SalesQuotationTable.QUOTATIONSTATUS = 4 THEN 'Storniert'
		   END AS QuotationStatusDesc,
		   SalesQuotationTable.CREATEDDATETIME,
		   SalesQuotationTable.QUOTATIONID + SalesQuotationTable.DATAAREAID AS FKQuotationId,
		   SalesQuotationTable.SALESGROUP + SalesQuotationTable.DATAAREAID AS FKGroupId,
		   SalesQuotationTable.CUSTACCOUNT + SalesQuotationTable.DATAAREAID AS FKCustAccount,
		   SalesQuotationTable.BUSRELACCOUNT + SalesQuotationTable.DATAAREAID AS FKBUSRELACCOUNT

	FROM dbo.SalesQuotationTable AS SalesQuotationTable
	WHERE SalesQuotationTable.DATAAREAID = '100'
GO