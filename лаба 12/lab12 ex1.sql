DECLARE @DB NVARCHAR(100) = DB_NAME()
DECLARE @TableName NVARCHAR(100) = 'Product'
DECLARE @sqlCommand NVARCHAR (1000)
SET @sqlCommand = N'SELECT 
	COLUMN_NAME AS ColumnName, 
	DATA_TYPE AS Type
FROM ' + @DB +'.INFORMATION_SCHEMA.COLUMNS
WHERE 
	TABLE_NAME = @TableName_ AND
	DATA_TYPE IN (''char'', ''nchar'', ''varchar'', ''nvarchar'', ''text'', ''ntext'')'

EXECUTE sp_executesql @sqlCommand, N'@TableName_ NVARCHAR(100)', @TableName_ = @TableName


DECLARE @SerchedValue NVARCHAR(100) = 'Bike';
DECLARE @neededColums TABLE (ColumnName NVARCHAR(100), DataType NVARCHAR(20))
INSERT INTO @neededColums EXECUTE sp_executesql @sqlCommand, N'@TableName_ NVARCHAR(100)', @TableName_ = @TableName
DECLARE c1 CURSOR LOCAL FAST_FORWARD
FOR
	SELECT ColumnName FROM @neededColums
OPEN c1
	DECLARE @Query nvarchar(1000) = 'SELECT * FROM SalesLT.' + @TableName + ' WHERE 1<>1 '
	SELECT @Query += ' OR ' + ColumnName + ' LIKE ' + '''%' + @SerchedValue + '%'''
	FROM @neededColums
	PRINT @Query
	EXECUTE (@Query)
CLOSE c1
DEALLOCATE c1