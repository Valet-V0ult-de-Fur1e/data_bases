INSERT INTO SalesLT.Product (
	Name, 
	ProductNumber, 
	StandardCost,
	ListPrice,
	ProductCategoryID,
	SellStartDate
	)
VALUES (
	'LED Lights',
	'LT-L123',
	2.56,
	12.99,
	37,
	GETDATE()
)

SELECT TOP 1 ProductID FROM SalesLT.Product
ORDER BY SellStartDate DESC

SELECT TOP 1 * FROM SalesLT.Product
ORDER BY SellStartDate DESC


INSERT INTO SalesLT.ProductCategory (
	Name,
	ParentProductCategoryID,
	ModifiedDate
)
VALUES (
	'Bells and Horns',
	4,
	GETDATE()
)

DECLARE @idNewCategory INT
SET @idNewCategory = 
	(SELECT TOP 1 ProductCategoryID 
	FROM SalesLT.ProductCategory
	WHERE Name = 'Bells and Horns')
SELECT @idNewCategory

INSERT INTO SalesLT.Product (
	Name, 
	ProductNumber, 
	StandardCost,
	ListPrice,
	ProductCategoryID,
	SellStartDate
	)
VALUES (
	'Bicycle Bell',
	'BB-RING',
	2.47,
	4.99,
	@idNewCategory,
	GETDATE()
	),
	(
	'Bicycle Horn',
	'BB-PARP',
	1.29,
	3.75,
	@idNewCategory,
	GETDATE()
	)

SELECT * 
FROM SalesLT.Product
WHERE ProductCategoryID = @idNewCategory
