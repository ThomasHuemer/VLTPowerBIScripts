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
		WHERE NAME = 'VLT_DB_POWERBI_EMPLTABLE'
			AND TYPE = 'V'
	)
	DROP VIEW VLT_DB_POWERBI_EMPLTABLE;
GO

CREATE VIEW [DBO].[VLT_DB_POWERBI_EMPLTABLE]
AS
	SELECT EmplTable.VLT_POWERBIUSEREMAIL,
		   EmplTable.EMPLID,
		   EmplTable.TRAINING,
		   DirPartyTable.Name,
		   EmplTable.TCMShippingDriver,
		   EmplTable.EMPLID + EmplTable.DATAAREAID AS FKEmplId
	FROM dbo.EMPLTABLE AS EmplTable
	JOIN [dbo].[DIRPARTYTABLE] AS DirPartyTable ON (EmplTable.DataAreaID = DirPartyTable.DataAreaId AND EmplTable.PartyId = DirPartyTable.PartyId)
	WHERE EmplTable.DATAAREAID = '100'
GO

