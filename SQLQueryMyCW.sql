--Количество проданных молотков
/*
SELECT
	COUNT (Name) AS [Total, 'Молотки']
FROM
	Sales AS S
	JOIN Products P ON P.id = S.ID_product
WHERE
	Name = N'Молоток'
AND
	CAST(Moment AS DATE) = '2020-01-11'
*/
--Сумма вырученная за продажи шуруповертов
/*
SELECT
	SUM(S.Cnt * P.Price) AS [Total, Money]
FROM
	Sales AS S
	JOIN Products P ON P.id = S.ID_product
WHERE
	Name = N'Шуруповерт'
AND
	CAST(Moment AS DATE) = '2020-01-11'
*/
--Количество чеков, оформленных Вороновым Александром
/*
SELECT
	COUNT(*) AS [Total, checks]
FROM
	Sales AS S
	JOIN Managers M ON M.Id = S.ID_manager
WHERE
	Surname = N'Воронов'
AND
	CAST(Moment AS DATE) = '2020-01-11'
*/
--Сумму, вырученную Вороновым Александром
/*
SELECT
	SUM(S.Cnt * P.Price) AS [Total, Money]
FROM
	Sales AS S
	JOIN Products P ON P.Id = S.ID_product
	JOIN Managers M ON M.Id = S.ID_manager
WHERE
	M.Id = 'CDE086E1-D25C-4251-A234-10727818EE28'
AND
	CAST(Moment AS DATE) = '2020-01-11'
*/
--Количество товаров(штук), проданных сотрудниками отдела кадров, 
--в т.ч. совместителями
SELECT
	SUM (S.Cnt) AS [Total, Товары]
FROM
	Sales AS S
	JOIN Managers M ON M.Id = S.ID_manager
	JOIN Departments D ON D.Id = M.Id_main_dep
	JOIN Departments SD ON SD.Id = M.Id_sec_dep
WHERE
	CAST(Moment AS DATE) = '2020-01-11'
AND (
	D.Name = N'Отдел кадров' 
OR
	SD.Name = N'Отдел кадров')

