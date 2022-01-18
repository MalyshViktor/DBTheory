--GetProductPage 2  -- вторая страница товаров (по 6 на странице)
/*
CREATE PROCEDURE

	GetProductPage2
AS
BEGIN
SET NOCOUNT ON
DECLARE @rw INT
SET @rw = 6
SELECT
	P.Name [ProdName],
	P.Price [ProdPrice]
FROM
	Products P
ORDER BY
	Id
OFFSET @rw ROWS
FETCH NEXT @rw ROWS ONLY
END
*/
--GetDailyChecksPage '2020-01-17', 5  -- 5-я страница чеков за 2020-01-17
-- * Реализовать варианты, принимающие также "размер страницы"
/*
ALTER PROCEDURE
	GetDailyChecksPage
AS
BEGIN

SET NOCOUNT ON

DECLARE @curDate DATE
SET @curDate = '2020-01-17'
DECLARE @p INT
SET @p = 5
DECLARE @p1 INT
SET @p1 = 5

SELECT
	Cnt [Checks]
FROM
	Sales S
WHERE
	CAST(Moment AS DATE) = @curDate
ORDER BY
	ID
OFFSET @p * (@p1-1) ROWS
FETCH NEXT @p ROWS ONLY

END
*/

--Товары по фрагменту названия
/*
DECLARE @f NVARCHAR(max)
SET @f = N'ро'

SELECT
	*
FROM
	Products P
WHERE
	Name LIKE CONCAT('%', N'ро', '%')
*/

--Сотрудник - искать и по имени, и по фамилии
/*
DECLARE @n NVARCHAR(max)
SET @n = N'ро'
DECLARE @s NVARCHAR(max) 

SELECT
	*
FROM
Managers M
WHERE
	Name LIKE CONCAT('%', N'к', '%')
AND Surname LIKE CONCAT('%', N'е', '%')
*/