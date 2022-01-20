--Создать триггер, мониторящий удаление данных из Sales,
 --и обновляющий AccSales
--CREATE TABLE AccSales (TotalMoney INT, TotalPcs INT)

/*
DELETE FROM
	AccSales
WHERE
	AccSales.TotalPcs > 8
*/
/*
CREATE TRIGGER 
	OnProductDelete
ON
	Sales
AFTER
	DELETE
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @c INT
	DECLARE @c2 INT
	SET @c -=@c2
	SET @c = (SELECT TotalPcs FROM AccSales)
	SET @c2 = (SELECT SUM(Cnt) FROM deleted)
	DECLARE @m INT
	DECLARE @m2 INT
	SET @m = (SELECT TotalMoney FROM AccSales)
	SET @m2 = (SELECT SUM(I.Cnt * P.Price) FROM deleted I JOIN Products P ON I.ID_product = P.Id)
	SET @m -= @m2
	UPDATE AccSales SET TotalPcs = @c, TotalMoney = @m
END
*/

--Создать триггер, мониторящий ОБНОВЛЕНИЕ данных из Sales,
 --и обновляющий AccSales. В нем будут присутствовать
 --обе таблицы "inserted" и "deleted"
 /*
 CREATE TRIGGER 
	OnProductUpdate
ON
	Sales
AFTER
	DELETE, INSERT
AS
IF 	EXISTS (SELECT SUM(Cnt) FROM deleted)
BEGIN 
	SET NOCOUNT ON
	DECLARE @c INT
	DECLARE @c2 INT
	SET @c -=@c2
	SET @c = (SELECT TotalPcs FROM AccSales)
	SET @c2 = (SELECT SUM(Cnt) FROM deleted)
	DECLARE @m INT
	DECLARE @m2 INT
	SET @m = (SELECT TotalMoney FROM AccSales)
	SET @m2 = (SELECT SUM(I.Cnt * P.Price) FROM deleted I JOIN Products P ON I.ID_product = P.Id)
	SET @m -= @m2
	UPDATE AccSales SET TotalPcs = @c, TotalMoney = @m
END ELSE
BEGIN
	SET @c +=@c2
	SET @c = (SELECT TotalPcs FROM AccSales)
	SET @c2 = (SELECT SUM(Cnt) FROM inserted)
	SET @m = (SELECT TotalMoney FROM AccSales)
	SET @m2 = (SELECT SUM(I.Cnt * P.Price) FROM inserted I JOIN Products P ON I.ID_product = P.Id)
	SET @m += @m2
	UPDATE AccSales SET TotalPcs = @c, TotalMoney = @m
END
*/
