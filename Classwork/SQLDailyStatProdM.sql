ALTER PROC
	DailyStatProdM
	@Day DATETIME, --стартовый момент времени
	@Hours INT -- интервал времени, в течении которого нас интересует выборка
AS
BEGIN
SET NOCOUNT ON
SELECT
	P.Name,
	COALESCE (Tmp.Pcs, 0) AS Pcs
FROM
(SELECT
	S.ID_Product,
	SUM(S.Cnt) AS Pcs
FROM
	Sales S
WHERE
	S.Moment BETWEEN '2020-01-17 12:00' 
	AND DateAdd(HOUR, 3, '2020-01-17 12:00' )
GROUP BY
	S.ID_product) AS Tmp
	RIGHT JOIN Products P ON Tmp.ID_product = P.Id
END