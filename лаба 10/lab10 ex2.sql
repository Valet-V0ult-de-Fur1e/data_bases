DECLARE 
	@average MONEY = 2000,
	@moneyLimit MONEY = 5000,
	@newAverageItemPrice INT,
	@newMaxItemPrice INT;

SELECT 
	@newAverageItemPrice = AVG(ListPrice),
	@newMaxItemPrice = MAX(ListPrice)
FROM SalesLT.Product
WHERE ProductCategoryID IN
	(
	SELECT DISTINCT ProductCategoryID
	FROM SalesLT.vGetAllCategories
	WHERE ParentProductCategoryName = 'Bikes'
	);
WHILE @newAverageItemPrice < @average
BEGIN
	UPDATE SalesLT.Product
	SET ListPrice = ListPrice * 1.1
	WHERE ProductCategoryID IN
	(
	SELECT DISTINCT ProductCategoryID
	FROM SalesLT.vGetAllCategories
	WHERE ParentProductCategoryName = 'Bikes'
	);
	SELECT
		@newAverageItemPrice = AVG(ListPrice),
		@newMaxItemPrice = MAX(ListPrice)
	FROM SalesLT.Product
	WHERE ProductCategoryID IN
		(
		SELECT DISTINCT ProductCategoryID
		FROM SalesLT.vGetAllCategories
		WHERE ParentProductCategoryName = 'Bikes'
		);

	IF @newMaxItemPrice >= @moneyLimit
		BREAK
	ELSE
		CONTINUE
END
PRINT '����� ������� ���� �� ���������' + CONVERT(VARCHAR, @newAverageItemPrice);
PRINT '����� ������������ ���� ����������' + CONVERT(VARCHAR, @newMaxItemPrice);
