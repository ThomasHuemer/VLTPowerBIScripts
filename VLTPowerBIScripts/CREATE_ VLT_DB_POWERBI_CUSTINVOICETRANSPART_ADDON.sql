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
		WHERE NAME = 'VLT_DB_POWERBI_CUSTINVOICETRANSPART_ADDON'
			AND type = 'v'
	)
	DROP VIEW VLT_DB_POWERBI_CUSTINVOICETRANSPART_ADDON;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_CUSTINVOICETRANSPART_ADDON]
AS
	SELECT CustInvoiceTransPart.SALESID,
		   CustInvoiceTransPart.INVOICEID,
		   CustInvoiceTransPart.INVOICEDATE,
		   CustInvoiceTransPart.NUMBERSEQUENCEGROUP,
		   CustInvoiceTransPart.ITEMID,
		   --		CASE 
		   --			WHEN CustInvoiceTransPart.CURRENCYCODE = 'ATS' THEN CustInvoiceTransPart.LINEAMOUNTMST * 13.7603
		   --		ELSE
		   --			CustInvoiceTransPart.LINEAMOUNTMST * 1				
		   --		END AS LineAmount,
		   CustInvoiceTransPart.LINEAMOUNTMST AS LineAmount,
		   CustInvoiceTransPart.LINEAMOUNTMST,
		   CustInvoiceTransPart.QTY,
		   InventTable.ITEMNAME,
		   InventTable.ITEMGROUPID,
		   CustInvoiceTransPart.SALESID + CustInvoiceTransPart.INVOICEID + CONVERT(VARCHAR, CustInvoiceTransPart.INVOICEDATE, 112) + CustInvoiceTransPart.NUMBERSEQUENCEGROUP AS FKCustInvoiceJour,
		   CASE
			   WHEN CustInvoiceTransPart.ORIGSALESID IS NULL AND CustInvoiceTransPart.SALESID IS NULL THEN ''
			   WHEN CustInvoiceTransPart.ORIGSALESID = '' AND CustInvoiceTransPart.SALESID = '' THEN ''
			   WHEN CustInvoiceTransPart.ORIGSALESID IS NULL AND CustInvoiceTransPart.SALESID IS NOT NULL OR CustInvoiceTransPart.SALESID != '' THEN CustInvoiceTransPart.SALESID + CustInvoiceTransPart.DATAAREAID
			   WHEN CustInvoiceTransPart.ORIGSALESID IS NULL THEN CustInvoiceTransPart.SALESID + CustInvoiceTransPart.DATAAREAID
			   ELSE CustInvoiceTransPart.ORIGSALESID + CustInvoiceTransPart.DATAAREAID
		   END AS FKOrigSalesId,
		   CASE
			   WHEN CustInvoiceTransPart.ORIGSALESID IS NULL AND CustInvoiceTransPart.SALESID IS NULL THEN ''
			   WHEN CustInvoiceTransPart.ORIGSALESID = '' AND CustInvoiceTransPart.SALESID = '' THEN ''
			   WHEN CustInvoiceTransPart.ORIGSALESID IS NULL AND CustInvoiceTransPart.SALESID IS NOT NULL OR CustInvoiceTransPart.SALESID != '' THEN CustInvoiceTransPart.SALESID + CustInvoiceTransPart.DATAAREAID
			   WHEN CustInvoiceTransPart.ORIGSALESID IS NULL THEN CustInvoiceTransPart.SALESID + CustInvoiceTransPart.DATAAREAID
			   ELSE CustInvoiceTransPart.ORIGSALESID
		   END AS OriginalSalesId,
		   CustInvoiceTransPart.ORIGSALESID,
		   CustInvoiceTransPart.SALESID + CustInvoiceTransPart.INVOICEID + +CONVERT(VARCHAR, CustInvoiceTransPart.INVOICEDATE, 112) + CustInvoiceTransPart.DATAAREAID AS FKSalesIdInvoiceIdInvoiceDate,
		   CustInvoiceTransPart.ITEMID + CustInvoiceTransPart.DATAAREAID AS FKItemId
	FROM dbo.CUSTINVOICETRANSPART_ADDON AS CustInvoiceTransPart
	LEFT JOIN dbo.InventTable AS InventTable ON (CustInvoiceTransPart.DATAAREAID = InventTable.DATAAREAID AND CustInvoiceTransPart.ITEMID = InventTable.ITEMID)
	WHERE CustInvoiceTransPart.DATAAREAID = '100'
		AND CustInvoiceTransPart.SALESID != ''

GO

