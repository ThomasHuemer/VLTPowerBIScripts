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
		   CUSTTABLE.CREDITRATING,
		   CUSTTABLE.CREDITMAX,
		   CUSTTABLE.NVCUSTCLASSID,
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
		   CUSTTABLE.PARTYID,
		   CustTable.SalesGroup + CustTable.DATAAREAID AS FKSalesGroup,
		   CustTable.ACCOUNTNUM + CustTable.DATAAREAID AS PKCustTable,
		   CustTable.PARTYID + CustTable.DATAAREAID AS FKPartyId

	FROM dbo.CUSTTABLE AS CustTable
	LEFT JOIN dbo.PAYMTERM AS PaymTerm ON (CustTable.DATAAREAID = PaymTerm.DATAAREAID AND CustTable.PAYMTERMID = PaymTerm.PAYMTERMID)
	LEFT JOIN dbo.CUSTPAYMMODETABLE AS PaymMode ON (CustTable.DATAAREAID = PaymMode.DATAAREAID AND CustTable.PAYMMODE = PaymMode.PAYMMODE)
	LEFT JOIN dbo.NvCustCreditClass AS CustCreditClass ON (CustTable.DATAAREAID = CustCreditClass.DATAAREAID AND CustTable.NVCUSTCREDITCLASSID = CustCreditClass.CUSTCREDITCLASSID)
	WHERE CustTable.DATAAREAID = '100'
GO
