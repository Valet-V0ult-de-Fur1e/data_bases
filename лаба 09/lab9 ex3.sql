SELECT *
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.ProductCategory AS c
ON p.ProductCategoryID = c.ProductCategoryID
WHERE c.Name = 'Bells and Horns'

DELETE SalesLT.Product
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

SELECT TOP 1 ProductCategoryID 
	FROM SalesLT.ProductCategory
	WHERE Name = 'Bells and Horns'

DELETE SalesLT.ProductCategory
WHERE Name = 'Bells and Horns'

SELECT TOP 1 ProductCategoryID 
	FROM SalesLT.ProductCategory
	WHERE Name = 'Bells and Horns'

--DELETE SalesLT.Product
--WHERE Name = 'LED Lights'
--SELECT * FROM SalesLT.Product WHERE Name = 'LED Lights'