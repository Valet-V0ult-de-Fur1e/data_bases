SELECT CAST(CustomerID as varchar) + ': ' + CompanyName AS CustomerCompany FROM SalesLT.Customer

SELECT SalesOrderNumber + ' (' + CAST(RevisionNumber as varchar) + ')' AS OrderRevision, FORMAT(OrderDate, 'yyyy.MM.dd') as OrderDate FROM SalesLT.SalesOrderHeader