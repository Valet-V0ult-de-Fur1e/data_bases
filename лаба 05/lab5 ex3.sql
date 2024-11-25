SELECT Name, SUM(LineTotal) AS TotalRevenue FROM SalesLT.SalesOrderDetail, SalesLT.Product 
WHERE SalesLT.SalesOrderDetail.ProductID = SalesLT.Product.ProductID
GROUP BY Name
ORDER BY TotalRevenue DESC

SELECT Name, SUM(LineTotal) AS TotalRevenue FROM SalesLT.SalesOrderDetail, SalesLT.Product 
WHERE 
	SalesLT.SalesOrderDetail.ProductID = SalesLT.Product.ProductID AND
	UnitPrice > 1000
GROUP BY Name
ORDER BY TotalRevenue DESC

SELECT Name, SUM(LineTotal) AS TotalRevenue FROM SalesLT.SalesOrderDetail, SalesLT.Product 
WHERE SalesLT.SalesOrderDetail.ProductID = SalesLT.Product.ProductID
GROUP BY Name
HAVING SUM(LineTotal) > 20000
ORDER BY TotalRevenue DESC