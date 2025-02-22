SELECT [SALESID]
      ,[LINENUM]
      ,[ITEMID]
      ,[SALESSTATUS]
      ,[LEDGERACCOUNT]
      ,[NAME]
      ,[EXTERNALITEMID]
      ,[TAXGROUP]
      ,[QTYORDERED]
      ,[SALESDELIVERNOW]
      ,[REMAINSALESPHYSICAL]
      ,[REMAINSALESFINANCIAL]
      ,[COSTPRICE]
      ,[SALESPRICE]
      ,[CURRENCYCODE]
      ,[LINEPERCENT]
      ,[LINEDISC]
      ,[LINEAMOUNT]
      ,[CONFIRMEDDLV]
      ,[RESERVATION]
      ,[SALESGROUP]
      ,[SALESUNIT]
      ,[DIMENSION]
      ,[DIMENSION2_]
      ,[DIMENSION3_]
      ,[PRICEUNIT]
      ,[INVENTTRANSID]
      ,[CUSTGROUP]
      ,[CUSTACCOUNT]
      ,[SALESQTY]
      ,[SALESMARKUP]
      ,[INVENTDELIVERNOW]
      ,[MULTILNDISC]
      ,[MULTILNPERCENT]
      ,[SALESTYPE]
      ,[BLOCKED]
      ,[COMPLETE]
      ,[REMAININVENTPHYSICAL]
      ,[TRANSACTIONCODE]
      ,[TAXITEMGROUP]
      ,[TAXAUTOGENERATED]
      ,[UNDERDELIVERYPCT]
      ,[OVERDELIVERYPCT]
      ,[BARCODE]
      ,[BARCODETYPE]
      ,[INVENTREFTRANSID]
      ,[INVENTREFTYPE]
      ,[INVENTREFID]
      ,[ITEMBOMID]
      ,[ITEMROUTEID]
      ,[LINEHEADER]
      ,[SCRAP]
      ,[DEL_RETURNACTIONID]
      ,[INVENTTRANSIDRETURN]
      ,[INVENTDIMID]
      ,[TRANSPORT]
      ,[STATPROCID]
      ,[DEL_ESTIMATEGROSS]
      ,[DEL_ESTIMATENET]
      ,[PORT]
      ,[CUSTOMERLINENUM]
      ,[PACKINGUNITQTY]
      ,[PACKINGUNIT]
      ,[ITEMPBAID]
      ,[NVORIGSALESPRICE]
      ,[NVKLZSONDERRABATT]
      ,[NVOPTIONALITEM]
      ,[NVMODELDESCRIPTIONTEXT]
      ,[NVMODELMAINDIM2]
      ,[NVMODELMAINDIM1]
      ,[NVCONFIGSTRING]
      ,[CREATEDDATETIME]
      ,[DATAAREAID]
      ,[RECID]
      ,[NVPRODPOOLID]
      ,[NVAUTOLINE]
      ,[NVMARKUPPERCENT]
      ,[RECVERSION]
      ,[DEL_INTERCOMPANYRETURNACTIONID]
      ,[DEL_INTERCOMPANYRETURNACTION41]
      ,[DEL_DELIVERYDATECONTROL]
      ,[DLVMODE]
      ,[RECEIPTDATEREQUESTED]
      ,[REMAININVENTFINANCIAL]
      ,[DELIVERYADDRESS]
      ,[DELIVERYNAME]
      ,[DELIVERYSTREET]
      ,[DELIVERYZIPCODE]
      ,[DELIVERYCITY]
      ,[DELIVERYCOUNTY]
      ,[DELIVERYSTATE]
      ,[DELIVERYCOUNTRYREGIONID]
      ,[DELIVERYTYPE]
      ,[CUSTOMERREF]
      ,[PURCHORDERFORMNUM]
      ,[RECEIPTDATECONFIRMED]
      ,[BLANKETREFTRANSID]
      ,[STATTRIANGULARDEAL]
      ,[SHIPPINGDATEREQUESTED]
      ,[SHIPPINGDATECONFIRMED]
      ,[ADDRESSREFRECID]
      ,[ADDRESSREFTABLEID]
      ,[ITEMTAGGING]
      ,[CASETAGGING]
      ,[PALLETTAGGING]      
      ,[EINVOICEACCOUNTCODE]
      ,[SHIPCARRIERID]
      ,[SHIPCARRIERACCOUNT]
      ,[SHIPCARRIERDLVTYPE]
      ,[SHIPCARRIERACCOUNTCODE]
      ,[DELIVERYDATECONTROLTYPE]
      ,[ATPINCLPLANNEDORDERS]
      ,[ATPTIMEFENCE]
      ,[RETURNALLOWRESERVATION]
      ,[ITEMREPLACED]
      ,[RETURNDEADLINE]
      ,[EXPECTEDRETQTY]
      ,[RETURNSTATUS]
      ,[RETURNARRIVALDATE]
      ,[RETURNCLOSEDDATE]
      ,[RETURNDISPOSITIONCODEID]
      ,[PROJTRANSID]
      ,[PROJCATEGORYID]
      ,[PROJID]
      ,[PROJLINEPROPERTYID]
      ,[ACTIVITYNUMBER]
      ,[SALESBOQID]
      ,[DONOTPRINTLINE_ADDON]
  FROM [dbo].[SALESLINE] sl
WHERE sl.CREATEDDATETIME	>= DATETIMEFROMPARTS(2014, 1, 1, 0, 0, 0, 0) AND
      sl.CREATEDDATETIME <= DATETIMEFROMPARTS(2017, 4, 30, 0, 0, 0, 0)

