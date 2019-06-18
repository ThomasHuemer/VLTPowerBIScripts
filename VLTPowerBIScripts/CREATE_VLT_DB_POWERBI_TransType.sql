USE [VLT_AX500105_P]
GO

/****** Object:  View [dbo].[VLT_DB_POWERBI_TransType]    Script Date: 29.05.2018 15:52:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (
		SELECT 1
		FROM SYS.VIEWS
		WHERE NAME = 'VLT_DB_POWERBI_TransType'
			AND TYPE = 'V'
	)
	DROP VIEW [VLT_DB_POWERBI_TransType];
GO

CREATE VIEW [DBO].[VLT_DB_POWERBI_TransType]
AS
SELECT 0 AS TransTypeKey,'Auftrag' AS TransTypeDesc
UNION SELECT 2 AS TransTypeKey,'Produktion' AS TransTypeDesc
UNION SELECT 3 AS TransTypeKey,'Bestellung' AS TransTypeDesc
UNION SELECT 4 AS TransTypeKey,'Buchung' AS TransTypeDesc
UNION SELECT 5 AS TransTypeKey,'Gewinn/Verlust' AS TransTypeDesc
UNION SELECT 6 AS TransTypeKey,'Umlagerung' AS TransTypeDesc
UNION SELECT 7 AS TransTypeKey,'Gewichteter Durchschnitt des Lagerabschlusses' AS TransTypeDesc
UNION SELECT 8 AS TransTypeKey,'Produktionsauftragsposition' AS TransTypeDesc
UNION SELECT 9 AS TransTypeKey,'Stücklistenposition' AS TransTypeDesc
UNION SELECT 10 AS TransTypeKey,'Stückliste' AS TransTypeDesc
UNION SELECT 11 AS TransTypeKey,'Abgangsauftrag' AS TransTypeDesc
UNION SELECT 12 AS TransTypeKey,'Projekt' AS TransTypeDesc
UNION SELECT 13 AS TransTypeKey,'Inventur' AS TransTypeDesc
UNION SELECT 14 AS TransTypeKey,'Palettentransport' AS TransTypeDesc
UNION SELECT 15 AS TransTypeKey,'Quarantäneauftrag' AS TransTypeDesc
UNION SELECT 16 AS TransTypeKey,'Veraltet' AS TransTypeDesc
UNION SELECT 20 AS TransTypeKey,'Anlagevermögen' AS TransTypeDesc
UNION SELECT 21 AS TransTypeKey,'Umlagerungsauftragslieferung' AS TransTypeDesc
UNION SELECT 22 AS TransTypeKey,'Umlagerungsauftragsempfang' AS TransTypeDesc
UNION SELECT 23 AS TransTypeKey,'Ausschuss in Umlagerungsauftrag' AS TransTypeDesc
UNION SELECT 24 AS TransTypeKey,'Angebot' AS TransTypeDesc
UNION SELECT 25 AS TransTypeKey,'Qualitätsprüfungsauftrag' AS TransTypeDesc
GO