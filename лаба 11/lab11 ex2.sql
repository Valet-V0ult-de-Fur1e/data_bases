DECLARE @SalesOrderID int = 71947
BEGIN TRY
	IF NOT EXISTS(
		SELECT * 
		FROM SalesLT.SalesOrderHeader 
		WHERE SalesOrderID = @SalesOrderID)
		BEGIN
			DECLARE @error_msg NVARCHAR(100);
			SET @error_msg = N'Заказ #' + CAST(@SalesOrderID AS NVARCHAR) + N' не существует';
			THROW 50001, @error_msg, 0
		END
	ELSE
		BEGIN
		--	SET XACT_ABORT ON;
			BEGIN TRANSACTION
				DELETE FROM SalesLT.SalesOrderDetail 
				WHERE SalesOrderID = @SalesOrderID;
				THROW 50002 ,N'Попытка прервать транзакцию: проверка статуса', 1;
				DELETE FROM SalesLT.SalesOrderHeader 
				WHERE SalesOrderID = @SalesOrderID;
			COMMIT TRANSACTION
		END
END TRY
BEGIN CATCH
--	IF @@TRANCOUNT > 0
--		BEGIN
--			ROLLBACK TRANSACTION;
--			THROW 50002 ,N'Попытка прервать транзакцию: успешно', 1;
--		END
--	IF (XACT_STATE()) = -1  
--		BEGIN  
--			PRINT 'The transaction is in an uncommittable state.' + ' Rolling back transaction.'  
--			ROLLBACK TRANSACTION
--		END;  
--    IF (XACT_STATE()) = 1  
--		BEGIN  
--			PRINT 'The transaction is committable.' + ' Committing transaction.'  
--			COMMIT TRANSACTION;     
--		END;  
	PRINT ERROR_MESSAGE();
END CATCH
