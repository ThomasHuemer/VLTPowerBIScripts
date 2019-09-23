USE [VLT_AX500105_P]
GO
/****** Object:  View [dbo].[VLT_DB_PowerBI_EmplTable]    Script Date: 29.05.2018 15:51:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_NvInvoicingBlockedType'
			AND TYPE = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_NvInvoicingBlockedType;
GO


CREATE VIEW [dbo].[VLT_DB_POWERBI_NvInvoicingBlockedType]
AS

SELECT 0 AS NvInvoicingBlockedType,'' AS NvInvoicingBlockedTypeDesc
UNION SELECT 1 AS NvInvoicingBlockedType,'Abklären' AS NvInvoicingBlockedTypeDesc
UNION SELECT 2 AS NvInvoicingBlockedType,'Gesperrt' AS NvInvoicingBlockedTypeDesc
UNION SELECT 3 AS NvInvoicingBlockedType,'Wiedervorlage' AS NvInvoicingBlockedTypeDesc
UNION SELECT 4 AS NvInvoicingBlockedType,'Autosperre' AS NvInvoicingBlockedTypeDesc
GO


