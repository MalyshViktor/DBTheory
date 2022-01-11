--ФИО - сотрудника, кол-во чеков, кол-во товаров
--Вариант 1
/*
SELECT
	S.ID_manager,
	MAX(CONCAT(M.Surname, ' ', M.Name)) AS [FIO],
	COUNT(S.Cnt) AS Checks,
	SUM(S.Cnt) AS Pcs
FROM
	Sales S
	JOIN Managers AS M ON M.Id = S.ID_manager 
WHERE
	CAST(S.Moment AS DATE) = '2020-01-12'
GROUP BY
	S.ID_manager
*/

--ФИО - сотрудника, кол-во чеков, кол-во товаров
--Вариант 2
--Плохой, объединяются однофамильцы, сравнение по вычисляемому полю
/*
SELECT
	CONCAT(M.Surname, ' ', M.Name) AS [FIO],
	COUNT(S.Cnt) AS Checks,
	SUM(S.Cnt) AS Pcs
FROM
	Sales S
	JOIN Managers AS M ON M.Id = S.ID_manager 
WHERE
	CAST(S.Moment AS DATE) = '2020-01-12'
GROUP BY
	CONCAT(M.Surname, ' ', M.Name)
*/
--ФИО - сотрудника, кол-во чеков, кол-во товаров
--Вариант 3 Сначала группируем Sale по id_manager, 
--затем обьединяем с менеджерами
--В варианте 1 сначала соединяются таблицы. затем группируются
--

SELECT 
	CONCAT(M.Surname, ' ', M.Name) AS [FIO],
	DailyStat.Checks [Checks],
	DailyStat.Pcs [Pcs]
FROM
(SELECT
	S.ID_manager,
	COUNT(S.Cnt) AS Checks,
	SUM(S.Cnt) AS Pcs
FROM
	Sales S
WHERE
	CAST(S.Moment AS DATE) = '2020-01-12'
GROUP BY
	S.ID_manager
	) AS DailyStat
	JOIN Managers M ON M.Id = DailyStat.ID_manager