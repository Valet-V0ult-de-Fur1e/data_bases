SELECT FirstName + ' ' + ISNULL(MiddleName + ' ', '') + LastName AS CustomerName FROM SalesLT.Customer

SELECT CustomerID, IIF(EmailAddress IS NULL, Phone, EmailAddress) AS PrimaryContact FROM SalesLT.Customer

SELECT CustomerID, IIF(ShipDate IS NULL, 'Awaiting Shipment', 'Shipped') AS ShippingStatus FROM SalesLT.SalesOrderHeader
