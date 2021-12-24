--Продажи (все, *) за 22.12.2020 в календарном порядке
SELECT
	S.Id_manager,
	S.Id_product,
	S.Moment
	FROM
	Sales AS S
WHERE 
S.Moment = '2020-12-30'
ORDER BY
Moment