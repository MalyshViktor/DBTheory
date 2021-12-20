--Имя сотрудника - фамилия (Имена по алфавиту)
SELECT
	M.Name AS N,					 
	M.Surname ,
		CONCAT (M.Name, ' ', M.Surname)		 
	[Имя, Фамилия]					 
FROM
	Managers AS M
ORDER BY
 Name