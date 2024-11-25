SELECT CompanyName, AddressLine1, City, 'Billing' AS AddressType FROM SalesLT.Customer, SalesLT.CustomerAddress, SalesLT.Address
WHERE 
	SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID AND
	SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID AND
	AddressType = 'Main Office'

SELECT CompanyName, AddressLine1, City, 'Shipping' AS AddressType FROM SalesLT.Customer, SalesLT.CustomerAddress, SalesLT.Address
WHERE 
	SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID AND
	SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID AND
	AddressType = 'Shipping'


SELECT CompanyName, AddressLine1, City, 'Billing' AS AddressType FROM SalesLT.Customer, SalesLT.CustomerAddress, SalesLT.Address
WHERE 
	SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID AND
	SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID AND
	AddressType = 'Main Office'
UNION SELECT CompanyName, AddressLine1, City, 'Shipping' AS AddressType FROM SalesLT.Customer, SalesLT.CustomerAddress, SalesLT.Address
WHERE 
	SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID AND
	SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID AND
	AddressType = 'Shipping'