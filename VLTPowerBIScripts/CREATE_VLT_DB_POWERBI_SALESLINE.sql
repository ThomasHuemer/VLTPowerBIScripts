USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_SALESLINE]    Script Date: 23.07.2018 10:30:07 ******/
IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_SALESLINE'
			AND TYPE = 'V'
	)
	DROP VIEW [dbo].[VLT_DB_POWERBI_SALESLINE]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_SALESLINE]    Script Date: 23.07.2018 10:30:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VLT_DB_POWERBI_SALESLINE]
AS
	SELECT SalesLine.SALESID,
		   SalesLine.SALESQTY,
		   SalesLine.LINEAMOUNT,
		   SalesLine.ITEMID,
		   SalesLine.NAME,
		   InventTable.ITEMGROUPID,
		   InventItemGroup.NAME ItemGroupName,
		   SalesLine.SALESBOQID,
		   SalesLine.lineNum,
		   SalesLine.SALESID + SalesLine.DATAAREAID AS FKSalesTable,
		   SALESLINE.ITEMID + SalesLine.DATAAREAID AS FKInventTable,
		   SalesLine.RECID	AS FKRecId
	FROM dbo.SalesLine AS SalesLine
	LEFT JOIN dbo.InventTable AS InventTable ON (SalesLine.DATAAREAID = InventTable.DATAAREAID AND SalesLine.ITEMID = InventTable.ITEMID)
	LEFT JOIN dbo.InventItemGroup AS InventItemGroup ON (InventTable.DATAAREAID = InventItemGroup.DATAAREAID AND InventTable.ITEMGROUPID = InventItemGroup.ITEMGROUPID)
	WHERE SalesLine.DATAAREAID = '100'
	AND SalesLine.CREATEDDATETIME > DATETIMEFROMPARTS(YEAR(GETDATE())-3, 1, 1, 0, 0, 0, 0)
GO


