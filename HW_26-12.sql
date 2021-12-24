--1) Название отдела(по алфавиту) - ФИО сотрудника(по алфавиту) 
/*
SELECT 
	D.Name,
	M.Name + ' ' + M.Surname + ' ' + M.Secname
FROM
	Managers M
	JOIN Departments D ON M.Id_main_dep = D.Id
ORDER BY
	1, 2
*/
-- 2) ФИО сотрудника (по алф.) - Название отдела(основной) - По совместительству
/*
SELECT
	M.Surname + ' ' + M.Name  + ' ' + M.Secname "Ф.И.О",
	D.Name [Основной],
	SD.Name [По совместительству]
FROM
	Managers AS M
	JOIN Departments D ON M.Id_main_dep = D.Id
	LEFT JOIN Departments SD ON M.Id_sec_dep = SD.Id
ORDER BY
	M.Surname
*/
--3)ФИО сотрудника (по алф.) - ФИО начальника (по Id_chief)
/*
SELECT
	M.Surname + ' ' + M.Name [ФИО Сотрудника],
	CH.Surname + ' ' + CH.Name [ФИО Начальника]
FROM
	Managers AS M
	JOIN Managers AS CH ON M.Id_chief = CH.Id
ORDER BY
M.Surname
*/

--4) ФИО начальника (по алф.) - ФИО подчиненного (по алф.)
/*
SELECT
	M.Surname + ' ' + M.Name "Начальник",
	CH.Surname + ' ' + CH.Name "Подчиненный"
	
FROM
	Managers AS M
	JOIN Managers CH ON  M.Id = CH.Id_chief
ORDER BY
1, 2
*/
--5) * все сотрудники - ФИО подчиненного (если нет, то "--")
/*
SELECT
	M.Surname + ' ' + M.Name "Сотрудник",
	COALESCE (S.Surname + ' ' + S.Name, '--') "Подчиненный"
FROM
	Managers AS M
	LEFT JOIN Managers S ON S.Id_chief = M.Id
	ORDER BY
	M.Surname
*/
--6) Продажи за 25.12:
--Время (последние сначала) - Название товара - штук
/*
SELECT
	S.Moment,
	P. Name,
	S.Cnt
FROM
	Sales AS S
	JOIN Products AS P ON P.Id = S.ID_product
WHERE
	S.Moment >= '2020-12-24' AND S.Moment <= '2020-12-24 23:59:59'
ORDER BY
Moment DESC
*/
--7) ФИО (по алфавиту) - название товара - штук
/*
SELECT
	M.Surname + ' ' + M.Name "ФИО",
	P.Name [Назвавние товара],
	S.Cnt [Количество]
FROM
	Sales AS S
	JOIN Products AS P ON S.ID_product = P.Id
	LEFT JOIN Managers M ON S.ID_manager = M.Id
ORDER BY
M.Surname
*/
--8)Время (по возрастанию) - сумма чека
/*
SELECT 
	S.Moment [Время],
	P.Name [Наименование],
	C.Price*S.Cnt [Сумма чека]
	
FROM
	Sales AS S
	JOIN Products AS P ON S.ID_product = P.Id
	JOIN Products AS C ON C.Price*S.Cnt = P.Price * S.Cnt
ORDER BY
Moment ASC
*/
--9)Название отдела (из которого менеджер) -  Название товара - штук
/*
SELECT
	D.Name [Департамент],
	P.Name [Название товара],
	S.Cnt [Штук]
FROM
	Sales AS S
	LEFT JOIN Products AS P ON S.Id_product = P.Id
	JOIN Managers AS M ON M.Id = S.ID_manager
	LEFT JOIN Departments D ON D.Id = M.Id_main_dep
ORDER BY
D.Name
*/
--10) Название отдела (из которого менеджер) -  Название товара - сумма чека
/*
SELECT
	D.Name [Департамент],
	P.Name [Название товара],
	S.Cnt*P.Price [Сумма чека]
FROM
	Sales AS S
	LEFT JOIN Products AS P ON S.Id_product = P.Id
	JOIN Managers AS M ON M.Id = S.ID_manager
	LEFT JOIN Departments D ON D.Id = M.Id_main_dep
*/