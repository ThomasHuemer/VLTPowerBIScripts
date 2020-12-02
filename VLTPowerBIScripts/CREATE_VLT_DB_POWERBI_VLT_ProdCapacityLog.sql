USE [VLT_AX500105_P]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT
			1
		FROM sys.views
		WHERE Name = 'VLT_DB_POWERBI_VLT_ProdCapacityLog'
			AND type = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_VLT_ProdCapacityLog;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_VLT_ProdCapacityLog]
AS
	SELECT
		ProdCapacityLogTable.USERID,
		ProdCapacityLogTable.SALESID,
		ProdCapacityLogTable.ITEMID,
		i.PRODPOOLID,
		ProdCapacityLogTable.CREATEDDATETIME,
		dbo.VLT_DB_GETDATETIMEWITHTIMEZONE(ProdCapacityLogTable.CREATEDDATETIME) AS 'ErstelldatumLog',
		ProdCapacityLogTable.ERRORTXT,
		DirPartyTable.NAME,
		ProdCapacityLogTable.USERID + ' ' + DirPartyTable.NAME AS SearchName,
		scui.EMPLID + scui.DATAAREAID	AS FKEmplTable,
		ProdCapacityLogTable.SALESLINEREFRECID	AS FKSalesLineRecId,
		ProdCapacityLogTable.SALESID + ProdCapacityLogTable.DATAAREAID AS FKSalesTable
	FROM dbo.VLT_PRODCAPACITYLOG AS ProdCapacityLogTable
	LEFT JOIN SysCompanyUserInfo scui ON (scui.USERID	= ProdCapacityLogTable.USERID AND scui.DATAAREAID	= ProdCapacityLogTable.DATAAREAID)
	LEFT JOIN EMPLTABLE e	ON(e.EMPLID	= scui.EMPLID AND e.DATAAREAID	= scui.DATAAREAID)
	LEFT JOIN INVENTTABLE i ON (i.ITEMID	= ProdCapacityLogTable.ITEMID)
	JOIN [dbo].[DIRPARTYTABLE] AS DirPartyTable ON (e.DataAreaID = DirPartyTable.DataAreaId AND e.PartyId = DirPartyTable.PartyId)
	
GO

