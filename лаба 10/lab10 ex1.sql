DECLARE 
	@orderDate DATE = GETDATE(),
	@dueDate DATE = GETDATE() + DAY(7),
	@customerId INT = 1,
	@orderID INT;
	
SET @orderID = NEXT VALUE FOR SalesLT.SalesOrderNumber;

INSERT INTO SalesLT.SalesOrderHeader (
	OrderDate, 
	DueDate, 
	CustomerID, 
	ShipMethod
)
VALUES (
	@orderDate, 
	@dueDate, 
	@customerId, 
	'CARGO TRANSPORT 5'
);

PRINT @orderID;

DECLARE
	--@orderID INT = 0,
	@productID INT = 760,
	@quantity INT = 1,
	@unitPrice MONEY = 782.99;

IF EXISTS( SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @orderID)
	BEGIN
		INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice)
		VALUES (@orderID, @quantity, @productID, @unitPrice)
	END
ELSE
	BEGIN
		PRINT 'Заказ не существует';
END