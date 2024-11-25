GO
CREATE PROCEDURE SalesLT.uspFindStringInTable
	@schema sysname,
	@table sysname,
	@stringToFind nvarchar(2000)
AS
BEGIN
	DECLARE @sqlCommand NVARCHAR (1000)
	SET @sqlCommand = N'SELECT 
			COLUMN_NAME AS ColumnName, 
			DATA_TYPE AS Type
		FROM ' + DB_NAME() +'.INFORMATION_SCHEMA.COLUMNS
		WHERE 
			TABLE_NAME = @TableName_ AND
			DATA_TYPE IN (''char'', ''nchar'', ''varchar'', ''nvarchar'', ''text'', ''ntext'')'
	DECLARE @neededColums TABLE (ColumnName NVARCHAR(100), DataType NVARCHAR(20))
	INSERT INTO @neededColums EXECUTE sp_executesql @sqlCommand, N'@TableName_ NVARCHAR(100)', @TableName_ = @table
	DECLARE @Query nvarchar(1000) = 'SELECT * FROM ' + @schema + '.' + @table + ' WHERE 1<>1 '
	SELECT @Query += ' OR ' + ColumnName + ' LIKE ' + '''%' + @stringToFind + '%'''
	FROM @neededColums
	EXECUTE (@Query)

	DECLARE @Out INT = 0;
	DECLARE @Query2 nvarchar(1000) = 'SELECT @res = COUNT(*) FROM ' + @schema + '.' + @table + ' WHERE 1<>1 '
	SELECT @Query2 += ' OR ' + ColumnName + ' LIKE ' + '''%' + @stringToFind + '%'''
	FROM @neededColums
	EXECUTE sp_executesql @Query2, N'@res INT OUTPUT', @res = @Out OUTPUT
	RETURN @Out
END;

DECLARE @countLines INT;
EXECUTE @countLines = SalesLT.uspFindStringInTable 'SalesLT', 'Product', 'Bike'
PRINT @countLines

DECLARE 
	@selectedShema NVARCHAR (1000) = 'SalesLT',
	@selectedSubString NVARCHAR (2000) = 'Bike',
	@sqlCommand2 NVARCHAR (1000)
DECLARE	@neededTables TABLE (TableName NVARCHAR(100))
SET @sqlCommand2 = N'SELECT 
			TABLE_NAME AS TableName
		FROM ' + DB_NAME() +'.INFORMATION_SCHEMA.COLUMNS GROUP BY TABLE_NAME'
INSERT INTO @neededTables EXECUTE (@sqlCommand2)
DECLARE @TableName NVARCHAR(1000);
DECLARE c2 CURSOR LOCAL FAST_FORWARD
FOR 
	SELECT TableName FROM @neededTables
OPEN c2
WHILE (1=1)
BEGIN
	FETCH c2 INTO @TableName
	DECLARE @selectedCountLines INT;
	IF @@FETCH_STATUS <> 0 BREAK
	EXECUTE @selectedCountLines = SalesLT.uspFindStringInTable @selectedShema, @TableName, @selectedSubString
	IF @selectedCountLines > 0
		PRINT N'В таблице ' + @selectedShema + '.' + CAST(@TableName AS NVARCHAR(200)) + N' найдено строк: ' + CAST(@selectedCountLines AS NVARCHAR(200))
	ELSE
		PRINT N'В таблице ' + @selectedShema + '.' + CAST(@TableName AS NVARCHAR(200)) + N' не найдено строк совпадений'
END
CLOSE c2
DEALLOCATE c2

DROP PROCEDURE SalesLT.uspFindStringInTable