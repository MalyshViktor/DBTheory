-- Товары по убыванию цены
SELECT
	P.Name,
	P.Price
FROM
	Products P
ORDER BY
Price DESC