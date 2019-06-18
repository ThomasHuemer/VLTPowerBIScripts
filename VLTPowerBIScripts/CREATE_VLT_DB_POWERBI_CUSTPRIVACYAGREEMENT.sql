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
		WHERE NAME = 'VLT_DB_POWERBI_CUSTPRIVACYAGREEMENT'
			AND TYPE = 'v'
	)
	DROP VIEW [VLT_DB_POWERBI_CUSTPRIVACYAGREEMENT];
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_CUSTPRIVACYAGREEMENT]
AS
	SELECT PrivacyAgreement.CUSTACCOUNT,
		   CustTable.Name AS CustTableName,
		   CustTable.EMAIL AS CustTableEmail,
		   --PrivacyAgreement.AGREEMENTSENDDATE,
		   dbo.VLT_DB_GETDATETIMEWITHTIMEZONE(PrivacyAgreement.AGREEMENTSENDDATE) AS AGREEMENTSENDDATE,
		   CASE
			   WHEN YEAR(PrivacyAgreement.AGREEMENTSENDDATE) = 1900 THEN 0
			   WHEN YEAR(PrivacyAgreement.AGREEMENTSENDDATE) > 1900 THEN 1
		   END AS AgreementSendINT,
		   CASE
			   WHEN YEAR(PrivacyAgreement.AGREEMENTSENDDATE) = 1900 THEN 'Nein'
			   WHEN YEAR(PrivacyAgreement.AGREEMENTSENDDATE) > 1900 THEN 'Ja'
		   END AS AgreementSend,
		   PrivacyAgreement.CONTACTPERSONID,
		   --		CASE
		   --			WHEN PrivacyAgreement.CONTACTPERSONID <> '' THEN (Select CONTACTPERSON.NAME 
		   --																from CONTACTPERSON 
		   --																WHERE ContactPerson.CONTACTPERSONID = PrivacyAgreement.ContactPersonid
		   --																AND ContactPerson.DATAAREAID	= PrivacyAgreement.DATAAREAID)																 
		   --		END AS CustpersonName,
		   ContactPerson.NAME AS ContactPersonName,
		   ContactPerson.EMAIL AS ContactPersonEmail,
		   --PrivacyAgreement.PRIVACYAGREEMENTRETURNEDDATE, 
		   dbo.VLT_DB_GETDATETIMEWITHTIMEZONE(PrivacyAgreement.PRIVACYAGREEMENTRETURNEDDATE) AS PRIVACYAGREEMENTRETURNEDDATE,
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
	LEFT JOIN dbo.CONTACTPERSON AS ContactPerson ON (ContactPerson.CONTACTPERSONID = PrivacyAgreement.ContactPersonid AND ContactPerson.DATAAREAID = PrivacyAgreement.DATAAREAID)
	WHERE PrivacyAgreement.DATAAREAID = '100'
GO