--Сотрудников (ФИО), работающих не в бухгалтерии
SELECT 
	M.Name + ' ' + M.Surname + ' ' + M.Secname "ФИО"

FROM
	Managers M
WHERE
M.Id_main_dep != '131EF84B-F06E-494B-848F-BB4BC0604266'
ORDER BY
M.Name  ASC;