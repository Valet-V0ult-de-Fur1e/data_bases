SELECT CompanyName FROM SalesLT.Customer, SalesLT.CustomerAddress, SalesLT.Address
WHERE 
	SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID AND
	SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID AND
	AddressType = 'Main Office'
EXCEPT SELECT CompanyName FROM SalesLT.Customer, SalesLT.CustomerAddress, SalesLT.Address
WHERE 
	SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID AND
	SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID AND
	AddressType = 'Shipping'

SELECT CompanyName FROM SalesLT.Customer, SalesLT.CustomerAddress, SalesLT.Address
WHERE 
	SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID AND
	SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID AND
	AddressType = 'Shipping'
INTERSECT SELECT CompanyName FROM SalesLT.Customer, SalesLT.CustomerAddress, SalesLT.Address
WHERE 
	SalesLT.Customer.CustomerID = SalesLT.CustomerAddress.CustomerID AND
	SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID AND
	AddressType = 'Main Office'