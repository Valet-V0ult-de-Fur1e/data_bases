SELECT * FROM SalesLT.Customer

SELECT Title, FirstName, MiddleName, LastName, Suffix FROM SalesLT.Customer

SELECT SalesPerson, Title + ' ' + LastName as CustomerName,Phone  FROM SalesLT.Customer