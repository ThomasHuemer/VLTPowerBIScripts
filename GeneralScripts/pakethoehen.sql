USE VLT_AX500105_P
GO

/*
KRA75PS -2
KRA80PS -2
KRA90PS -2
KRA93PS -2

KRA75PB -2
KRA80PB -2
KRA90PB -2
KRA93PB -2

KRA75SB
KRA80SB
KRA90SB
KRA93SB

KRA75
KRA80
KRA90
KRA93
*/

SELECT n.SYSTEM AS 'Raff System',
	'KRA75' AS 'Produkt',
	n.PROFILE AS 'Lamellenprofil',
	n.HEIGHTMAXCM * 10 AS 'bis Höhe (mm)',
	n.PACKETHEIGHT * 10 AS 'Pakethöhe (mm)',
	n.PARTHEIGHTUP * 10 AS 'Höhe UP-Blende/SChacht (mm) ',
	n.PARTHEIGHTSB * 10 AS 'Höhe Sichtblende (mm)',
	0 AS 'Abzug (mm)'
FROM NVBOMDOCUPACKETHEIGHT n
WHERE n.SYSTEM = 'KRA'
AND n.PROFILE = 75

SELECT n.SYSTEM AS 'Raff System',
	'KRA80' AS 'Produkt',
	n.PROFILE AS 'Lamellenprofil',
	n.HEIGHTMAXCM * 10 AS 'bis Höhe (mm)',
	n.PACKETHEIGHT * 10 AS 'Pakethöhe (mm)',
	n.PARTHEIGHTUP * 10 AS 'Höhe UP-Blende/SChacht (mm) ',
	n.PARTHEIGHTSB * 10 AS 'Höhe Sichtblende (mm)',
	0 AS 'Abzug (mm)'
FROM NVBOMDOCUPACKETHEIGHT n
WHERE n.SYSTEM = 'KRA'
AND n.PROFILE = 80

SELECT n.SYSTEM AS 'Raff System',
	'KRA90' AS 'Produkt',
	n.PROFILE AS 'Lamellenprofil',
	n.HEIGHTMAXCM * 10 AS 'bis Höhe (mm)',
	n.PACKETHEIGHT * 10 AS 'Pakethöhe (mm)',
	n.PARTHEIGHTUP * 10 AS 'Höhe UP-Blende/SChacht (mm) ',
	n.PARTHEIGHTSB * 10 AS 'Höhe Sichtblende (mm)',
	0 AS 'Abzug (mm)'
FROM NVBOMDOCUPACKETHEIGHT n
WHERE n.SYSTEM = 'KRA'
AND n.PROFILE = 90

SELECT n.SYSTEM AS 'Raff System',
	'KRA93' AS 'Produkt',
	n.PROFILE AS 'Lamellenprofil',
	n.HEIGHTMAXCM * 10 AS 'bis Höhe (mm)',
	n.PACKETHEIGHT * 10 AS 'Pakethöhe (mm)',
	n.PARTHEIGHTUP * 10 AS 'Höhe UP-Blende/SChacht (mm) ',
	n.PARTHEIGHTSB * 10 AS 'Höhe Sichtblende (mm)',
	0 AS 'Abzug (mm)'
FROM NVBOMDOCUPACKETHEIGHT n
WHERE n.SYSTEM = 'KRA'
AND n.PROFILE = 93