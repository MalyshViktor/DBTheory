--количество продаж за "сегодня"
SELECT
	N'Сегодня' AS [Day],
	COUNT(*) AS [Total, checks], --количество продаж(чеков)
	SUM(Cnt) AS [Total, Pcs],	 --количество товаров(штук)
	SUM(S.Cnt * P.Price) AS [Total, Money],
	MAX(S.Cnt * P.Price) AS [Max, Money],
	MIN(S.Cnt * P.Price) AS [Min, Money],
	AVG(S.Cnt * P.Price) AS [Avg, Money]
FROM
	Sales S
	JOIN Products P ON P.id = S.ID_product
WHERE
	CAST(Moment AS DATE) = '2020-01-10'

UNION

SELECT
	N'Вчера',
	COUNT(*),
	SUM(Cnt),
	SUM(S.Cnt * P.Price),
	MAX(S.Cnt * P.Price),
	MIN(S.Cnt * P.Price),
	AVG(S.Cnt * P.Price)
FROM
	Sales S
	JOIN Products P ON P.id = S.ID_product
WHERE
	CAST(Moment AS DATE) = '2020-01-09'