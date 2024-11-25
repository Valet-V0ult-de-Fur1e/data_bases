RESTORE FILELISTONLY FROM DISK = 'C:\Users\EGOR\Desktop\misis\базы даных\прочее\AdventureWorksLT2017.bak';
RESTORE DATABASE AdventureWorksLT2017 FROM DISK = 'C:\Users\EGOR\Desktop\misis\базы даных\прочее\AdventureWorksLT2017.bak' WITH
MOVE 'AdventureWorksLT2012_Data' TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.STUDSERVER\MSSQL\DATA\AdventureWorksLT2012.mdf',
MOVE 'AdventureWorksLT2012_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL14.STUDSERVER\MSSQL\DATA\AdventureWorksLT2012_log.ldf';
