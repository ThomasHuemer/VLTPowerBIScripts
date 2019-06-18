USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_CUSTINVOICEJOURPART_ADDON]    Script Date: 29.05.2018 15:51:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_CUSTINVOICEJOURPART_ADDON'
			AND TYPE = 'v'
	)
	DROP VIEW VLT_DB_POWERBI_CUSTINVOICEJOURPART_ADDON;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_CUSTINVOICEJOURPART_ADDON]
AS
	SELECT CustInvoiceJourPart.SALESID,
		   CustInvoiceJourPart.ORDERACCOUNT,
		   CustInvoiceJourPart.INVOICEACCOUNT,
		   CustInvoiceJourPart.INVOICEDATE,
		   CustInvoiceJourPart.INVOICEAMOUNTMST,
		   CustInvoiceJourPart.INVOICINGNAME,
		   CustInvoiceJourPart.INVOICINGADDRESS,
		   CustInvoiceJourPart.INVCOUNTRYREGIONID,
		   CustInvoiceJourPart.INVSTATE,
		   CustInvoiceJourPart.INVCOUNTY,
		   CustInvoiceJourPart.INVZIPCODE,
		   CustInvoiceJourPart.INVOICESTREET,
		   CustInvoiceJourPart.INVOICECITY,
		   CustInvoiceJourPart.DELIVERYNAME,
		   CustInvoiceJourPart.DELIVERYADDRESS,
		   CustInvoiceJourPart.DLVZIPCODE,
		   CustInvoiceJourPart.DLVCOUNTRYREGIONID,
		   CustInvoiceJourPart.DLVSTATE,
		   CustInvoiceJourPart.DELIVERYSTREET,
		   CustInvoiceJourPart.DELIVERYCITY,
		   CustInvoiceJourPart.SALESBALANCEMST,
		   CustInvoiceJourPart.ENDDISCMST,
		   (CustInvoiceJourPart.SALESBALANCEMST - CustInvoiceJourPart.ENDDISCMST) AS SalesBalanceExclEndDisc,
		   CustInvoiceJourPart.CURRENCYCODE,
		   CustInvoiceJourPart.DUEDATE,
		   CustInvoiceJourPart.INVOICEID,
		   CustInvoiceJourPart.NUMBERSEQUENCEGROUP,
		   CustInvoiceJourPart.SALESORIGINID,
		   CustInvoiceJourPart.DATAAREAID,
		   CONVERT(VARCHAR, CustInvoiceJourPart.INVOICEDATE, 112) AS InvoiceDateVarchar,
		   CustInvoiceJourPart.INVOICEID + CONVERT(VARCHAR, CustInvoiceJourPart.INVOICEDATE, 112) + CustInvoiceJourPart.NUMBERSEQUENCEGROUP + CONVERT(VARCHAR, CustInvoiceJourPart.RecId) + CustInvoiceJourPart.DATAAREAID AS UniqueInvoiceNumIdx,
		   CustInvoiceJourPart.SALESID + CustInvoiceJourPart.DATAAREAID AS FKSalesTable,
		   CustInvoiceJourPart.SALESID + CustInvoiceJourPart.INVOICEID + CONVERT(VARCHAR, CustInvoiceJourPart.INVOICEDATE, 112) + CustInvoiceJourPart.NUMBERSEQUENCEGROUP AS FKCustInvoiceTrans,
		   CustInvoiceJourPart.ORDERACCOUNT + CustInvoiceJourPart.DATAAREAID AS FKCustAccount,
		   CustInvoiceJourPart.INVOICEACCOUNT + CustInvoiceJourPart.DATAAREAID AS FKInvoiceAccount,
		   CustInvoiceJourPart.SALESID + CustInvoiceJourPart.INVOICEID + +CONVERT(VARCHAR, CustInvoiceJourPart.INVOICEDATE, 112) + CustInvoiceJourPart.DATAAREAID AS FKSalesIdInvoiceIdInvoiceDate
	FROM dbo.CUSTINVOICEJOURPART_ADDON AS CustInvoiceJourPart
	WHERE CUSTINVOICEJOURPART.DATAAREAID = '100'
		AND CUSTINVOICEJOURPART.SALESID <> ''
		AND CUSTINVOICEJOURPART.REFNUM = 0
GO

