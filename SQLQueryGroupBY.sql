--id - сотрудника, кол-во чеков. кол-во товаров
SELECT
	S.ID_manager,
	COUNT(S.Cnt) AS Checks,
	SUM(S.Cnt) AS Pcs
FROM
	Sales S
WHERE
	CAST(S.Moment AS DATE) = '2020-01-12'
GROUP BY
	S.ID_manager