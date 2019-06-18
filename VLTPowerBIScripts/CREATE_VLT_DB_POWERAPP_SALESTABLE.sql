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
		WHERE NAME = 'VLT_DB_POWERAPP_SALESTABLE'
			AND TYPE = 'V'
	)
	DROP VIEW VLT_DB_VLT_DB_POWERAPP_SALESTABLE;
GO

CREATE VIEW [dbo].[VLT_DB_VLT_DB_POWERAPP_SALESTABLE]
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
		   SalesTable.NVKLZFERTDATUM AS Fertiggemeldet,
		   SalesTable.NVPROJECTID AS Projektnummer,
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
			   WHEN SalesTable.VLT_SALESORDERPRODREGSTATUS = 3 THEN 'Für Produktion freigegeben (AB)'
			   ELSE 'Für Produktion gesperrt!'
		   END AS ProdStatus
	FROM dbo.SalesTable AS SalesTable
	WHERE SalesTable.DATAAREAID = '100'
		AND SalesTable.VLT_ISSALESORDERTEST = 0

GO

