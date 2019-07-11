USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_SALESLINE]    Script Date: 23.07.2018 10:30:07 ******/
IF EXISTS (
		SELECT 1
		FROM sys.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_NVCOMPLAINTTABLE'
			AND TYPE = 'V'
	)
	DROP VIEW [dbo].[VLT_DB_POWERBI_NVCOMPLAINTTABLE]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_NvCOMPLAINTTABLE]    Script Date: 23.07.2018 10:30:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VLT_DB_POWERBI_NVCOMPLAINTTABLE]
AS
	SELECT ComplaintTable.COMPLAINTID,
		   ComplaintTable.COMPLAINTCAUSEID,
		   ComplaintTable.SALESID,
		   ComplaintTable.DELIVERYMODEID,
		   ComplaintTable.SALESGROUP,
		   ComplaintTable.RESPONSIBLEUSERID AS 'Verantwortlicher',
		   ComplaintTable.PRODUCTNAME,
		   ComplaintTable.APPROVED,
		   ComplaintTable.APPROVEDBY,
		   ComplaintTable.APPROVEDDATE,
		   ComplaintTable.COMPLETE,
		   ComplaintTable.COMPLETEDATE,
		   ComplaintTable.ADMINCOSTAMT,
		   ComplaintTable.MATERIALCOSTAMT,
		   ComplaintTable.SUBMONTEURCOSTAMT,
		   ComplaintTable.MONTAGEID,
		   ComplaintTable.COMPLAINTID + ComplaintTable.DATAAREAID AS PKComplaintID,
		   ComplaintTable.SALESID + ComplaintTable.DATAAREAID AS FKSalesId,
		   ComplaintTable.SALESGROUP + ComplaintTable.DATAAREAID AS FKSalesGroup,
		   ComplaintTable.MONTAGEID + ComplaintTable.DATAAREAID AS FKMontageId
	FROM NVCOMPLAINTTABLE AS ComplaintTable

GO
