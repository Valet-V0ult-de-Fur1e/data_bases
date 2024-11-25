SELECT Name, Color, Size FROM SalesLT.Product WHERE ProductModelID = 1

SELECT ProductNumber, Name FROM SalesLT.Product 
WHERE Color IN ('black', 'red', 'white') AND Size IN ('S', 'M') 

SELECT ProductNumber, Name, ListPrice FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-%'

SELECT ProductNumber, Name, ListPrice FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-[^R]%-[0-9][0-9]'