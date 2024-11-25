SELECT SalesOrderID, CustomerData.CustomerID, CustomerData.FirstName, CustomerData.LastName, TotalDue FROM SalesLT.SalesOrderHeader
	OUTER APPLY dbo.ufnGetCustomerInformation(SalesLT.SalesOrderHeader.CustomerID) AS CustomerData
ORDER BY SalesOrderID


SELECT CustomerData.CustomerID, CustomerData.FirstName, CustomerData.LastName, AddressLine1, City FROM SalesLT.Address, SalesLT.CustomerAddress
CROSS APPLY dbo.ufnGetCustomerInformation(SalesLT.CustomerAddress.CustomerID) AS CustomerData
WHERE SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID
ORDER BY CustomerID