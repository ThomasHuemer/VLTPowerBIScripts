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
		WHERE NAME = 'VLT_DB_POWERBI_CustCollectionLetterCode'
			AND TYPE = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_CustCollectionLetterCode;
GO


CREATE VIEW [dbo].[VLT_DB_POWERBI_CustCollectionLetterCode]
AS

SELECT 0 AS CustCollectionLetterCode,'kein' AS CustCollectionLetterCodeDesc
UNION SELECT 1 AS CustCollectionLetterCode,'Mahnung' AS CustCollectionLetterCodeDesc
UNION SELECT 2 AS CustCollectionLetterCode,'2. Mahnung' AS CustCollectionLetterCodeDesc
UNION SELECT 3 AS CustCollectionLetterCode,'Letzte Mahnung' AS CustCollectionLetterCodeDesc
UNION SELECT 4 AS CustCollectionLetterCode,'Auﬂergerichtlich' AS CustCollectionLetterCodeDesc
UNION SELECT 5 AS CustCollectionLetterCode,'Rechtsanwalt' AS CustCollectionLetterCodeDesc
UNION SELECT 6 AS CustCollectionLetterCode,'Erledigt' AS CustCollectionLetterCodeDesc
UNION SELECT 7 AS CustCollectionLetterCode,'Alle' AS CustCollectionLetterCodeDesc
UNION SELECT 8 AS CustCollectionLetterCode,'Mahnung pro Kunde' AS CustCollectionLetterCodeDesc

GO


