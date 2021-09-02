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
		WHERE NAME = 'VLT_DB_POWERBI_NVBOMDOCUPARTITEM'
			AND TYPE = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_NVBOMDOCUPARTITEM;
GO

CREATE VIEW [DBO].[VLT_DB_POWERBI_NVBOMDOCUPARTITEM]
AS
	SELECT
		DocuPartItem.[PRODUCTID],
		DocuPartItem.[POSITIONID],
		DocuPartItem.[PARTID],
		DocuPartItem.[ITEMID],
		i.ITEMNAME,
		DocuPartItem.[TXT],
		DocuPartItem.[VERSIONID],
		DocuPartItem.[COLORID],
		DocuPartItem.[SIZEID],
		DocuPartItem.[CHANGEREQ],
		DocuPartItem.[CHANGETXT],
		DocuPartItem.[BLOCKED],
		DocuPartItem.[QTY],
		DocuPartItem.[FIXEDSIZE],
		DocuPartItem.[DATAAREAID],
		DocuPartItem.[RECID],
		DocuPartItem.[WIDTHADJ],
		DocuPartItem.[HEIGHTADJ],
		DocuPartItem.[CUTTOLENGTH],
		DocuPartItem.[HEIGHTDEPENDENT],
		DocuPartItem.[BENCHID],
		DocuPartItem.[OPTIMIZE],
		DocuPartItem.[OFFCUTADMIN],
		DocuPartItem.[RECVERSION],
		DocuPartItem.[VALUEX],
		DocuPartItem.[VALUEY],
		DocuPartItem.[VALUEZ],
		DocuPartItem.[NOCUTLABELS],
		DocuPartItem.[PICKSLIPUNITID],
		DocuPartItem.[PICKSLIPSUMONLY],
		DocuPartItem.[VLT_EXPLOREBOM],
		DocuPartItem.PRODUCTID + DocuPartItem.DATAAREAID AS FKProductID,
		DocuPartItem.VERSIONID + DocuPartItem.PRODUCTID + DocuPartItem.DATAAREAID AS FKVersionProductID,
		DocuPartItem.POSITIONID + DocuPartItem.VERSIONID + DocuPartItem.PRODUCTID + DocuPartItem.DATAAREAID AS FKPositionVersionProductID,
		DocuPartItem.PARTID + DocuPartItem.POSITIONID + DocuPartItem.VERSIONID + DocuPartItem.PRODUCTID + DocuPartItem.DATAAREAID AS FKPartPositionVersionProductID,
		DocuPartItem.ITEMID + DocuPartItem.PARTID + DocuPartItem.POSITIONID + DocuPartItem.VERSIONID + DocuPartItem.PRODUCTID + DocuPartItem.DATAAREAID AS FKItemPartPositionVersionProductID
	FROM [DBO].[NVBOMDOCUPARTITEM] AS DocuPartItem
	LEFT JOIN INVENTTABLE i ON (i.ITEMID = DocuPartItem.ITEMID AND i.DATAAREAID = '100')
	JOIN NVBOMDOCUVERSION nbdv ON (DocuPartItem.VERSIONID = nbdv.VERSIONID AND DocuPartItem.PRODUCTID = nbdv.PRODUCTID) 
	WHERE nbdv.ACTIVE = 1
GO