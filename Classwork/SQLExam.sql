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

