USE [VLT_AX500105_P]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_SALESTABLEMAINORDER'
			AND TYPE = 'V'
	)
	DROP VIEW [VLT_DB_POWERBI_SALESTABLEMAINORDER];
GO

CREATE VIEW [DBO].[VLT_DB_POWERBI_SALESTABLEMAINORDER]
AS
	SELECT SalesTableMain.SALESID,
		   SalesTableMain.SALESNAME,
		   SalesTableMain.CUSTACCOUNT,
		   SalesTableMain.INVOICEACCOUNT,
		   SalesTableMain.DELIVERYDATE,
		   SalesTableMain.DELIVERYADDRESS,
		   SalesTableMain.DELIVERYCOUNTRYREGIONID,
		   SalesTableMain.DELIVERYCOUNTY,
		   SalesTableMain.DELIVERYCITY,
		   SalesTableMain.DELIVERYZIPCODE,
		   SalesTableMain.DELIVERYSTREET,
		   SalesTableMain.SALESGROUP,
		   SalesTableMain.DELIVERYNAME,
		   SalesTableMain.SALESPOOLID,
		   SalesTableMain.ENDDISC,
		   SalesTableMain.CREATEDDATETIME,
		   SalesTableMain.SalesStatus,
		   (
			   SELECT CASE
					   WHEN SalesTableMain.CurrencyCode = 'ATS' AND SUM(dbo.SalesLine.LineAmount) != 0 THEN SUM(dbo.SalesLine.LineAmount) / 13.7603
					   ELSE SUM(dbo.SalesLine.LineAmount)
				   END
			   FROM SalesLine
			   WHERE SalesLine.SALESID = SalesTableMain.SALESID
				   AND SalesLine.DATAAREAID = SalesTableMain.DATAAREAID
		   ) AS TotalAmount,
		   CASE
			   WHEN (
					   SELECT CUSTINVOICESALESLINK.SALESID AS CountId
					   FROM dbo.CUSTINVOICESALESLINK
					   WHERE CUSTINVOICESALESLINK.ORIGSALESID = SalesTableMain.SALESID
						   AND CUSTINVOICESALESLINK.DATAAREAID = SalesTableMain.DATAAREAID
						   AND CUSTINVOICESALESLINK.SALESID != SalesTableMain.SalesId
					   GROUP BY CUSTINVOICESALESLINK.SALESID
				   ) IS NULL THEN SalesTableMain.SALESID
			   ELSE (
					   SELECT CUSTINVOICESALESLINK.SALESID AS CountId
					   FROM dbo.CUSTINVOICESALESLINK
					   WHERE CUSTINVOICESALESLINK.ORIGSALESID = SalesTableMain.SALESID
						   AND CUSTINVOICESALESLINK.DATAAREAID = SalesTableMain.DATAAREAID
						   AND CUSTINVOICESALESLINK.SALESID != SalesTableMain.SalesId
					   GROUP BY CUSTINVOICESALESLINK.SALESID
				   )
		   END AS InvoicedSalesId,
		   SalesTableMain.MAINSALESID_ADDON,
		   SalesTableMain.MAINSALESORDER_ADDON,
		   CASE
			   WHEN SalesTableMain.MAINSALESORDER_ADDON = 0 THEN 'Nein'
			   WHEN SalesTableMain.MAINSALESORDER_ADDON = 1 THEN 'Ja'
		   END AS MAINSALESORDER_ADDON_DESC,
		   SalesTableMain.NVKLZFERTDATUM AS Fertiggemeldet,
		   SalesTableMain.NVPROJECTID AS Projektnummer,
		   CASE
			   WHEN SalesTableMain.SalesStatus = 0 THEN 'Kein'
			   WHEN SalesTableMain.SalesStatus = 1 THEN 'Offener Auftrag'
			   WHEN SalesTableMain.SalesStatus = 2 THEN 'Geliefert'
			   WHEN SalesTableMain.SalesStatus = 3 THEN 'Fakturiert'
			   WHEN SalesTableMain.SalesStatus = 4 THEN 'Storniert'
		   END AS SalesStatusDesc,
		   SalesTableMain.SalesGroup + SalesTableMain.DATAAREAID AS FKSalesGroup,
		   SalesTableMain.SalesId + SalesTableMain.DATAAREAID AS FKSalesId,
		   SalesTableMain.CUSTACCOUNT + SalesTableMain.DATAAREAID AS FKCustAccount,
		   SalesTableMain.INVOICEACCOUNT + SalesTableMain.DATAAREAID AS FKInvoiceAccount,
		   SalesTableMain.NVPROJECTID + SalesTableMain.DATAAREAID AS FKProjectId,
		   SalesTableMain.VLT_SALESORDERPRODREGSTATUS,
		   CASE
			   WHEN SalesTableMain.VLT_SALESORDERPRODREGSTATUS = 0 THEN 'Nicht angemeldet'
			   WHEN SalesTableMain.VLT_SALESORDERPRODREGSTATUS = 1 THEN 'In Produktion'
			   WHEN SalesTableMain.VLT_SALESORDERPRODREGSTATUS = 2 THEN 'Fertiggemeldet'
			   WHEN SalesTableMain.VLT_SALESORDERPRODREGSTATUS = 3 THEN 'Für Produktion freigegeben (AB)'
			   ELSE 'Für Produktion gesperrt!'
		   END AS ProdStatus,
		   SalesTableMain.CURRENCYCODE,
		   SalesTableMain.COMMISSIONGROUP,
		   CASE
			   WHEN SalesTableMain.COMMISSIONGROUP = '' THEN 1
			   WHEN SalesTableMain.COMMISSIONGROUP IS NULL THEN 1
			   ELSE ComCalc.COMMISSIONBASE
		   END AS ComBase,
		   ComCalc.COMMISSIONBASE,
		   SalesTableMain.DATAAREAID
	--(select stuff((select  ', ' + convert(varchar,FORMAT(sum(salesLine.SalesQty),'###,###,###.00','de-de')) + ' Stk. ' +SALESLINE.ITEMID from [dbo].[SALESLINE] 
	--	where salesLine.SALESID = SalesTable.SALESID 
	--	AND SalesLine.SalesQty != 0 
	--	AND SalesLine.ITEMPBAID	!= ''
	--	group by salesLine.itemid 
	--	for xml path ('')), 1, 2, '')) as Produkte
	FROM dbo.SalesTable AS SalesTableMain
	LEFT JOIN dbo.COMMISSIONCUSTOMERGROUP AS ComCustGroup ON (ComCustGroup.DATAAREAID = SalesTableMain.DATAAREAID AND ComCustGroup.GROUPID = SalesTableMain.COMMISSIONGROUP)
	LEFT JOIN COMMISSIONCALC AS ComCalc ON (ComCalc.DATAAREAID = ComCustGroup.DATAAREAID AND ComCalc.CUSTOMERRELATION = ComCustGroup.GROUPID AND ComCalc.CUSTOMERCODE = 1)
	WHERE SalesTableMain.DATAAREAID = '100'
		AND SalesTableMain.VLT_ISSALESORDERTEST = 0
		AND SalesTableMain.MAINSALESORDER_ADDON = 1
--AND     SALESID = '565374/1'
GO

