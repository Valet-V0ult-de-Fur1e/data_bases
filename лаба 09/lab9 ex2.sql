SELECT *
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.ProductCategory AS c
ON p.ProductCategoryID = c.ProductCategoryID
WHERE c.Name = 'Bells and Horns'

UPDATE SalesLT.Product
SET ListPrice = ProductsWithCategories.ListPrice * 0.5
FROM
(
	SELECT 
		p.ProductID,
		p.Name AS ProductName,
		c.Name AS CategoryName,
		ListPrice
	FROM SalesLT.Product AS p
	JOIN SalesLT.ProductCategory AS c
	ON p.ProductCategoryID = c.ProductCategoryID
) AS ProductsWithCategories
WHERE ProductsWithCategories.ProductID = SalesLT.Product.ProductID AND ProductsWithCategories.CategoryName = 'Bells and Horns'

SELECT *
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.ProductCategory AS c
ON p.ProductCategoryID = c.ProductCategoryID
WHERE c.Name = 'Bells and Horns'

SELECT *
FROM SalesLT.Product AS p
WHERE p.ProductCategoryID = 37

UPDATE SalesLT.Product
SET DiscontinuedDate = GETDATE()
WHERE ProductCategoryID = 37 AND SalesLT.Product.Name != 'LED Lights'

SELECT *
FROM SalesLT.Product AS p
WHERE p.ProductCategoryID = 37