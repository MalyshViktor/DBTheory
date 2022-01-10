--Количество проданных молотков

SELECT
	N'Сегодня' AS [Day],
	COUNT (Cnt) AS [Total, Hammers]
FROM
	Sales AS S
WHERE
	S.Id_product= N'8FF90E21-DCDB-4D55-A557-7C6D57DBB029'
AND
	CAST(Moment AS DATE) = '2020-01-11'

UNION

SELECT
	N'Вчера' AS [Day],
	COUNT (Cnt)
FROM
	Sales AS S
WHERE
	S.Id_product= '8FF90E21-DCDB-4D55-A557-7C6D57DBB029'
AND
	CAST(Moment AS DATE) = DATEADD(DAY, -1, '2020-01-11')

--Сумма вырученная за продажи шуруповертов

SELECT
	N'Сегодня' AS [Day],
	SUM(S.Cnt * P.Price) AS [Screw gun, Money]
FROM
	Sales AS S
	JOIN Products P ON P.id = S.ID_product
WHERE
	S.Id_product = '870DA1A9-44F4-4018-B7FC-727A2058FAF0'
AND
	CAST(Moment AS DATE) = '2020-01-11'

UNION

SELECT
	N'Вчера' AS [Day],
	SUM(S.Cnt * P.Price)
FROM
	Sales AS S
	JOIN Products P ON P.id = S.ID_product
WHERE
	S.Id_product = '870DA1A9-44F4-4018-B7FC-727A2058FAF0'
AND
	CAST(Moment AS DATE) = DATEADD(DAY, -1, '2020-01-11')

--Количество чеков, оформленных Вороновым Александром
--Сумму, вырученную Вороновым Александром
SELECT
	N'Сегодня' AS [Day],
	COUNT(*) AS [Total, checks],
	SUM(S.Cnt * P.Price) AS [Total, Money]
FROM
	Sales AS S
	JOIN Managers M ON M.Id = S.ID_manager
	JOIN Products P ON P.Id = S.ID_product
WHERE
	M.Id = 'CDE086E1-D25C-4251-A234-10727818EE28'
AND
	CAST(Moment AS DATE) = '2020-01-11'

UNION

SELECT
	N'Вчера' AS [Day],
	COUNT(*),
	SUM(S.Cnt * P.Price)
FROM
	Sales AS S
	JOIN Managers M ON M.Id = S.ID_manager
	JOIN Products P ON P.Id = S.ID_product
WHERE
	M.Id = 'CDE086E1-D25C-4251-A234-10727818EE28'
AND
	CAST(Moment AS DATE) = DATEADD(DAY, -1, '2020-01-11')

--Количество товаров(штук), проданных сотрудниками отдела кадров, 
--в т.ч. совместителями

SELECT
	N'Сегодня' AS [Day],
	SUM (S.Cnt) AS [Total, Товары]
FROM
	Sales AS S
	JOIN Managers M ON M.Id = S.ID_manager
	JOIN Departments D ON D.Id = M.Id_main_dep
	LEFT JOIN Departments SD ON SD.Id = M.Id_sec_dep
WHERE
	(D.Id = 'D2469412-0E4B-46F7-80EC-8C522364D099'
OR
	SD.Id = 'D2469412-0E4B-46F7-80EC-8C522364D099')
AND
	CAST(Moment AS DATE) = '2020-01-11'

UNION

SELECT
	N'Вчера' AS [Day],
	SUM (S.Cnt) AS [Total, Товары]
FROM
	Sales AS S
	JOIN Managers M ON M.Id = S.ID_manager
	JOIN Departments D ON D.Id = M.Id_main_dep
	LEFT JOIN Departments SD ON SD.Id = M.Id_sec_dep
WHERE
	(D.Id = 'D2469412-0E4B-46F7-80EC-8C522364D099'
OR
	SD.Id = 'D2469412-0E4B-46F7-80EC-8C522364D099')
AND
	CAST(Moment AS DATE) = DATEADD(DAY, -1, '2020-01-11')

