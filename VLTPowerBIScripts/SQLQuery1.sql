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
		WHERE NAME = 'VLT_DB_POWERBI_CollectionLetterCode'
			AND TYPE = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_CollectionLetterCode;
GO


CREATE VIEW [dbo].[VLT_DB_POWERBI_CollectionLetterCode]
AS
SELECT 0 AS CollectionLetterCode,'kein' AS CollectionLetterCodeDesc
UNION SELECT 1 AS CollectionLetterCode,'Mahnung' AS CollectionLetterCodeDesc
UNION SELECT 2 AS CollectionLetterCode,'2. Mahnung' AS CollectionLetterCodeDesc
UNION SELECT 3 AS CollectionLetterCode,'Letzte Mahnung' AS CollectionLetterCodeDesc
UNION SELECT 4 AS CollectionLetterCode,'Auﬂergerichtlich' AS CollectionLetterCodeDesc
UNION SELECT 5 AS CollectionLetterCode,'Rechtsanwalt' AS CollectionLetterCodeDesc
UNION SELECT 6 AS CollectionLetterCode,'Erledigt' AS CollectionLetterCodeDesc
UNION SELECT 7 AS CollectionLetterCode,'Alle' AS CollectionLetterCodeDesc
UNION SELECT 8 AS CollectionLetterCode,'Mahnung pro Kunde' AS CollectionLetterCodeDesc
GO


