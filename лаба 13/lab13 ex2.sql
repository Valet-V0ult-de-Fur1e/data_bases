GO
CREATE TRIGGER SalesLT.TriggerProduct ON SalesLT.Product
AFTER INSERT, UPDATE
AS
BEGIN
	IF (SELECT COUNT(*) FROM SalesLT.ProductCategory JOIN inserted ON SalesLT.ProductCategory.ProductCategoryID = inserted.ProductCategoryID) = 0 
		THROW 50002, N'Ошибка: попытка нарушения ссылочной целостности между таблицами Product и ProductCategory, транзакция отменена', 0
END

GO
CREATE TRIGGER SalesLT.TriggerProductCategory ON SalesLT.ProductCategory
AFTER DELETE
AS
BEGIN
	IF (SELECT COUNT(*) FROM SalesLT.Product JOIN deleted ON SalesLT.Product.ProductCategoryID = deleted.ProductCategoryID) > 0 
		THROW 50002, N'Ошибка: попытка нарушения ссылочной целостности между таблицами Product и ProductCategory, транзакция отменена', 1
END


ALTER TABLE SalesLT.Product NOCHECK CONSTRAINT FK_Product_ProductCategory_ProductCategoryID;


ALTER TABLE SalesLT.Product CHECK CONSTRAINT FK_Product_ProductCategory_ProductCategoryID;
DISABLE TRIGGER SalesLT.TriggerProduct ON SalesLT.Product; 
DISABLE TRIGGER SalesLT.TriggerProductCategory ON SalesLT.ProductCategory;

--DROP TRIGGER SalesLT.TriggerProduct
--DROP TRIGGER SalesLT.TriggerProductCategory

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
	-1,
	GETDATE()
)

DELETE SalesLT.ProductCategory
WHERE ProductCategoryID = 5
