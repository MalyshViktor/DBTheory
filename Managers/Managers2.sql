--Сотрудников (ФИО), работающих не в бухгалтерии
SELECT 
	M.Name,
	M.Surname,
	M.Secname,
	CONCAT (M.Name, ' ',M.Surname, ' ', M.Secname)
FROM
	Managers AS M
WHERE
	M.Name != 'Бухгалтерия'