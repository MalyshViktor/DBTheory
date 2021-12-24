-- Департаменты, в названии которых есть буква "а"
SELECT
	D.Name
FROM
 Departments AS D
WHERE
 D.Name LIKE N'%а%'
 ORDER BY
 Name