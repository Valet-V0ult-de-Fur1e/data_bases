SELECT 
	a.CountryRegion, 
	a.StateProvince, 
	SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
INNER JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
INNER JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
INNER JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY GROUPING SETS ((a.CountryRegion, a.StateProvince), a.CountryRegion)
ORDER BY a.CountryRegion, a.StateProvince;

SELECT 
	a.CountryRegion, 
	a.StateProvince, 
	SUM(soh.TotalDue) AS Revenue,
	CASE
	WHEN GROUPING_ID(a.CountryRegion, a.StateProvince) = 1 THEN a.CountryRegion + ' Subtotal'
    WHEN GROUPING_ID(a.CountryRegion, a.StateProvince) = 0 THEN a.StateProvince + ' Subtotal'
    END AS Level
FROM SalesLT.Address AS a
INNER JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
INNER JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
INNER JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY GROUPING SETS ((a.CountryRegion, a.StateProvince), a.CountryRegion)
ORDER BY a.CountryRegion, a.StateProvince;

SELECT 
	a.CountryRegion, 
	a.StateProvince,
	a.City,
	SUM(soh.TotalDue) AS CityRevenue,
	CASE
	WHEN GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 3 THEN a.CountryRegion + ' Subtotal'
    WHEN GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 1 THEN a.StateProvince + ' Subtotal'
	WHEN GROUPING_ID(a.CountryRegion, a.StateProvince, a.City) = 0 THEN a.City + ' Subtotal'
    END AS Level
FROM SalesLT.Address AS a
INNER JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
INNER JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
INNER JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY GROUPING SETS ((a.CountryRegion, a.StateProvince, a.City), (a.CountryRegion, a.StateProvince), a.CountryRegion)
ORDER BY a.CountryRegion, a.StateProvince, a.City;