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

--Три самых худших товара
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
	2

--Вариант 2
SELECT TOP 3
	P.Name,
	DailySales.Sales
	FROM
	Products P

	JOIN (SELECT
	S.ID_product,
	SUM(S.Cnt) [Sales]
FROM
	Sales S
WHERE
	CAST(S.Moment AS DATE) = '2020-01-12'
GROUP BY
	S.ID_product
	) AS DailySales ON P.Id = DailySales.ID_product
ORDER BY
	2