SELECT CompanyName, SalesOrderID, TotalDue FROM SalesLT.Customer 
	INNER JOIN SalesLT.SalesOrderHeader
	ON SalesLT.SalesOrderHeader.CustomerID = SalesLT.Customer.CustomerID

SELECT CompanyName, SalesOrderID, TotalDue, AddressLine1, AddressLine2, City, StateProvince, PostalCode, CountryRegion FROM SalesLT.Customer 
	INNER JOIN SalesLT.SalesOrderHeader
	ON SalesLT.SalesOrderHeader.CustomerID = SalesLT.Customer.CustomerID
	INNER JOIN SalesLT.CustomerAddress
	ON SalesLT.CustomerAddress.CustomerID = SalesLT.Customer.CustomerID
	INNER JOIN SalesLT.Address
	ON SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID
	WHERE AddressType = 'Main Office' AND AddressLine1 IS NOT NULL AND AddressLine2 IS NOT NULL