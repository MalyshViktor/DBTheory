--ФИО сотрудника (по алф) - Название отдела (основной) - По совместимости(подработка)
SELECT 
	M.Name + ' ' + M.Surname "ФИО",
	D.Name [отдел основной],
	SD.Name [Отдел по совместительству]
FROM
	Managers M
	JOIN Departments D ON M.Id_main_dep = D.Id
	LEFT JOIN Departments SD ON M.Id_sec_dep = SD.Id
ORDER BY
M.Surname