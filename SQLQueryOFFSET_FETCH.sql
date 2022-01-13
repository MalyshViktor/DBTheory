DECLARE @page INT
DECLARE @perpage INT

SET @page = 4 --считаем, что 1 - первая страница(не ноль)
SET @perpage = 6

SELECT
	P.*
FROM
	Managers P
ORDER BY
	P.Id
OFFSET @perpage * (@page -1) ROWS
FETCH NEXT @perpage ROWS ONLY