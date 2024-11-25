SELECT ProductID, Name, ListPrice FROM SalesLT.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM SalesLT.Product)

SELECT 
	SalesLT.SalesOrderDetail.ProductID, 
	Name, 
	ListPrice
FROM SalesLT.Product, SalesLT.SalesOrderDetail, SalesLT.SalesOrderHeader
WHERE 
	SalesLT.SalesOrderDetail.ProductID = SalesLT.Product.ProductID AND 
	SalesLT.SalesOrderDetail.SalesOrderID = SalesLT.SalesOrderHeader.SalesOrderID AND
	ListPrice > 100 AND TotalDue < 100

SELECT 
	ProductID, 
	Name, 
	StandardCost, 
	ListPrice, 
	(
		SELECT AVG(UnitPrice) FROM SalesLT.SalesOrderDetail 
		WHERE SalesLT.SalesOrderDetail.ProductID = SalesLT.Product.ProductID
	) AS AvgSellingPrice 
FROM SalesLT.Product

SELECT 
	ProductID, 
	Name, 
	StandardCost, 
	ListPrice, 
	(
		SELECT AVG(UnitPrice) FROM SalesLT.SalesOrderDetail 
		WHERE SalesLT.SalesOrderDetail.ProductID = SalesLT.Product.ProductID
	) AS AvgSellingPrice 
FROM SalesLT.Product
WHERE
	StandardCost > (SELECT AVG(UnitPrice) FROM SalesLT.SalesOrderDetail WHERE SalesLT.SalesOrderDetail.ProductID = SalesLT.Product.ProductID)