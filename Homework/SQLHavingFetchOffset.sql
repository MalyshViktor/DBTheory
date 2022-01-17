--Вывести первую половину записей из таблицы (количество заранее не известно)

SELECT TOP 50 PERCENT
	P.*
FROM
	Products P
ORDER BY
	P.Id

--Вывести вторую половину записей из таблицы

SELECT TOP 50 PERCENT
	P.*
FROM
	Products P
ORDER BY
	P.Id DESC

--Вывести 3 самых дорогих товара, кроме самого дорогого из всех
SELECT
	*
FROM
(SELECT 
	P.*,
	ROW_NUMBER () OVER( ORDER BY Price DESC) AS r_num
FROM
	Products P
	) AS Tmp
WHERE
	r_num > 1
	AND
	r_num <= 4

--Вывести товары, которые за сегодня проданы больше, чем средний
 --уровень продаж.

DECLARE @today DATE

SET @today = '2020-01-15'

SELECT
	MIN(P.Name)[Товар],
	SUM(S.Cnt * P.Price) [TotalMoney]
FROM
	Sales S
	JOIN Products AS P ON P.Id = S.ID_product
WHERE
	S.Moment BETWEEN  @today AND DATEADD(Day, 1, @today)
GROUP BY
	P.Id	
HAVING
	SUM(P.Price * S.Cnt) > 
(SELECT
	AVG(S.Cnt * P.Price)
FROM
	Sales S
	JOIN Products P ON P.Id = S.ID_product)
ORDER BY
	2 DESC

--Вывести вторую тройку лидеров по продажам за сегодня (менеджеров)

SELECT
	MAX(CONCAT(M.Surname, ' ', M.Name)) [Manager],
	SUM(S.Cnt * P.Price) [Total]
FROM
	Sales AS S
	JOIN Managers M ON M.Id = S.ID_manager
	JOIN Products P ON P.Id = S.ID_product
WHERE
	S.Moment BETWEEN  @today AND DATEADD(Day, 1, @today)
GROUP BY
	M.Id
ORDER BY
	SUM(S.Cnt * P.Price) DESC
OFFSET 3 ROWS
FETCH NEXT 3 ROWS ONLY
