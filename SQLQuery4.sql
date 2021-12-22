--Название отдела(по алфавиту) - ФИО сотрудника(по алфавиту) 
SELECT 
	D.Name,
	M.Name + ' ' + M.Surname + ' ' + M.Secname
FROM
	Managers M
	JOIN Departments D ON M.Id_main_dep = D.Id
ORDER BY
1, 2

