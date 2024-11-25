SELECT CustomerID,
		SUM(TotalDue) AS Revenue
INTO #OrderInfo
FROM SalesLT.SalesOrderHeader
GROUP BY CustomerID

SELECT 
	'"' +CompanyName +' (' + FirstName + ' ' + LastName +')"' AS CompanyContact,
	o.Revenue
FROM SalesLT.Customer c
JOIN #OrderInfo o
	ON o.CustomerID = c.CustomerID
ORDER BY CompanyContact;


WITH OrderInfo AS 
(
	SELECT CustomerID,
		SUM(TotalDue) AS Revenue
	FROM SalesLT.SalesOrderHeader
	GROUP BY CustomerID
)

SELECT 
	'"' +CompanyName +' (' + FirstName + ' ' + LastName +')"' AS CompanyContact,
	o.Revenue
FROM SalesLT.Customer c
JOIN OrderInfo o
	ON o.CustomerID = c.CustomerID
ORDER BY CompanyContact