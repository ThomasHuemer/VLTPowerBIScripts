USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_PowerBI_BUSRELPRIVACYAGREEMENT]    Script Date: 06.06.2018 16:11:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT 1
		FROM sys.views
		WHERE name = 'VLT_DB_POWERBI_BUSRELPRIVACYAGREEMENT'
			AND type = 'v'
	)
	DROP VIEW VLT_DB_POWERBI_BUSRELPRIVACYAGREEMENT;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_BUSRELPRIVACYAGREEMENT]
AS
	SELECT PrivacyAgreement.SMMBUSRELACCOUNT,
		   BusRelTable.name AS BusRelTableName,
		   BusRelTable.EMAIL AS BusRelTableEmail,
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
		   ContactPerson.name AS ContactPersonName,
		   ContactPerson.EMAIL AS ContactPersonEmail,
		   --PrivacyAgreement.PRIVACYAGREEMENTRETURNEDDATE, 
		   dbo.VLT_DB_GETDATETIMEWITHTIMEZONE(PrivacyAgreement.PRIVACYAGREEMENTRETURNEDDATE) AS PRIVACYAGREEMENTRETURNEDDATE,
		   PrivacyAgreement.PRIVACYPROTECTIONAGREEMEN30003 AS AgreementReturnedINT,
		   CASE
			   WHEN PrivacyAgreement.PRIVACYPROTECTIONAGREEMEN30003 = 0 THEN 'Nein'
			   WHEN PrivacyAgreement.PRIVACYPROTECTIONAGREEMEN30003 = 1 THEN 'Ja'
		   END AS AgreementReturned,
		   PrivacyAgreement.CreateOrders AS CreateOrdersINT,
		   CASE
			   WHEN PrivacyAgreement.CreateOrders = 0 THEN 'Nein'
			   WHEN PrivacyAgreement.CreateOrders = 1 THEN 'Ja'
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
	LEFT JOIN dbo.ContactPerson AS ContactPerson ON (ContactPerson.CONTACTPERSONID = PrivacyAgreement.CONTACTPERSONID AND ContactPerson.DATAAREAID = PrivacyAgreement.DATAAREAID)
	WHERE PrivacyAgreement.DATAAREAID = '100'

GO


