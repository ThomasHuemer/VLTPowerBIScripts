USE VLT_AX500105_P
go
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT
			1
		FROM sys.views
		WHERE NAME = 'VLT_DB_POWERBI_ProdPoolFinished'
			AND type = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_ProdPoolFinished;
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_ProdPoolFinished]
AS

	SELECT it.PRODPOOLID AS ProdPool,
		SUM(sl.SALESQTY) AS Quantity,
		--sl.SHIPPINGDATECONFIRMED AS DELIVERYDATE,
		DATEPART(ISO_WEEK, st.NVKLZFERTDATUM) AS FinishedWeek,
		ppw.PRODWEEKCAPACITY	 AS CapacityPerWeek,
		pp.NVPRODWEEKCAPACITY	AS WeekCapacity,
		ppc.Quantity		AS QuantityPlanned,
		it.PRODPOOLID+CONVERT(VARCHAR(10),DATEPART(Year, st.NVKLZFERTDATUM)*100) + CONVERT(VARCHAR(10),DATEPART(ISO_WEEK, st.NVKLZFERTDATUM)) AS FKYearWeek 
		FROM SALESLINE sl
	JOIN INVENTTABLE it ON (sl.ITEMID = it.ITEMID AND sl.DATAAREAID = it.DATAAREAID)
	JOIN	 SALESTABLE st ON (sl.SALESID = st.SALESID AND it.DATAAREAID = st.DATAAREAID)
	LEFT JOIN VLT_DB_POWERBI_NvProdPoolWeek ppw ON (it.PRODPOOLID = ppw.PRODPOOLID AND ppw.Weeknumber = DATEPART(ISO_WEEK, st.NVKLZFERTDATUM) AND ppw.YearStart = DATEPART(Year, st.NVKLZFERTDATUM))
	LEFT JOIN PRODPOOL pp ON (it.PRODPOOLID = pp.PRODPOOLID AND pp.DATAAREAID = '100')
	LEFT JOIN VLT_DB_POWERBI_ProdPoolCapacity ppc ON (it.PRODPOOLID = ppc.PRODPOOL AND ppc.DeliveryWeek = DATEPART(ISO_WEEK, st.NVKLZFERTDATUM))
	WHERE sl.DATAAREAID	= '100'
	AND DATEPART(YEAR, st.NVKLZFERTDATUM) = DATEPART(YEAR, GETDATE())
	--AND st.SALESSTATUS	< 2
	AND st.VLT_SALESORDERPRODREGSTATUS = 2
	AND st.MAINSALESORDER_ADDON = 0
	GROUP BY it.PRODPOOLID, DATEPART(ISO_WEEK, st.NVKLZFERTDATUM), DATEPART(Year, st.NVKLZFERTDATUM), ppw.PRODWEEKCAPACITY, pp.NVPRODWEEKCAPACITY,ppc.Quantity	
GO


