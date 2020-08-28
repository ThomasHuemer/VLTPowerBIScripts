USE VLT_AX500105_P
GO

SELECT
	st.[SALESID],
	st.CUSTACCOUNT,
	st.SALESNAME,
	st.PRICEGROUPID AS 'Preisgruppe',
	[ITEMID],
	--st.SALESSTATUS,
	CASE
		WHEN st.SALESSTATUS = 0 THEN 'Kein'
		WHEN st.SALESSTATUS = 1 THEN 'Offener Auftrag'
		WHEN st.SALESSTATUS = 2 THEN 'Geliefert'
		WHEN st.SALESSTATUS = 3 THEN 'Fakturiert'
		WHEN st.SALESSTATUS = 4 THEN 'Storniert'
	END AS 'Status',
	CASE
		WHEN st.QUOTATIONID	= '' THEN 'Nein'
		WHEN st.QUOTATIONID	IS NULL THEN 'Nein'
		WHEN st.QUOTATIONID	!= '' THEN 'Ja'
	END AS 'Umgewandelt',
	CASE
		WHEN st.NVPROJECTID	= '' THEN 'Nein'
		WHEN st.NVPROJECTID	IS NULL THEN 'Nein'
		WHEN st.NVPROJECTID	!= '' THEN 'Ja'
	END AS 'Projekt',
	CASE
		WHEN ct.VLT_CUSTISDEALER = 0 THEN 'Nein'
		WHEN ct.VLT_CUSTISDEALER = 1 THEN 'Ja'
	END AS 'Haendler',
	CASE
		WHEN sl.NVORIGSALESPRICE = 0 THEN 100
		WHEN sl.NVORIGSALESPRICE != 0 THEN ((sl.NVORIGSALESPRICE - sl.SALESPRICE) / sl.NVORIGSALESPRICE) * 100
	END																											AS 'Rabatt Liste',
	LINEPERCENT																									AS 'Rabatt %',
	NVKLZSONDERRABATT																							AS 'S-Rabatt',
	sl.LINEPERCENT + sl.NVKLZSONDERRABATT																		'Rabatt % + S-Rabatt',
	sl.LINEPERCENT + sl.NVKLZSONDERRABATT + ((sl.NVORIGSALESPRICE - sl.SALESPRICE) / sl.NVORIGSALESPRICE) * 100 AS 'Summe Rabatte',
	(select max (INVOICEDATE) from custInvoiceSalesLink                 
                    where  custInvoiceSalesLink.OrigSalesId = st.SALESID) AS 'Fakturiert am'
--,(sl.NvOrigSalesPrice-sl.SalesPrice)/sl.NvOrigSalesPrice AS percentOrg
FROM [dbo].[SALESLINE] sl
JOIN SALESTABLE st ON (sl.SALESID = st.SALESID)
JOIN CUSTTABLE ct ON (ct.ACCOUNTNUM = st.INVOICEACCOUNT)
WHERE	st.CREATEDDATETIME >= DATETIMEFROMPARTS(2020, 1, 1, 0, 0, 0, 0)
	AND st.CREATEDDATETIME <= DATETIMEFROMPARTS(2020, 6, 4, 0, 0, 0, 0)
	AND sl.NVORIGSALESPRICE != sl.SALESPRICE
	AND sl.NVORIGSALESPRICE != 0
	AND (sl.NVORIGSALESPRICE - sl.SALESPRICE) / sl.NVORIGSALESPRICE > 0.39
	  --and sl.salesid = '615069/1'
	  --order by percentSum desc
	  --group by st.salesid, st.CUSTACCOUNT, st.salesname
	  
