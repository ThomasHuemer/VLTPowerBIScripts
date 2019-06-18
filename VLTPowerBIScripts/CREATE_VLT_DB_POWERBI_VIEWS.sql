USE [VLT_AX500105_T]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_SalesTable]    Script Date: 29.05.2018 15:52:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT 1
		FROM sys.views
		WHERE NAME = 'VLT_DB_POWERBI_BUSRELPRIVACYAGREEMENT'
			AND type = 'v'
	)
	DROP VIEW VLT_DB_POWERBI_BUSRELPRIVACYAGREEMENT;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_BUSRELPRIVACYAGREEMENT]
AS
	SELECT PrivacyAgreement.SMMBUSRELACCOUNT,
		   BusRelTable.Name,
		   PrivacyAgreement.AGREEMENTSENDDATE,
		   CASE
			   WHEN YEAR(PrivacyAgreement.AGREEMENTSENDDATE) = 1900 THEN 0
			   WHEN YEAR(PrivacyAgreement.AGREEMENTSENDDATE) > 1900 THEN 1
		   END AS AgreementSendINT,
		   CASE
			   WHEN YEAR(PrivacyAgreement.AGREEMENTSENDDATE) = 1900 THEN 'Nein'
			   WHEN YEAR(PrivacyAgreement.AGREEMENTSENDDATE) > 1900 THEN 'Ja'
		   END AS AgreementSend,
		   PrivacyAgreement.CONTACTPERSONID,
		   CASE
			   WHEN PrivacyAgreement.CONTACTPERSONID <> '' THEN (
					   SELECT CONTACTPERSON.NAME
					   FROM CONTACTPERSON
					   WHERE ContactPerson.CONTACTPERSONID = PrivacyAgreement.ContactPersonid
						   AND ContactPerson.DATAAREAID = PrivacyAgreement.DATAAREAID
				   )
		   END AS CustpersonName,
		   PrivacyAgreement.PRIVACYAGREEMENTRETURNEDDATE,
		   PrivacyAgreement.PRIVACYPROTECTIONAGREEMEN30003 AS AgreementReturnedINT,
		   CASE
			   WHEN PrivacyAgreement.PRIVACYPROTECTIONAGREEMEN30003 = 0 THEN 'Nein'
			   WHEN PrivacyAgreement.PRIVACYPROTECTIONAGREEMEN30003 = 1 THEN 'Ja'
		   END AS AgreementReturned,
		   PrivacyAgreement.CREATEORDERS AS CreateOrdersINT,
		   CASE
			   WHEN PrivacyAgreement.CREATEORDERS = 0 THEN 'Nein'
			   WHEN PrivacyAgreement.CREATEORDERS = 1 THEN 'Ja'
		   END AS CreateOrders,
		   PrivacyAgreement.NEWSLETTER AS NEWSLETTERINT,
		   CASE
			   WHEN PrivacyAgreement.NEWSLETTER = 0 THEN 'Nein'
			   WHEN PrivacyAgreement.NEWSLETTER = 1 THEN 'Ja'
		   END AS NEWSLETTER,
		   PrivacyAgreement.ADVERTISINGPOST AS ADVERTISINGPOSTINT,
		   CASE
			   WHEN PrivacyAgreement.ADVERTISINGPOST = 0 THEN 'Nein'
			   WHEN PrivacyAgreement.ADVERTISINGPOST = 1 THEN 'Ja'
		   END AS ADVERTISINGPOST,
		   PrivacyAgreement.INVITINGPOST AS INVITINGPOSTINT,
		   CASE
			   WHEN PrivacyAgreement.INVITINGPOST = 0 THEN 'Nein'
			   WHEN PrivacyAgreement.INVITINGPOST = 1 THEN 'Ja'
		   END AS INVITINGPOST

	FROM dbo.VLT_SMMBUSRELPRIVACYPROTE30529 AS PrivacyAgreement
	JOIN dbo.SMMBUSRELTABLE AS BusRelTable ON (PrivacyAgreement.DATAAREAID = BusRelTable.DATAAREAID AND PrivacyAgreement.SMMBUSRELACCOUNT = BusRelTable.BUSRELACCOUNT)
	WHERE PrivacyAgreement.DATAAREAID = '100'
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_COMMISSIONSALESGROUP'
			AND TYPE = 'v'
	)
	DROP VIEW VLT_DB_POWERBI_COMMISSIONSALESGROUP;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_COMMISSIONSALESGROUP]
