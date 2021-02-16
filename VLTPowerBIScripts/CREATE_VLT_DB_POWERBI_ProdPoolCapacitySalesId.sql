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
		WHERE NAME = 'VLT_DB_POWERBI_ProdPoolCapacitySalesID'
			AND type = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_ProdPoolCapacitySalesId;
GO

CREATE VIEW [dbo].VLT_DB_POWERBI_ProdPoolCapacitySalesID
AS

	SELECT
		it.PRODPOOLID																																		  AS ProdPool,
		--msoc.QtyMainOrder																																	AS MainSalesOrderQty,
		--sl.SHIPPINGDATECONFIRMED AS DELIVERYDATE,
		DATEPART(ISO_WEEK, sl.SHIPPINGDATECONFIRMED)																											  AS DeliveryWeek,
		ppw.PRODWEEKCAPACITY																																  AS CapacityPerWeek,
		(
			SELECT
				QtyMainOrder
			FROM VLT_DB_POWERBI_TCMMainSalesOrderCapacity msoc
			WHERE msoc.PRODPOOLID = it.PRODPOOLID
				AND msoc.WeekPlanned = DATEPART(ISO_WEEK, sl.SHIPPINGDATECONFIRMED)
		)																																					  AS MainOrderQty,
		it.PRODPOOLID + CONVERT(VARCHAR(10), DATEPART(YEAR, sl.SHIPPINGDATECONFIRMED) * 100) + CONVERT(VARCHAR(10), DATEPART(ISO_WEEK, sl.SHIPPINGDATECONFIRMED)) AS FKYearWeek,
		ppcj.Quantity																																		  AS JournalQty,
		SUM(sl.SALESQTY)																																	  AS SalesOrderQTY,
		CASE
			WHEN ppcj.Quantity != 0 THEN SUM(sl.SALESQTY) + ppcj.Quantity
			WHEN ppcj.Quantity IS NULL OR ppcj.Quantity = 0 THEN SUM(sl.SALESQTY)
		END																																					  AS Quantity,
		st.SALESID																																			  AS SalesIdProdCapa
		

	FROM SALESLINE sl
	JOIN INVENTTABLE it ON (sl.ITEMID = it.ITEMID AND sl.DATAAREAID = it.DATAAREAID)
	JOIN SALESTABLE st ON (sl.SalesID = st.SalesID AND it.DATAAREAID = st.DATAAREAID)
	LEFT JOIN VLT_DB_POWERBI_NvProdPoolWeek ppw ON (it.PRODPOOLID = ppw.PRODPOOLID AND ppw.Weeknumber = DATEPART(ISO_WEEK, sl.SHIPPINGDATECONFIRMED) AND ppw.YearStart = DATEPART(YEAR, sl.SHIPPINGDATECONFIRMED))
	LEFT JOIN VLT_DB_POWERBI_ProdPoolCapacityJournal ppcj ON (ppcj.DeliveryWeek = DATEPART(ISO_WEEK, sl.SHIPPINGDATECONFIRMED) AND ppcj.ProdPool = it.PRODPOOLID)
	WHERE sl.DATAAREAID = '100'
		AND DATEPART(YEAR, sl.SHIPPINGDATECONFIRMED) = DATEPART(YEAR, GETDATE())
		AND st.SALESSTATUS < 2
		AND st.VLT_SALESORDERPRODREGSTATUS != 2
		AND st.MAINSALESORDER_ADDON = 0
		AND st.SALESTYPE != 0
		AND it.ITEMTYPE = 1
	GROUP BY it.PRODPOOLID,
			 DATEPART(ISO_WEEK, sl.SHIPPINGDATECONFIRMED),
			 DATEPART(YEAR, sl.SHIPPINGDATECONFIRMED),
			 ppw.PRODWEEKCAPACITY,
			 ppcj.Quantity,
			 st.SALESID


