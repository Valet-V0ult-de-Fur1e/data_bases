SELECT CompanyName, Accessories, Bikes, Clothing, Components 
FROM  (
	SELECT CompanyName, LineTotal, ParentProductCategoryName
	FROM  SalesLT.Customer AS Cus
	JOIN SalesLT.SalesOrderHeader AS OrdH
		ON OrdH.CustomerID = Cus.CustomerID
	JOIN SalesLT.SalesOrderDetail AS OrdD
		ON OrdD.SalesOrderID = OrdH.SalesOrderID
	JOIN SalesLT.Product AS Prod
		ON Prod.ProductID = OrdD.ProductID
	JOIN dbo.ufnGetAllCategories() AS Cat	
		ON Cat.ProductCategoryID = Prod.ProductCategoryID
) AS CompanyCategorySales
PIVOT(
	 SUM(LineTotal) FOR ParentProductCategoryName IN ([Accessories], [Bikes], [Clothing], [Components])
) AS PIVOTDATA