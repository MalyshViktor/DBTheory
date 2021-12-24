--Название отдела (по алфавиту) - ФИО сотрудника (по алф.)
SELECT
	D.Name,
	M.Name + ' ' + M.Surname + ' ' + M.Secname
FROM
	Departments D
	RIGHT JOIN Managers M ON M.Id_main_dep = D.Id

ORDER BY
D.Name,
M.Surname