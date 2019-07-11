USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_CUSTINVOICEJOUR]    Script Date: 29.05.2018 15:51:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_CUSTINVOICEJOUR'
			AND TYPE = 'v'
	)
	DROP VIEW VLT_DB_POWERBI_CUSTINVOICEJOUR;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_CUSTINVOICEJOUR]
AS
	SELECT CustInvoiceJour.SALESID,
		   CustInvoiceJour.ORDERACCOUNT,
		   CustInvoiceJour.INVOICEACCOUNT,
		   CustInvoiceJour.INVOICEDATE,
		   CustInvoiceJour.INVOICEAMOUNTMST,
		   CustInvoiceJour.INVOICINGNAME,
		   CustInvoiceJour.INVOICINGADDRESS,
		   CustInvoiceJour.INVCOUNTRYREGIONID,
		   CustInvoiceJour.INVSTATE,
		   CustInvoiceJour.INVCOUNTY,
		   CustInvoiceJour.INVZIPCODE,
		   CustInvoiceJour.INVOICESTREET,
		   CustInvoiceJour.INVOICECITY,
		   CustInvoiceJour.DELIVERYNAME,
		   CustInvoiceJour.DELIVERYADDRESS,
		   CustInvoiceJour.DLVZIPCODE,
		   CustInvoiceJour.DLVCOUNTRYREGIONID,
		   CustInvoiceJour.DLVSTATE,
		   CustInvoiceJour.DELIVERYSTREET,
		   CustInvoiceJour.DELIVERYCITY,
		   CustInvoiceJour.SALESBALANCEMST,
		   CustInvoiceJour.ENDDISCMST,
		   (CustInvoiceJour.SALESBALANCEMST - CustInvoiceJour.ENDDISCMST) AS SalesBalanceExclEndDisc,
		   CustInvoiceJour.CURRENCYCODE,
		   CustInvoiceJour.DUEDATE,
		   CustInvoiceJour.INVOICEID,
		   CustInvoiceJour.NUMBERSEQUENCEGROUP,
		   CustInvoiceJour.SALESORIGINID,
		   CustInvoiceJour.DATAAREAID,
		   CONVERT(VARCHAR, CUSTINVOICEJOUR.INVOICEDATE, 112) AS InvoiceDateVarchar,
		   CustInvoiceJour.INVOICEID + CONVERT(VARCHAR, CUSTINVOICEJOUR.INVOICEDATE, 112) + CustInvoiceJour.NUMBERSEQUENCEGROUP + CONVERT(VARCHAR, CustInvoiceJour.RecId) + CustInvoiceJour.DATAAREAID AS UniqueInvoiceNumIdx,
		   CustInvoiceJour.SALESID + CustInvoiceJour.DATAAREAID AS FKSalesTable,
		   CustInvoiceJour.SALESID + CustInvoiceJour.INVOICEID + CONVERT(VARCHAR, CUSTINVOICEJOUR.INVOICEDATE, 112) + CustInvoiceJour.NUMBERSEQUENCEGROUP AS FKCustInvoiceTrans,
		   CustInvoiceJour.ORDERACCOUNT + CustInvoiceJour.DATAAREAID AS FKCustAccount,
		   CustInvoiceJour.INVOICEACCOUNT + CustInvoiceJour.DATAAREAID AS FKInvoiceAccount,
		   CustInvoiceJour.SALESID + CustInvoiceJour.INVOICEID + +CONVERT(VARCHAR, CustInvoiceJour.INVOICEDATE, 112) + CustInvoiceJour.DATAAREAID AS FKSalesIdInvoiceIdInvoiceDate
	FROM dbo.CUSTINVOICEJOUR AS CustInvoiceJour
	WHERE CustInvoiceJour.DATAAREAID = '100'
		AND CustInvoiceJour.SALESID <> ''
		AND CustInvoiceJour.REFNUM = 0
		AND CUSTINVOICEJOUR.INVOICEDATE >  DATETIMEFROMPARTS(YEAR(GETDATE())-5, 3, 1, 0, 0, 0, 0)
GO

