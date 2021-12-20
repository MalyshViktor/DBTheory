CREATE TABLE Literals(
id				 --имия поля
UNIQUEIDENTIFIER --тип данных
PRIMARY KEY		 --модификатор
DEFAULT NEWID(), --значение по умолчанию

num_value
INT				 --целое
NOT NULL,		 --NULL не разрешен

txt_value
NVARCHAR(128)	 --N - National (Unicode) 
NULL,			 --можно не писать, это по умолчанию

moment
DATETIME
DEFAULT CURRENT_TIMESTAMP	
);