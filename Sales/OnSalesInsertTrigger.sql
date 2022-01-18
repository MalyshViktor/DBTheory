--Аккумулятор продаж - итого за всю историю
--1. Создаем таблицу
--CREATE TABLE AccSales (TotalMoney INT, TotalPcs INT)

--2. Начальные значения
/*
INSERT INTO
	AccSales(TotalMoney, TotalPcs)
SELECT
	SUM(S.Cnt * P.Price),
	SUM(Cnt) 
FROM 
	Sales S
	JOIN Products AS P ON S.ID_Product = P.Id
*/

--3. Триггер
CREATE TRIGGER
	OnSalesInsert
ON
	Sales
AFTER
	INSERT

AS
BEGIN
	SET NOCOUNT ON
	DECLARE @c INT
	DECLARE @c2 INT
	SET @c +=@c2
	SET @c = (SELECT TotalPcs FROM AccSales)
	SET @c2 = (SELECT SUM(Cnt) FROM inserted)
	DECLARE @m INT
	DECLARE @m2 INT
	SET @m = (SELECT TotalMoney FROM AccSales)
	SET @m2 = (SELECT SUM(I.Cnt * P.Price) FROM inserted I JOIN Products P ON I.ID_product = P.Id)
	SET @m += @m2
	UPDATE AccSales SET TotalPcs = @c, TotalMoney = @m
END