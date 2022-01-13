SELECT
	*
FROM
(SELECT 
	P.*,
	ROW_NUMBER () OVER( ORDER BY Id DESC) AS r_num
FROM
	Products P
	) AS Tmp
WHERE
	r_num > 6
	AND
	r_num <= 12