DECLARE @today DATE

SET @today = '2020-01-14'

SELECT
	MIN(D.Name)[Департамент],
	SUM(S.Cnt * P.Price) [TotalMoney]
FROM
	Sales S
	JOIN Products AS P ON P.Id = S.ID_product
	JOIN Managers AS M ON M.Id = S.ID_manager
	JOIN Departments AS D ON D.Id = M.Id_main_dep
WHERE
	S.Moment BETWEEN  @today AND DATEADD(Day, 1, @today)
GROUP BY
	M.Id_main_dep	
HAVING
	SUM (P.Price * S.Cnt) <300000
	AND SUM (P.Price * S.Cnt)>100000
ORDER BY
2 DESC