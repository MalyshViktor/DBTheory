DECLARE @page INT
DECLARE @perpage INT

SET @page = 1 --считаем, что 1 - первая страница(не ноль)
SET @perpage = COUNT(*)

SELECT
	*
FROM
(SELECT
	P.*
FROM
	Managers P
ORDER BY
	P.Id 
OFFSET @perpage * (@page -1) ROWS
FETCH NEXT @perpage ROWS ONLY) AS Tmp