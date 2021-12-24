--ФИО Сотрудника (по алф) - ФИО начальника (по ID_chief)
SELECT 
	M.Name + ' ' + M.Surname + '(' + D.Name + ')' AS [Сотрудник],
	Chief.Surname + ' ' + Chief.Name
	AS [Начальник],
	D.Name [Департамент],
	DC.Name [Департамент шефа]
FROM
	Managers M
	LEFT JOIN Managers Chief ON M.Id_chief = Chief.Id
	JOIN Departments D ON M.Id_main_dep = D.Id
	LEFT JOIN Departments DC ON Chief.Id_main_dep = DC.Id
