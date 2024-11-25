SELECT ProductID, UPPER(Name) AS ProductName, FLOOR(ROUND(Weight, 0)) AS ApproxWeight FROM SalesLT.Product

SELECT 
	ProductID, 
	UPPER(Name) AS ProductName, 
	FLOOR(ROUND(Weight, 0)) AS ApproxWeight,
	YEAR(SellStartDate) AS SellStartYear,
	DATENAME(month, SellStartDate) AS SellStartMonth
FROM SalesLT.Product

SELECT 
	ProductID, 
	UPPER(Name) AS ProductName, 
	FLOOR(ROUND(Weight, 0)) AS ApproxWeight,
	YEAR(SellStartDate) AS SellStartYear,
	DATENAME(month, SellStartDate) AS SellStartMonth,
	RIGHT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product

SELECT 
	ProductID, 
	UPPER(Name) AS ProductName, 
	FLOOR(ROUND(Weight, 0)) AS ApproxWeight,
	YEAR(SellStartDate) AS SellStartYear,
	DATENAME(month, SellStartDate) AS SellStartMonth,
	RIGHT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product
WHERE ISNUMERIC(RIGHT(ProductNumber, 2)) = 1