USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_CUSTINVOICESALESLINK]    Script Date: 29.05.2018 15:51:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_CUSTINVOICESALESLINK'
			AND TYPE = 'v'
	)
	DROP VIEW VLT_DB_POWERBI_CUSTINVOICESALESLINK;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_CUSTINVOICESALESLINK]
AS
	SELECT CustInvoiceSalesLink.INVOICEID,
		   CustInvoiceSalesLink.INVOICEDATE,
		   CustInvoiceSalesLink.SALESID,
		   CustInvoiceSalesLink.ORIGSALESID,
		   CustInvoiceSalesLink.INVOICEACCOUNT,
		   CustInvoiceSalesLink.ORDERACCOUNT,
		   CustInvoiceSalesLink.DELIVERYNAME,
		   CustInvoiceSalesLink.DELIVERYADDRESS,
		   CustInvoiceSalesLink.PARMID,
		   CustInvoiceSalesLink.INVOICINGADDRESS,
		   CustInvoiceSalesLink.INVOICINGNAME,
		   CustInvoiceSalesLink.PURCHASEORDER,
		   CustInvoiceSalesLink.CUSTOMERREF,
		   CustInvoiceSalesLink.DATAAREAID,
		   CustInvoiceSalesLink.ORIGSALESID + CONVERT(VARCHAR, CustInvoiceSalesLink.INVOICEDATE, 112) + CustInvoiceSalesLink.INVOICEID + CustInvoiceSalesLink.DATAAREAID AS FKOrigSalesIdIdx,
		   CustInvoiceSalesLink.ORIGSALESID + CustInvoiceSalesLink.DATAAREAID AS FKOrigSalesId,
		   CustInvoiceSalesLink.SALESID + CustInvoiceSalesLink.DATAAREAID AS FKSalesId,
		   CustInvoiceSalesLink.SALESID + CustInvoiceSalesLink.INVOICEID + +CONVERT(VARCHAR, CustInvoiceSalesLink.INVOICEDATE, 112) + CustInvoiceSalesLink.DATAAREAID AS FKSalesIdInvoiceIdInvoiceDate
	FROM dbo.CUSTINVOICESALESLINK AS CustInvoiceSalesLink
	WHERE CustInvoiceSalesLink.DATAAREAID = '100'
GO