AS
	SELECT Salesgroup.GROUPID,
		   Salesgroup.Name,
		   Salesgroup.GROUPID + SalesGroup.DATAAREAID AS FKGroupId
	FROM dbo.COMMISSIONSALESGROUP AS Salesgroup
	WHERE Salesgroup.DATAAREAID = '100'
GO

IF EXISTS (
		SELECT 1
		FROM sys.views
		WHERE NAME = 'VLT_DB_POWERBI_COMMISSIONSALESREP'
			AND type = 'v'
	)
	DROP VIEW VLT_DB_POWERBI_COMMISSIONSALESREP;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_COMMISSIONSALESREP]
AS
	SELECT CommSalesRep.GROUPID,
		   CommSalesRep.EMPLID,
		   CommSalesRep.EMPLID + CommSalesRep.DATAAREAID AS FKEmplID,
		   CommSalesRep.GROUPID + CommSalesRep.DATAAREAID AS FKGroupId
	FROM dbo.COMMISSIONSALESREP AS CommSalesRep
	WHERE CommSalesRep.DATAAREAID = '100'
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
		   CustInvoiceJour.DATAAREAID,
		   CONVERT(VARCHAR, CUSTINVOICEJOUR.INVOICEDATE, 112) AS InvoiceDateVarchar,
		   CustInvoiceJour.INVOICEID + CONVERT(VARCHAR, CUSTINVOICEJOUR.INVOICEDATE, 112) + CustInvoiceJour.NUMBERSEQUENCEGROUP + CONVERT(VARCHAR, CustInvoiceJour.RecId) + CustInvoiceJour.DATAAREAID AS UniqueInvoiceNumIdx,
		   CustInvoiceJour.SALESID + CustInvoiceJour.DATAAREAID AS FKSalesTable,
		   CustInvoiceJour.SALESID + CustInvoiceJour.INVOICEID + CONVERT(VARCHAR, CUSTINVOICEJOUR.INVOICEDATE, 112) + CustInvoiceJour.NUMBERSEQUENCEGROUP AS FKCustInvoiceTrans,
		   CustInvoiceJour.ORDERACCOUNT + CustInvoiceJour.DATAAREAID AS FKCustAccount,
		   CustInvoiceJour.INVOICEACCOUNT + CustInvoiceJour.DATAAREAID AS FKInvoiceAccount
	FROM dbo.CUSTINVOICEJOUR AS CustInvoiceJour
	WHERE CustInvoiceJour.DATAAREAID = '100'
		AND CustInvoiceJour.SALESID <> ''
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_CUSTINVOICETRANS'
			AND TYPE = 'v'
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
		   CustInvoiceTrans.LINEAMOUNTMST,
		   CUSTINVOICETRANS.QTY,
		   InventTable.ITEMNAME,
		   InventTable.ITEMGROUPID,
		   CustInvoiceTrans.SALESID + CustInvoiceTrans.INVOICEID + CONVERT(VARCHAR, CustInvoiceTrans.INVOICEDATE, 112) + CustInvoiceTrans.NUMBERSEQUENCEGROUP AS FKCustInvoiceJour
	FROM dbo.CustInvoiceTrans AS CustInvoiceTrans
	JOIN dbo.INVENTTABLE AS InventTable ON (CustInvoiceTrans.DATAAREAID = InventTable.DATAAREAID AND CustInvoiceTrans.ITEMID = InventTable.ItemId)
	WHERE CustInvoiceTrans.DATAAREAID = '100'
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_CUSTPRIVACYAGREEMENT'
			AND TYPE = 'v'
	)
	DROP VIEW [VLT_DB_POWERBI_CUSTPRIVACYAGREEMENT];
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_CUSTPRIVACYAGREEMENT]
AS
	SELECT PrivacyAgreement.CUSTACCOUNT,
		   CustTable.Name,
		   PrivacyAgreement.AGREEMENTSENDDATE,
		   CASE
			   WHEN YEAR(PrivacyAgreement.AGREEMENTSENDDATE) = 1900 THEN 0
			   WHEN YEAR(PrivacyAgreement.AGREEMENTSENDDATE) > 1900 THEN 1
		   END AS AgreementSendINT,
		   CASE
			   WHEN YEAR(PrivacyAgreement.AGREEMENTSENDDATE) = 1900 THEN 'Nein'
			   WHEN YEAR(PrivacyAgreement.AGREEMENTSENDDATE) > 1900 THEN 'Ja'
		   END AS AgreementSend,
		   PrivacyAgreement.CONTACTPERSONID,
		   CASE
			   WHEN PrivacyAgreement.CONTACTPERSONID <> '' THEN (
					   SELECT CONTACTPERSON.NAME
					   FROM CONTACTPERSON
					   WHERE ContactPerson.CONTACTPERSONID = PrivacyAgreement.ContactPersonid
						   AND ContactPerson.DATAAREAID = PrivacyAgreement.DATAAREAID
				   )
		   END AS CustpersonName,
		   PrivacyAgreement.PRIVACYAGREEMENTRETURNEDDATE,
		   PrivacyAgreement.PRIVACYPROTECTIONAGREEMEN30003 AS AgreementReturnedINT,
		   CASE
			   WHEN PrivacyAgreement.PRIVACYPROTECTIONAGREEMEN30003 = 0 THEN 'Nein'
			   WHEN PrivacyAgreement.PRIVACYPROTECTIONAGREEMEN30003 = 1 THEN 'Ja'
		   END AS AgreementReturned,
		   PrivacyAgreement.CREATEORDERS AS CreateOrdersINT,
		   CASE
			   WHEN PrivacyAgreement.CREATEORDERS = 0 THEN 'Nein'
			   WHEN PrivacyAgreement.CREATEORDERS = 1 THEN 'Ja'
		   END AS CreateOrders,
		   PrivacyAgreement.NEWSLETTER AS NEWSLETTERINT,
		   CASE
			   WHEN PrivacyAgreement.NEWSLETTER = 0 THEN 'Nein'
			   WHEN PrivacyAgreement.NEWSLETTER = 1 THEN 'Ja'
		   END AS NEWSLETTER,
		   PrivacyAgreement.ADVERTISINGPOST AS ADVERTISINGPOSTINT,
		   CASE
			   WHEN PrivacyAgreement.ADVERTISINGPOST = 0 THEN 'Nein'
			   WHEN PrivacyAgreement.ADVERTISINGPOST = 1 THEN 'Ja'
		   END AS ADVERTISINGPOST,
		   PrivacyAgreement.INVITINGPOST AS INVITINGPOSTINT,
		   CASE
			   WHEN PrivacyAgreement.INVITINGPOST = 0 THEN 'Nein'
			   WHEN PrivacyAgreement.INVITINGPOST = 1 THEN 'Ja'
		   END AS INVITINGPOST

	FROM dbo.VLT_CUSTPRIVACYPROTECTION30525 AS PrivacyAgreement
	JOIN dbo.CUSTTABLE AS CustTable ON (PrivacyAgreement.DATAAREAID = CustTable.DATAAREAID AND PrivacyAgreement.CUSTACCOUNT = CustTable.ACCOUNTNUM)
	WHERE PrivacyAgreement.DATAAREAID = '100'
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_CUSTTABLE'
			AND TYPE = 'V'
	)
	DROP VIEW [VLT_DB_POWERBI_CUSTTABLE];
