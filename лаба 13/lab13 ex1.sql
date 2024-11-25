DECLARE @priceDelta INT = 20;
DECLARE @findedIntrudersCount INT = 0;
SELECT @findedIntrudersCount = COUNT(*) FROM SalesLT.Product
JOIN (
	SELECT 
		ProductCategoryID,
		MIN(ListPrice) AS minPrice,
		MAX(ListPrice) AS maxPrice
	FROM SalesLT.Product 
	GROUP BY ProductCategoryID
	) AS ProductGroup
ON SalesLT.Product.ProductCategoryID = ProductGroup.ProductCategoryID
WHERE ListPrice * @priceDelta < maxPrice OR ListPrice > minPrice * @priceDelta
IF @findedIntrudersCount = 0 PRINT N'Правило 20-кратной разницы в цене соблюдено'
ELSE PRINT N'Правило 20-кратной разницы в цене нарушено у ' + CAST(@findedIntrudersCount AS NVARCHAR(100)) + N' товаров'

GO
CREATE TRIGGER SalesLT.TriggerProductListPriceRules ON SalesLT.Product 
AFTER INSERT 
AS
BEGIN
	DECLARE @priceDelta INT = 20;
	DECLARE insertedDataCursor CURSOR LOCAL FAST_FORWARD
	FOR SELECT ListPrice, ProductCategoryID FROM inserted
	OPEN insertedDataCursor
		WHILE (1=1)
			BEGIN
				BEGIN TRY
					DECLARE 
						@listPrice INT,
						@productCategoryID INT,
						@maxPriceCategory INT,
						@minPriceCategory INT;
					FETCH insertedDataCursor INTO @listPrice, @productCategoryID;
					IF @@FETCH_STATUS <> 0 BREAK
					SELECT
						@maxPriceCategory = MAX(ListPrice),
						@minPriceCategory = MIN(ListPrice)
					FROM SalesLT.Product
					WHERE @productCategoryID = ProductCategoryID
					IF @listPrice > @maxPriceCategory * @priceDelta OR @listPrice > @minPriceCategory * @priceDelta
						THROW 50001 ,N'Вносимые изменения нарушают правило 20-кратной разницы в цене товаров из одной рубрики (слишком дорого)', 1;
					IF @listPrice * @priceDelta < @maxPriceCategory OR @listPrice * @priceDelta < @minPriceCategory
						THROW 50001 ,N'Вносимые изменения нарушают правило 20-кратной разницы в цене товаров из одной рубрики (слишком дешево)', 1;
				END TRY
				BEGIN CATCH
					PRINT ERROR_MESSAGE();
				END CATCH
			END
END

--DROP TRIGGER SalesLT.TriggerProductListPriceRules

DECLARE 
	@selectedCategoryID INT = 5,
	@maxPrice INT,
	@minPrice INT
SELECT 
	@minPrice = MIN(ListPrice),
	@maxPrice = MAX(ListPrice)
FROM SalesLT.Product
WHERE 
	ProductCategoryID = @selectedCategoryID
PRINT N'Минимальная цена: ' + CAST(@minPrice AS NVARCHAR(100)) + N', максимальная цена: ' + CAST(@maxPrice AS NVARCHAR(100))



INSERT INTO SalesLT.Product (
	Name, 
	ProductNumber, 
	StandardCost,
	ListPrice, 
	ProductCategoryID,
	SellStartDate) 
VALUES 
--	('Tester lumen x20', 'FG-90', 50000, 41000, 5, GETDATE()),
	('Tester lumen x0.05', 'FG-20', 142, 10, 5, GETDATE())