DECLARE @SalesOrderID int = 1

IF NOT EXISTS(
		SELECT * 
		FROM SalesLT.SalesOrderHeader 
		WHERE SalesOrderID = @SalesOrderID)
	BEGIN
		DECLARE @error_msg1 NVARCHAR(100);
		SET @error_msg1 = N'Заказ #' + CAST(@SalesOrderID AS NVARCHAR) + N' не существует';
		THROW 50001, @error_msg1, 0
	END
ELSE
	BEGIN
		DELETE FROM SalesLT.SalesOrderDetail 
		WHERE SalesOrderID = @SalesOrderID;
		DELETE FROM SalesLT.SalesOrderHeader 
		WHERE SalesOrderID = @SalesOrderID;
	END


DECLARE @SalesOrderID1 int = 1
BEGIN TRY
	IF NOT EXISTS(
		SELECT * 
		FROM SalesLT.SalesOrderHeader 
		WHERE SalesOrderID = @SalesOrderID1)
		BEGIN
			DECLARE @error_msg NVARCHAR(100);
			SET @error_msg = N'Заказ #' + CAST(@SalesOrderID1 AS NVARCHAR) + N' не существует';
			THROW 50001, @error_msg, 0
		END
	ELSE
		BEGIN
			DELETE FROM SalesLT.SalesOrderDetail 
			WHERE SalesOrderID = @SalesOrderID1;
			DELETE FROM SalesLT.SalesOrderHeader 
			WHERE SalesOrderID = @SalesOrderID1;
		END
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE();
END CATCH
