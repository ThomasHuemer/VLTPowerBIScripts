USE [VLT_AX500105_P]
GO

DECLARE @dateFrom		DATETIME
DECLARE @dateTo			DATETIME
DECLARE @salesType		INT
DECLARE @salesStatus	INT
DECLARE @itemType		INT
DECLARE @poPrinted		INT
DECLARE @reqType		INT
DECLARE @covRule		INT
DECLARE @itemPBAId		NVARCHAR(20)

SET @dateFrom = DATETIMEFROMPARTS(2016, 1, 1, 0, 0, 0, 0)
SET @dateTo =	DATETIMEFROMPARTS(2018, 12, 31, 0, 0, 0, 0)

SET @salesType = 3
SET @salesStatus = 1
SET @itemType = 1
SET @poPrinted = 1
SET @reqType = 1
SET @covRule = 3
SET @itemPBAId = ''

SELECT
	st.[SALESID],
	st.CREATEDDATETIME,
	st.SALESSTATUS,
	CASE
		WHEN st.SALESSTATUS = 0 THEN 'Kein'
		WHEN st.SALESSTATUS = 1 THEN 'Offener Auftrag'
		WHEN st.SALESSTATUS = 2 THEN 'Geliefert'
		WHEN st.SALESSTATUS = 3 THEN 'Fakturiert'
		WHEN st.SALESSTATUS = 4 THEN 'Storniert'
	END AS SalesStatusDesc,
	st.SALESTYPE,
	CASE
		WHEN st.SALESTYPE = 0 THEN 'Journal'
		WHEN st.SALESTYPE = 1 THEN 'Angebot'
		WHEN st.SALESTYPE = 2 THEN 'Dauerauftrag'
		WHEN st.SALESTYPE = 3 THEN 'Auftrag'
		WHEN st.SALESTYPE = 4 THEN 'Zurückgegebener Auftrag'
		WHEN st.SALESTYPE = 5 THEN 'Abrufauftrag'
		WHEN st.SALESTYPE = 6 THEN 'Artikelbedarf'
	END AS SalesTypeDesc,
	st.SALESTAKER,
	DIRPARTYTABLE.NAME	   
FROM [dbo].[SALESTABLE] st
LEFT JOIN EMPLTABLE e ON (e.EMPLID	= st.SALESTAKER AND e.DATAAREAID = '100')
JOIN [dbo].[DIRPARTYTABLE] AS DirPartyTable ON (e.DataAreaID = DirPartyTable.DataAreaId AND e.PartyId = DirPartyTable.PARTYID AND DIRPARTYTABLE.DATAAREAID = '100')
WHERE st.CREATEDDATETIME > @dateFrom
AND st.CREATEDDATETIME < @dateTo 
AND st.SALESSTATUS < 2
AND st.SALESTYPE = 3
AND st.DATAAREAID = '100'
--AND	st.SALESTAKER = 'LIS'
ORDER BY st.CREATEDDATETIME desc

SELECT	st.SALESTAKER,
	COUNT(*) AS Counte
	
FROM [dbo].[SALESTABLE] st
LEFT JOIN EMPLTABLE e ON (e.EMPLID	= st.SALESTAKER AND e.DATAAREAID = '100')
JOIN [dbo].[DIRPARTYTABLE] AS DirPartyTable ON (e.DataAreaID = DirPartyTable.DataAreaId AND e.PartyId = DirPartyTable.PARTYID AND DIRPARTYTABLE.DATAAREAID = '100')
WHERE st.CREATEDDATETIME > @dateFrom
AND st.CREATEDDATETIME < @dateTo 
AND st.SALESSTATUS < 2
AND st.SALESTYPE = 3
AND st.DATAAREAID = '100'
--AND	st.SALESTAKER = 'LIS'
GROUP BY st.SALESTAKER
ORDER BY COUNT(*) DESC
go
/*
SELECT FIRSTFAST * FROM SalesTable 
ORDER BY SalesTable.SalesId ASC 
WHERE ((SalesId = N'594708/1')) 
AND ((SalesStatus = 1)) 
AND ((SalesType = 3)) 
AND ((createdDateTime>='2008-01-01T00:00:00')) 
AND ((NvKlzFertDatum = {ts '1900-01-01 00:00:00.000'})) 
AND ((NvProdBlocked = 0)) JOIN FIRSTFAST * FROM SalesLine 
WHERE SalesTable.SalesId = SalesLine.SalesId 
AND ((SalesStatus = 1)) AND ((Blocked = 0)) 
EXISTS JOIN FIRSTFAST * FROM InventTable WHERE SalesLine.ItemId = InventTable.ItemId 
AND ((ItemType = 1)) EXISTS JOIN FIRSTFAST * FROM ReqGroup WHERE InventTable.ReqGroupId = ReqGroup.ReqGroupId 
AND ((CovRule = 3)) AND ((NvReqType = 1))
*/