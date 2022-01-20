DECLARE @page INT
DECLARE @perpage INT

SET @page = 0 --считаем, что 1 - первая страница(не ноль)
SET @perpage = 1

SELECT
	*
FROM
(SELECT
	P.*
FROM
	Managers P
ORDER BY
	P.Id 
OFFSET @page ROWS
FETCH NEXT @perpage ROWS ONLY) AS Tmp