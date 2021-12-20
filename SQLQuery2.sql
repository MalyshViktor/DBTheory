--INSERT INTO Literals(num_value) VALUES(10)
--INSERT INTO Literals(num_value, txt_value) VALUES(10, N'the text')
--INSERT INTO Literals(num_value, txt_value, moment) VALUES(30, 'the text 3', '2021-12-20 10:00')
--INSERT INTO Literals(num_value, txt_value, moment) VALUES(40, 'Это текст', NULL)
--INSERT INTO Literals(num_value, txt_value, moment) VALUES(40, N'Это текст', NULL)
/*UPDATE Literals
SET txt_value = N'Это текст'
WHERE ID = '53481F9C-086D-4C1E-9ADC-86B3BF8CC9F6'
*/
--DELETE FROM Literals WHERE moment IS NULL
--INSERT INTO Literals (num_value) VALUES(100100)
--INSERT INTO Literals (num_value, txt_value) VALUES (10500, N'Новый Текст')