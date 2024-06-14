use lite;

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATETIME,
    CustomerID INT,
   
    CONSTRAINT FK_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
   
    CONSTRAINT FK_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


CREATE TRIGGER DeleteOrderTrigger
ON Orders
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    
    DELETE FROM OrderDetails
    WHERE OrderID IN (SELECT deleted.OrderID FROM deleted);

    
    DELETE FROM Orders
    WHERE OrderID IN (SELECT deleted.OrderID FROM deleted);
END;