GO

CREATE VIEW [DBO].[VLT_DB_POWERBI_CUSTTABLE]
AS
	SELECT CustTable.ACCOUNTNUM,
		   CustTable.NAME,
		   CustTable.CUSTNAMEADDON_ADDON AS NameAddon,
		   CustTable.ADDRESS,
		   CustTable.COUNTRYREGIONID,
		   CustTable.COUNTY,
		   CustTable.STATE,
		   CustTable.CITY,
		   CustTable.ZIPCODE,
		   CustTable.STREET,
		   CustTable.EMAIL,
		   CustTable.SALESGROUP,
		   CustTable.BLOCKED,
		   CASE
			   WHEN CustTable.BLOCKED = 0 THEN 'Nein'
			   WHEN CustTable.BLOCKED = 1 THEN 'Rechnung'
			   WHEN CustTable.BLOCKED = 2 THEN 'Alle'
		   END AS CustTableBlocked,
		   CustTable.NVCUSTCREDITCLASSID,
		   CustCreditClass.NAME AS CreditClassName,
		   PaymTerm.PAYMTERMID,
		   PaymTerm.DESCRIPTION AS PaymTermDesc,
		   PaymMode.PAYMMODE,
		   PaymMode.NAME AS PaymModeName,
		   CustTable.PRICEGROUP,
		   CustTable.STATISTICSGROUP,
		   CustTable.SalesGroup + CustTable.DATAAREAID AS FKSalesGroup,
		   CustTable.ACCOUNTNUM + CustTable.DATAAREAID AS PKCustTable

	FROM dbo.CUSTTABLE AS CustTable
	LEFT JOIN dbo.PAYMTERM AS PaymTerm ON (CustTable.DATAAREAID = PaymTerm.DATAAREAID AND CustTable.PAYMTERMID = PaymTerm.PAYMTERMID)
	LEFT JOIN dbo.CUSTPAYMMODETABLE AS PaymMode ON (CustTable.DATAAREAID = PaymMode.DATAAREAID AND CustTable.PAYMMODE = PaymMode.PAYMMODE)
	LEFT JOIN dbo.NvCustCreditClass AS CustCreditClass ON (CustTable.DATAAREAID = CustCreditClass.DATAAREAID AND CustTable.NVCUSTCREDITCLASSID = CustCreditClass.CUSTCREDITCLASSID)

	WHERE CustTable.DATAAREAID = '100'
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_EMPLTABLE'
			AND TYPE = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_EMPLTABLE;
