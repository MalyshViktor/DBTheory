--1.  Вывести сотрудников , у которых есть начальники
   --  сотрудник (Ф.И.О.) - начальник (Ф.И.О.)
/*
SELECT
	CONCAT(M.Name, ' ', M.Surname) [Менеджер],
	CONCAT(CM.Name, ' ', CM.Surname) [Начальник]
FROM
	Managers M
	JOIN Managers CM ON M.Id = CM.Id_chief
*/
--2.  Вывести сотрудников (Ф.И.О.), у которых нет начальников
/*
SELECT
	CONCAT(M.Name, ' ', M.Surname) [ФИО]
FROM
	Managers M
WHERE
	M.Id_chief  IS NULL
*/
--3.  Вывести начальников:
     --сотрудник (Ф.И.О.) - количество его прямых подчиненных
    -- (если нет подчиненных, то не включать в вывод)
/*
SELECT
	CONCAT(M.Name, ' ', M.Surname) [Начальник],
	CONCAT(CM.Name, ' ', CM.Surname) [Менеджер]
FROM
	Managers M
	LEFT JOIN Managers CM ON M.Id = CM.Id_chief
WHERE
	CM.Name IS NOT NULL
ORDER BY
1 DESC
*/
--4.  Вывести название отдела - количество сотрудников,
     --которые работают на основном месте 
	 /*
SELECT
	D.Name [Отдел],
	CONCAT(M.Name, ' ', M.Surname) [Менеджер]
FROM
	Departments D
	JOIN Managers M ON D.Id = M.Id_main_dep
ORDER BY
1
*/
--5.  Вывести название отдела - полное количество сотрудников,
   --  включая совместителей
/*
SELECT

	MAX(D.Name) [Отдел],
	COUNT(M.Name) [Менеджеров]
FROM
	Departments D,
	Managers M
WHERE
	M.Id_main_dep = D.Id
	OR
	M.Id_sec_dep = D.Id
GROUP BY
	D.Name
*/


--6.  Вывести 5 лучших по продаже товаров (в штуках)
  --  за первый квартал года (январь-февраль-март)
/*
SELECT TOP 5
	P.Name,
	Quart.Sales
	FROM
(SELECT
	S.ID_product,
	SUM(S.Cnt) [Sales]
FROM
	Sales S
WHERE
	CAST(S.Moment AS DATE) BETWEEN '2020-01-01' 
	AND '2020-03-01'
GROUP BY
	S.ID_product
	) AS Quart
	JOIN Products P ON P.Id = Quart.ID_product
ORDER BY
	2 DESC
	*/
--7.  Вывести товары, которые в январе продавались
--хуже среднего (суммы общих продаж в деньгах меньше,
--чем средняя сумма за месяц)
/*
SELECT
	SUM(S.Cnt) AS Pcs
FROM
	Sales S
WHERE
	MONTH(S.Moment) = 1
GROUP BY
	S.ID_product
HAVING SUM(S.Cnt) <
	(SELECT AVG(Tmp.Pcs) FROM
	(SELECT
		SUM(S.Cnt) AS Pcs
	FROM
		Sales S
	WHERE
	MONTH(S.Moment) = 1
	GROUP BY
		S.ID_product) AS Tmp)
*/
--8.  Вывести сотрудников, которые ничего не продавали
     --за определенный период ( с 10:00 до 11:00 "сегодня" )
/*
SELECT
	CONCAT(M.Name, ' ', M.Surname) AS Manager,
	COALESCE (Tmp.Pcs, 0) AS Pcs
FROM
	(SELECT
		M.Id,
		SUM(S.Cnt) AS Pcs
	FROM
		Sales S
		JOIN Managers M ON M.Id = S.ID_manager
	WHERE
		S.Moment BETWEEN '2020-01-21 10:00' 
		AND DateAdd(HOUR, 1, '2020-01-21 10:00' )
	GROUP BY
		M.Id
) AS Tmp
	RIGHT JOIN Managers M ON M.Id = Tmp.Id
WHERE 
	Tmp.Pcs IS NULL
*/


--9.  Определить какой товар продавался чаще всего (по
    -- количеству чеков). Если таких товаров несколько, 
    -- вывести все
/*
SELECT
	P.Name,
	COUNT(S.Cnt)/365 AS DailySales 
FROM
	Products P
	JOIN Sales S ON P.Id = S.ID_product
	GROUP BY
	P.Name
HAVING
	COUNT(S.Cnt)/365 = 
	(SELECT TOP 1
		COUNT(S.Cnt)/365
	FROM
		Products P
		JOIN Sales S ON P.Id = S.ID_product
	GROUP BY
		P.Id)
ORDER BY
	2 DESC
*/

--Вывести название отдела, в котором больше всего
     --совместителей. Если таких отделов несколько,
     --выводится первый по алфавиту
	 /*
SELECT
	D.Name,
	COUNT(M.Surname)
FROM
	Departments D
	JOIN Managers M ON M.Id_sec_dep = D.Id
GROUP BY
	D.Name
HAVING
	COUNT(M.Surname)/7 = 
	(SELECT TOP 1
		COUNT(M.Surname)/7
	FROM
		Departments D
		JOIN Managers M ON M.Id_main_dep = D.Id
	GROUP BY
		D.Id)
ORDER BY
	D.Name ASC
	*/

--11. Вывести помесячную статистику по отделу продаж:     
  --  номер месяца - сумма продаж
  /*
SELECT
	MONTH(S.Moment) [Номер месяца],
	SUM(S.Cnt * P.Price) [Сумма продаж]
FROM
	Sales S
	JOIN Products P ON P.Id = S.ID_product
	JOIN Managers M ON M.Id = S.ID_manager
	JOIN Departments D ON D.Id = M.Id_main_dep
	JOIN Departments SD ON SD.Id = M.Id_sec_dep
WHERE
	D.Id = '415B36D9-2D82-4A92-A313-48312F8E18C6'
GROUP BY
	MONTH(S.Moment)
ORDER BY
1 ASC
*/

--12. Вывести название отдела - сотрудников (Ф.И.О.),
     --сначала основных (по алфавиту), 
     --затем совместителей (по алфавиту) 
	 /*
SELECT
	*
FROM
(SELECT
	MAX(D.Name) [Dept],
	CONCAT(M.Surname, ' ', M.Name) [Mngr],
	'1' AS union_sort
FROM
	Departments D,
	Managers M
WHERE
	M.Id_main_dep = D.Id
GROUP BY
	CONCAT(M.Surname, ' ', M.Name)
UNION ALL

SELECT
	MAX(D.Name),
	CONCAT(M.Surname, ' ', M.Name),
	'2' 
FROM
	Departments D,
	Managers M
WHERE
	M.Id_sec_dep = D.Id
GROUP BY
	CONCAT(M.Surname, ' ', M.Name)) AS tmp

ORDER BY
tmp.union_sort
*/
