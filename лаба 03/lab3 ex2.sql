SELECT CompanyName, FirstName, LastName, SalesOrderID, TotalDue FROM SalesLT.SalesOrderHeader
	FULL OUTER JOIN SalesLT.Customer
	ON SalesLT.SalesOrderHeader.CustomerID = SalesLT.Customer.CustomerID ORDER BY SalesOrderID DESC

SELECT SalesLT.Customer.CustomerID, CompanyName, FirstName, LastName, Phone FROM SalesLT.CustomerAddress
	FULL OUTER JOIN SalesLT.Customer ON SalesLT.CustomerAddress.CustomerID = SalesLT.Customer.CustomerID
	WHERE AddressID IS NULL

SELECT SalesLT.Customer.CustomerID, SalesLT.Product.ProductID FROM SalesLT.Product
	FULL OUTER JOIN SalesLT.SalesOrderDetail
	ON SalesLT.SalesOrderDetail.ProductID = SalesLT.Product.ProductID
	FULL OUTER JOIN SalesLT.SalesOrderHeader
	ON SalesLT.SalesOrderHeader.SalesOrderID = SalesLT.SalesOrderDetail.SalesOrderID
	FULL OUTER JOIN SalesLT.Customer
	ON SalesLT.SalesOrderHeader.CustomerID = SalesLT.Customer.CustomerID
	WHERE NOT (SalesLT.Customer.CustomerID IS NOT NULL AND SalesLT.SalesOrderDetail.ProductID IS NOT NULL)
