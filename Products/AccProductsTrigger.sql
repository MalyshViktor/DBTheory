--Были ли изменения в прайсе
--1. Создаем таблицу - аккумулятор, хранящую данные
--об изменении таблицы Products
--CREATE TABLE AccProducts IsChanged INT)

--2. Ус танавливаем начальное значение - 0
--INSERT INTO AccProducts VALUES (0)

--3. Триггер, контролирующий изменения в таблице Products
CREATE TRIGGER 
	OnProductChange -- имя триггера
ON
	Products -- таблица, в которой возникают события
AFTER -- /instead of/ - до или после изменений(события)
	INSERT, DELETE, UPDATE -- контролируемые события
AS
BEGIN
	SET NOCOUNT ON
	--меняем в акумуляторе значение IsChanged
	UPDATE AccProducts SET IsChanged = 1

END