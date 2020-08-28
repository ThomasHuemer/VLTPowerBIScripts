USE VLT_AX500105_P
SELECT [SALESID] AS 'Auftragsnummer',
	   [SALESNAME] AS 'Name',
	   [CUSTACCOUNT] AS 'Debitornr.',
	   [INVOICEACCOUNT] AS 'Rechnungskonto',
	   [DELIVERYDATE] AS 'Lieferdatum',
	   st.CREATEDDATETIME AS 'Erstelldatum',
	   [DELIVERYADDRESS] AS 'Lieferdatum',
	   [SALESSTATUS],
	   		   CASE
			   WHEN st.SALESSTATUS = 0 THEN 'Kein'
			   WHEN st.SALESSTATUS = 1 THEN 'Offener Auftrag'
			   WHEN st.SALESSTATUS = 2 THEN 'Geliefert'
			   WHEN st.SALESSTATUS = 3 THEN 'Fakturiert'
			   WHEN st.SALESSTATUS = 4 THEN 'Storniert'
		   END AS Auftragsstatus,
	   [SALESPOOLID] AS 'Pool',
	   [MAINSALESID_ADDON] AS 'Hauptauftragsnummer',
	   [MAINSALESORDER_ADDON] AS 'Hauptauftrag Ja/Nein'
	   
FROM [dbo].[SALESTABLE] st

WHERE st.CREATEDDATETIME > DATETIMEFROMPARTS(2014, 3, 1, 0, 0, 0, 0)
	AND st.CREATEDDATETIME < DATETIMEFROMPARTS(2017, 2, 28, 0, 0, 0, 0)
	AND st.SALESSTATUS < 3
	AND st.SALESPOOLID != 'STD'
	ORDER BY st.CREATEDDATETIME 