GO

CREATE VIEW [DBO].[VLT_DB_POWERBI_EMPLTABLE]
AS
	SELECT EmplTable.VLT_POWERBIUSEREMAIL,
		   EmplTable.EMPLID,
		   EmplTable.EMPLID + EmplTable.DATAAREAID AS FKEmplId
	FROM dbo.EMPLTABLE AS EmplTable
	WHERE EmplTable.DATAAREAID = '100'
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_SALESLINE'
			AND TYPE = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_SALESLINE;
GO

CREATE VIEW [DBO].[VLT_DB_POWERBI_SALESLINE]
AS
	SELECT SalesLine.SALESID,
		   SalesLine.SALESQTY,
		   SalesLine.LINEAMOUNT,
		   SalesLine.ITEMID,
		   SalesLine.NAME,
		   SalesLine.SALESID + SalesLine.DATAAREAID AS FKSalesTable
	FROM dbo.SalesLine AS SalesLine
	WHERE SalesLine.DATAAREAID = '100'
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
		   SalesQuotationLine.LINEAMOUNT,
		   SalesQuotationLine.QUOTATIONID + SalesQuotationLine.DATAAREAID AS FKQuotationId
	FROM dbo.SalesQuotationLine AS SalesQuotationLine
	WHERE SalesQuotationLine.DATAAREAID = '100'
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

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_SALESTABLE'
			AND TYPE = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_SALESTABLE;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_SALESTABLE]
AS
	SELECT SalesTable.SALESID,
		   SalesTable.SALESNAME,
		   SalesTable.CUSTACCOUNT,
		   SalesTable.INVOICEACCOUNT,
		   SalesTable.DELIVERYDATE,
		   SalesTable.DELIVERYADDRESS,
		   SalesTable.DELIVERYCOUNTRYREGIONID,
		   SalesTable.DELIVERYCOUNTY,
		   SalesTable.DELIVERYCITY,
		   SalesTable.DELIVERYZIPCODE,
		   SalesTable.DELIVERYSTREET,
		   SalesTable.SALESGROUP,
		   SalesTable.DELIVERYNAME,
		   SalesTable.SALESPOOLID,
		   SalesTable.ENDDISC,
		   SalesTable.CREATEDDATETIME,
		   SalesTable.SalesStatus,
		   CASE
			   WHEN SalesTable.SalesStatus = 0 THEN 'Kein'
			   WHEN SalesTable.SalesStatus = 1 THEN 'Offener Auftrag'
			   WHEN SalesTable.SalesStatus = 2 THEN 'Geliefert'
			   WHEN SalesTable.SalesStatus = 3 THEN 'Fakturiert'
			   WHEN SalesTable.SalesStatus = 4 THEN 'Storniert'
		   END AS SalesStatusDesc,
		   SalesTable.SalesGroup + SalesTable.DATAAREAID AS FKSalesGroup,
		   SalesTable.SalesId + SalesTable.DATAAREAID AS FKSalesId,
		   SalesTable.CUSTACCOUNT + SalesTable.DATAAREAID AS FKCustAccount,
		   SalesTable.INVOICEACCOUNT + SalesTable.DATAAREAID AS FKInvoiceAccount,
		   SalesTable.VLT_SALESORDERPRODREGSTATUS,
		   CASE
			   WHEN SalesTable.VLT_SALESORDERPRODREGSTATUS = 0 THEN 'Nicht angemeldet'
			   WHEN SalesTable.VLT_SALESORDERPRODREGSTATUS = 1 THEN 'In Produktion'
			   WHEN SalesTable.VLT_SALESORDERPRODREGSTATUS = 2 THEN 'Fertiggemeldet'
			   WHEN SalesTable.VLT_SALESORDERPRODREGSTATUS = 3 THEN 'FÃ¼r Produktion freigegebn (AB)'
			   ELSE 'FÃ¼r Produktion gesperrt!'
		   END AS ProdStatus

	FROM dbo.SalesTable AS SalesTable
	WHERE SalesTable.DATAAREAID = '100'

GO