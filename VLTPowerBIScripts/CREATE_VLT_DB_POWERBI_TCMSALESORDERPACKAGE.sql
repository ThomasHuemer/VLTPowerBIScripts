USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_TCMSalesOrderPackage]    Script Date: 29.05.2018 15:52:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_TCMSALESORDERPACKAGE'
			AND TYPE = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_TCMSALESORDERPACKAGE;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_TCMSALESORDERPACKAGE]
AS
	SELECT SalesOrderPackage.SALESORDERPACKAGEBATCHNUM,
		   SalesOrderPackage.LINENUM,
		   SalesOrderPackage.SALESID,
		   SalesOrderPackage.PRODSTEPID,
		   SalesOrderPackage.WAGENID,
		   SalesOrderPackage.REMARKS,
		   SalesOrderPackage.EMPLID,
		   SalesOrderPackage.SALESORDERPACKAGESTATUS,
		   SalesOrderPackage.PRODPOOLID,
		   SalesOrderPackage.COLLI,
		   1 AS ColliCounter,
		   SalesOrderPackage.NVFERTIGDATUM,
		   dbo.VLT_DB_GETDATETIMEWITHTIMEZONE(SalesOrderPackage.CREATEDDATETIME) AS CreatedDateTime,
		   SalesOrderPackage.CREATEDBY,
		   SalesOrderPackage.DATAAREAID,
		   SalesOrderPackage.RECVERSION,
		   SalesOrderPackage.RECID,
		   SalesOrderPackage.MARKEDREPRINT,
		   SalesOrderPackage.BARCODE,
		   SalesOrderPackage.LOADINGDATETIME,
		   dbo.VLT_DB_GETDATETIMEWITHTIMEZONE(SalesOrderPackage.LOADINGDATETIME) AS LoadingDateTimeLocal,
		   SalesOrderPackage.LOADINGDATETIMETZID,
		   SalesOrderPackage.LOADINGEMPLID,
		   SalesOrderPackage.DELIVERYDATETIME,
		   dbo.VLT_DB_GETDATETIMEWITHTIMEZONE(SalesOrderPackage.DELIVERYDATETIME) AS DeliverDateTimeLocal,
		   SalesOrderPackage.DELIVERYDATETIMETZID,
		   SalesOrderPackage.DELIVERYEMPLID,
		   SalesOrderPackage.LOADINGSTATUSTEXT,
		   SalesOrderPackage.DELIVERYSTATUSTEXT,
		   SalesOrderPackage.TOURDRIVERREFRECID,
		   SalesOrderPackage.DESCRIPTION,
		   SalesOrderPackage.DELIVERYSTATUS,
		   CASE
			   WHEN SalesOrderPackage.DELIVERYSTATUS = 0 THEN 'Kein'
			   WHEN SalesOrderPackage.DELIVERYSTATUS = 1 THEN 'Geliefert'
			   WHEN SalesOrderPackage.DELIVERYSTATUS = 2 THEN 'Fehler bei Lieferung'
		   END AS DELIVERYSTATUSDesc,
		   SalesOrderPackage.LOADINGSTATUS,
		   CASE
			   WHEN SalesOrderPackage.LOADINGSTATUS = 0 THEN 'Kein'
			   WHEN SalesOrderPackage.LOADINGSTATUS = 1 THEN 'Beladen'
			   WHEN SalesOrderPackage.LOADINGSTATUS = 2 THEN 'Fehler bei Beladen'
		   END AS LOADINGSTATUSDesc,
		   SalesOrderPackage.TCMNOTDELIVERED,
		   SalesOrderPackage.LOADINGDATETIME1,
		   SalesOrderPackage.LOADINGDATETIME1TZID,
		   SalesTable.NVDESTINATIONCODEID AS Tour,
		   SalesTable.NVKLZCOLLI AS ColliTotal,
		   SalesTable.CUSTACCOUNT,
		   TourDriver.TCMVEHICLEID AS VehicleB,
		   TourDriver.TCMVEHICLEIDALTERNATIVE AS VehicleC,
		   TourDriver.DRIVERID AS Driver,
		   TourDriver.DELIVERYDATE AS TourDeliveryDate
	FROM dbo.TCMSALESORDERPACKAGE AS SalesOrderPackage
	LEFT JOIN dbo.SalesTable AS SalesTable ON (SalesOrderPAckage.DATAAREAID = SalesTable.DATAAREAID AND SalesOrderPAckage.Salesid = SalesTable.SalesId)
	LEFT JOIN dbo.NVTOURDRIVER AS TourDriver ON (SalesOrderPAckage.DATAAREAID = TourDriver.DATAAREAID AND SalesOrderPAckage.TOURDRIVERREFRECID = TourDriver.RECID)
	WHERE SalesOrderPAckage.DATAAREAID = '100'

