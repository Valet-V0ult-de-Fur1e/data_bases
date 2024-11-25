SELECT 
	p.ProductID, 
	p.Name AS ProductName, 
	v.Name AS ProductModel, 
	v.Summary
FROM SalesLT.Product p
JOIN SalesLT.vProductModelCatalogDescription v ON v.ProductModelID = p.ProductModelID
ORDER BY p.ProductID


DECLARE @ColorProduct TABLE (Color NVARCHAR(15))
INSERT INTO @ColorProduct (Color)

SELECT Color AS PCount 
FROM SalesLT.Product
GROUP BY Color
HAVING COUNT(Color) = 1
SELECT 
	ProductID, 
	Name AS ProductName,
	p.Color
FROM SalesLT.Product p
INNER JOIN @ColorProduct c
	ON p.Color = c.Color
ORDER BY Color

SELECT Size 
INTO #USizes
FROM SalesLT.Product
GROUP BY Size
HAVING COUNT(Size) = 1

SELECT ProductID,
	Name AS ProductName,
	p.Size
FROM SalesLT.Product p
JOIN #USizes 
	ON #USizes.Size = p.Size
ORDER BY Size DESC

SELECT p.ProductID,
	Name As ProductName,
	f.ParentProductCategoryName AS ParentCategory,
	f.ProductCategoryName AS Category
FROM SalesLT.Product p
JOIN dbo.ufnGetAllCategories() f
	ON f.ProductCategoryID = p.ProductCategoryID
ORDER BY Category, ParentCategory, ProductName