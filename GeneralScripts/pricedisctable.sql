/*
select itemid, 
pdt.TODATE, 
pdt.ACCOUNTCODE, 
pdt.RELATION, 
pdt.PERCENT1, 
pdt.PERCENT2,
pdt.recid,
pdt.DATAAREAID
from InventTable it
left join pricedisctable pdt on (pdt.ITEMRELATION = it.ITEMID AND pdt.DATAAREAID = it.DATAAREAID) 
where it.NVBLOCKED = 0
--and ct.LINEDISC != ''
and it.DATAAREAID = '100'
and pdt.RELATION = 5
and pdt.ACCOUNTRELATION != ''
and pdt.TODATE = DATETIMEFROMPARTS(1900, 1, 1, 0, 0, 0, 0)
*/
select ACCOUNTNUM, 
LINEDISC, 
pdt.TODATE, 
pdt.ACCOUNTCODE, 
pdt.RELATION, 
pdt.PERCENT1, 
pdt.PERCENT2,
pdt.recid,
pdt.DATAAREAID
from CUSTTABLE ct
left join pricedisctable pdt on (pdt.ACCOUNTRELATION = ct.ACCOUNTNUM AND pdt.DATAAREAID = ct.DATAAREAID) 
where ct.VLT_CUSTISDEALER = 0
--and ct.LINEDISC != ''
--and pdt.ACCOUNTCODE != 0
and ct.LINEDISC = ''
and ct.DATAAREAID = '100'
and pdt.RELATION = 5
and pdt.TODATE = DATETIMEFROMPARTS(1900, 1, 1, 0, 0, 0, 0)
--and ct.ACCOUNTNUM = '23982'