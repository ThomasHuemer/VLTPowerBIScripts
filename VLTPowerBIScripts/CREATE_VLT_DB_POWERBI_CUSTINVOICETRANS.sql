USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_PowerBI_CustInvoiceTrans]    Script Date: 29.05.2018 15:51:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT 1
		FROM sys.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_CUSTINVOICETRANS'
			AND type = 'v'
	)
	DROP VIEW VLT_DB_POWERBI_CUSTINVOICETRANS;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_CUSTINVOICETRANS]
AS
	SELECT CustInvoiceTrans.SALESID,
		   CustInvoiceTrans.INVOICEID,
		   CustInvoiceTrans.INVOICEDATE,
		   CustInvoiceTrans.NUMBERSEQUENCEGROUP,
		   CustInvoiceTrans.ITEMID,
		   --		CASE 
		   --			WHEN CustInvoiceTrans.CURRENCYCODE = 'ATS' THEN CustInvoiceTrans.LINEAMOUNTMST * 13.7603
		   --		ELSE
		   --			CustInvoiceTrans.LINEAMOUNTMST * 1				
		   --		END AS LineAmount,
		   CustInvoiceTrans.LINEAMOUNTMST AS LineAmount,
		   CustInvoiceTrans.LINEAMOUNTMST,
		   CustInvoiceTrans.QTY,
		   InventTable.ITEMNAME,
		   InventTable.ITEMGROUPID,
		   CHOOSE(MONTH(CustInvoiceTrans.INVOICEDATE), 'Wintersaison', 'Wintersaison', 'Sommersaison', 'Sommersaison', 'Sommersaison', 'Sommersaison', 'Sommersaison',
		   'Sommersaison', 'Wintersaison', 'Wintersaison', 'Wintersaison', 'Wintersaison') AS Saison,
		   CustInvoiceTrans.SALESID + CustInvoiceTrans.INVOICEID + CONVERT(VARCHAR, CustInvoiceTrans.INVOICEDATE, 112) + CustInvoiceTrans.NUMBERSEQUENCEGROUP AS FKCustInvoiceJour,
		   CASE
			   WHEN CustInvoiceTrans.ORIGSALESID IS NULL AND CustInvoiceTrans.SALESID IS NULL THEN ''
			   WHEN CustInvoiceTrans.ORIGSALESID = '' AND CustInvoiceTrans.SALESID = '' THEN ''
			   WHEN CustInvoiceTrans.ORIGSALESID IS NULL AND CustInvoiceTrans.SALESID IS NOT NULL OR CustInvoiceTrans.SALESID != '' THEN CustInvoiceTrans.SALESID + CustInvoiceTrans.DATAAREAID
			   WHEN CustInvoiceTrans.ORIGSALESID IS NULL THEN CustInvoiceTrans.SALESID + CustInvoiceTrans.DATAAREAID
			   ELSE CustInvoiceTrans.ORIGSALESID + CustInvoiceTrans.DATAAREAID
		   END AS FKOrigSalesId,
		   CASE
			   WHEN CustInvoiceTrans.ORIGSALESID IS NULL AND CustInvoiceTrans.SALESID IS NULL THEN ''
			   WHEN CustInvoiceTrans.ORIGSALESID = '' AND CustInvoiceTrans.SALESID = '' THEN ''
			   WHEN CustInvoiceTrans.ORIGSALESID IS NULL AND CustInvoiceTrans.SALESID IS NOT NULL OR CustInvoiceTrans.SALESID != '' THEN CustInvoiceTrans.SALESID + CustInvoiceTrans.DATAAREAID
			   WHEN CustInvoiceTrans.ORIGSALESID IS NULL THEN CustInvoiceTrans.SALESID + CustInvoiceTrans.DATAAREAID
			   ELSE CustInvoiceTrans.ORIGSALESID
		   END AS OriginalSalesId,
		   CustInvoiceTrans.ORIGSALESID,
		   CustInvoiceTrans.SALESID + CustInvoiceTrans.INVOICEID + +CONVERT(VARCHAR, CustInvoiceTrans.INVOICEDATE, 112) + CustInvoiceTrans.DATAAREAID AS FKSalesIdInvoiceIdInvoiceDate,
		   CustInvoiceTrans.ITEMID + CustInvoiceTrans.DATAAREAID AS FKItemId
	FROM dbo.CustInvoiceTrans AS CustInvoiceTrans
	LEFT JOIN dbo.InventTable AS InventTable ON (CustInvoiceTrans.DATAAREAID = InventTable.DATAAREAID AND CustInvoiceTrans.ITEMID = InventTable.ITEMID)
	WHERE CustInvoiceTrans.DATAAREAID = '100'
		AND CustInvoiceTrans.SALESID != ''
		AND CUSTINVOICETRANS.INVOICEDATE >  DATETIMEFROMPARTS(YEAR(GETDATE())-5, 3, 1, 0, 0, 0, 0)

GO

