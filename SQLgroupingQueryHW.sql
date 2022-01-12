--Наименование товара - кол-во продаж(шт)
SELECT
	P.Name,
	DailySales.Sales
	FROM
(SELECT
	S.ID_product,
	SUM(S.Cnt) [Sales]
FROM
	Sales S
WHERE
	CAST(S.Moment AS DATE) = '2020-01-12'
	AND CAST(S.Moment AS TIME) BETWEEN '10:00' AND '11:00'
GROUP BY
	S.ID_product
	) AS DailySales
	JOIN Products P ON P.Id = DailySales.ID_product

--ФИО  - кол-во чеков (для ВСЕХ сотрудников, 
--у кого нет продаж, указать прочерк)
SELECT
	CONCAT(M.Surname, ' ', M.Name) AS [FIO],
	COALESCE(CAST(Tmp.Checks AS CHAR), '-')
FROM
(SELECT
	S.ID_manager,
	COUNT(Cnt) [Checks]
FROM
	Sales S
WHERE
	CAST(S.Moment AS DATE) = '2020-01-12'
	AND CAST(S.Moment AS TIME) BETWEEN '10:00' AND '11:00'
GROUP BY
	S.ID_manager
	) AS Tmp
	RIGHT JOIN Managers AS M ON M.Id = Tmp.ID_manager
--Наименование товара - количество продаж (шт.) (для ВСЕХ ...)
SELECT
	P.Name,
	COALESCE(CAST(DailySales.Sales AS CHAR), '-')
	FROM
(SELECT
	S.ID_product,
	SUM(S.Cnt) [Sales]
FROM
	Sales S
WHERE
	CAST(S.Moment AS DATE) = '2020-01-12'
	AND CAST(S.Moment AS TIME) BETWEEN '10:00' AND '11:00'
GROUP BY
	S.ID_product
	) AS DailySales
	RIGHT JOIN Products P ON P.Id = DailySales.ID_product
--Три самых продаваемых товара
SELECT TOP 3
	P.Name,
	DailySales.Sales
	FROM
(SELECT
	S.ID_product,
	SUM(S.Cnt) [Sales]
FROM
	Sales S
WHERE
	CAST(S.Moment AS DATE) = '2020-01-12'
GROUP BY
	S.ID_product
	) AS DailySales
	JOIN Products P ON P.Id = DailySales.ID_product
ORDER BY
	2 DESC
--Пять лучших менеджеров(по продажам, деньги)
SELECT TOP 5
CONCAT(M.Surname, ' ', M.Name) [FIO],
Tmp.TotalMoney
FROM
(SELECT
	S.ID_manager,
	SUM(S.Cnt * P.Price) [TotalMoney]
FROM
	Sales S
	JOIN Products AS P ON P.Id = S.ID_product
WHERE
	CAST(S.Moment AS DATE) = '2020-01-12'
GROUP BY
	S.ID_manager) AS Tmp
	JOIN Managers AS M ON M.Id = Tmp.ID_manager
ORDER BY
	2 DESC

--Название отдела - продажи (деньги)
SELECT
	D.Name,
	Tmp.TotalMoney
FROM
(SELECT
	M.Id_main_dep,
	SUM(S.Cnt * P.Price) [TotalMoney]
FROM
	Sales S
	JOIN Products AS P ON P.Id = S.ID_product
	JOIN Managers AS M ON M.Id = S.ID_manager
WHERE
	CAST(S.Moment AS DATE) = '2020-01-12'
GROUP BY
	M.Id_main_dep) AS Tmp
	JOIN Departments AS D ON D.Id = Tmp.Id_main_dep

	--Лучший отдел (по продажам)
SELECT TOP 1
	D.Name,
	Tmp.TotalMoney
FROM
(SELECT
	M.Id_main_dep,
	SUM(S.Cnt * P.Price) [TotalMoney]
FROM
	Sales S
	JOIN Products AS P ON P.Id = S.ID_product
	JOIN Managers AS M ON M.Id = S.ID_manager
WHERE
	CAST(S.Moment AS DATE) = '2020-01-12'
GROUP BY
	M.Id_main_dep) AS Tmp
	JOIN Departments AS D ON D.Id = Tmp.Id_main_dep
ORDER BY
	2 DESC