SELECT TOP 3
M.Name
	
FROM
(SELECT
	S.ID_manager,
	SUM(S.Cnt * P.Price)
FROM
	Sales S
WHERE
	CAST(S.Moment AS DATE) = '2020-01-12'
GROUP BY
	S.ID_manager) AS Tmp
	JOIN Managers AS M ON M.Id = Tmp.ID_manager
	JOIN Products AS P ON P.Id = S.Id_products
ORDER BY
	1