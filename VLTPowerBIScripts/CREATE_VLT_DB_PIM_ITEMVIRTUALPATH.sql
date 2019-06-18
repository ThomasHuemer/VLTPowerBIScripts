USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_PIM_ItemVirtualPath]    Script Date: 10.08.2018 08:56:55 ******/
DROP VIEW [dbo].[VLT_DB_PIM_ITEMVIRTUALPATH]
GO

/****** Object:  View [dbo].[VLT_DB_PIM_ItemVirtualPath]    Script Date: 10.08.2018 08:56:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VLT_DB_PIM_ITEMVIRTUALPATH]
AS
	SELECT Specs.ItemID,
		   Specs.SpecType,
		   Specs.String AS ProduktEbene0,
		   ParSpecs.String AS Ebene1,
		   ParParSpecs.String AS Ebene2,
		   ParParParSpecs.String AS Ebene3,
		   CASE
			   WHEN ParParParSpecs.String IS NULL AND ParParSpecs.String IS NULL AND ParSpecs.String IS NULL THEN (Specs.String)
			   WHEN ParParParSpecs.String IS NULL AND ParParSpecs.String IS NULL THEN (ParSpecs.String + '|' + Specs.String)
			   WHEN ParParParSpecs.String IS NULL THEN (ParParSpecs.String + '|' + ParSpecs.String + '|' + Specs.String)
			   ELSE (ParParParSpecs.String + '|' + ParParSpecs.String + '|' + ParSpecs.String + '|' + Specs.String)
		   END AS VirtuellerProduktPfad

	FROM [VMVALMAR01].[PerfionProd].[dbo].[Specs] AS Specs
	LEFT JOIN [VMVALMAR01].[PerfionProd].[dbo].[Items] AS Items ON (Specs.ItemID = Items.ID)
	LEFT JOIN [VMVALMAR01].[PerfionProd].[dbo].[Specs] AS ParSpecs ON (Items.ParentID = ParSpecs.ItemID AND ParSpecs.SpecType = 2 AND Items.ParentID != 0)
	LEFT JOIN [VMVALMAR01].[PerfionProd].[dbo].[Items] AS ParParItems ON (ParSpecs.ItemID = ParParItems.ID)
	LEFT JOIN [VMVALMAR01].[PerfionProd].[dbo].[Specs] AS ParParSpecs ON (ParParItems.ParentID = ParparSpecs.ItemID AND ParParSpecs.SpecType = 2 AND ParParItems.ParentID != 0)
	LEFT JOIN [VMVALMAR01].[PerfionProd].[dbo].[Items] AS ParParParItems ON (ParParSpecs.ItemID = ParParParItems.ID)
	LEFT JOIN [VMVALMAR01].[PerfionProd].[dbo].[Specs] AS ParParParSpecs ON (ParParParItems.ParentID = ParParParSpecs.ItemID AND ParParParSpecs.SpecType = 2 AND ParParParItems.ParentID != 0)
	WHERE Specs.SpecType = 2
		AND Specs.Language = 'DE'
		AND Items.Brand = 0
		AND Items.BaseType = 100

GO


