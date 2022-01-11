--Вывести за сегодня наименование товара - кол-во продаж(шт)

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

--все, из таблицы Products

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