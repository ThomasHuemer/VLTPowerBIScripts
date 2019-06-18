USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_PIM_INVENTTABLEDELTA]    Script Date: 03.08.2018 11:25:28 ******/
IF EXISTS (
		SELECT 1
		FROM sys.VIEWS
		WHERE NAME = 'VLT_DB_PIM_INVENTTABLEDELTA'
			AND type = 'V'
	)
	DROP VIEW [dbo].[VLT_DB_PIM_INVENTTABLEDELTA]
GO

/****** Object:  View [dbo].[VLT_DB_PIM_INVENTTABLEDELTA]    Script Date: 03.08.2018 11:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VLT_DB_PIM_INVENTTABLEDELTA]
AS
	SELECT [string]
	FROM [VMVALMAR01].[PerfionProd].[dbo].[SpecsAllView] AS Specs
	JOIN [VMVALMAR01].[PerfionProd].[dbo].Items AS Items ON (Specs.ITEMID = Items.id)
	WHERE NOT EXISTS (
			SELECT AXInventTable.ITEMID
			FROM VLT_AX500105_P.dbo.VLT_PIM_INVENTTABLE AS AXInventTable
			WHERE AXInventTable.ITEMID = Specs.string
		)
		AND Specs.SpecType = 2
		AND Specs.Language = 'DE'
		--AND Items.ParentId = 0
		AND Items.BaseType = 100

GO


