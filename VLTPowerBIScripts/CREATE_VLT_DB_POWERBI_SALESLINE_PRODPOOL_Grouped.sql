USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_SALESLINE]    Script Date: 23.07.2018 10:30:07 ******/
IF EXISTS (
		SELECT
			1
		FROM sys.views
		WHERE NAME = 'VLT_DB_POWERBI_SALESLINE_PRODPOOL_Grouped'
			AND TYPE = 'V'
	)
	DROP VIEW [dbo].[VLT_DB_POWERBI_SALESLINE_PRODPOOL_Grouped]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_SALESLINE_PRODPOOL]    Script Date: 23.07.2018 10:30:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[VLT_DB_POWERBI_SALESLINE_PRODPOOL_Grouped]
AS
	SELECT
		COUNT(vwSalesLineProdCap.DeliveryWeek) AS Divisor,
		SUM([SALESQTY]) AS SumQty,
		[ITEMID],
		[PRODPOOL],
		[DeliveryWeek],
		[DeliveryYear],
		[SALESTYPE],
		[SalesTypeDesc],
		[SALESSTATUS],
		[SALESSTATUSDesc],
		[ProdStatus],
		[ProdStatusDesc],
		Lieferdatum,
		(
			SELECT
				RIGHT('00' + CAST([DeliveryWeek] AS VARCHAR(2)), 2)
		)				AS week2,
		CONVERT(VARCHAR(10), [DeliveryYear]) + (
			SELECT
				RIGHT('00' + CAST([DeliveryWeek] AS VARCHAR(2)), 2)
		)				AS FKYearWeek,
		vwSalesLineProdCap.PRODPOOL + CONVERT(VARCHAR(10), [DeliveryYear]) + (
			SELECT
				RIGHT('00' + CAST([DeliveryWeek] AS VARCHAR(2)), 2)
		)				AS FKPoolYearWeek,
		ISNULL(ppw.ProdWeekCapacity, p.NVPRODWEEKCAPACITY) AS ProdCapacity
	FROM [dbo].[VLT_DB_POWERBI_SALESLINE_PRODPOOL] vwSalesLineProdCap
	JOIN VLT_DB_POWERBI_ProdPool p ON (p.PRODPOOLID = vwSalesLineProdCap.PRODPOOL)
	LEFT JOIN VLT_DB_POWERBI_NvProdPoolWeek ppw ON (p.PRODPOOLID = ppw.PRODPOOLID AND ppw.Weeknumber = DeliveryWeek AND ppw.YearStart = [DeliveryYear])
	GROUP BY [ITEMID],
			 [PRODPOOL],
			 [DeliveryWeek],
			 [DeliveryYear],
			 [SALESTYPE],
			 [SalesTypeDesc],
			 [SALESSTATUS],
			 [SALESSTATUSDesc],
			 [ProdStatus],
			 [ProdStatusDesc],
			 ppw.ProdWeekCapacity,
			 p.NVPRODWEEKCAPACITY,
			 lieferdatum

GO


