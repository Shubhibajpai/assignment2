
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    UnitsInStock INT,
    
);


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    
    CONSTRAINT FK_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


CREATE TRIGGER InsertOrderDetailTrigger
ON OrderDetails
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ProductID INT, @Quantity INT;
    DECLARE @AvailableStock INT;

    
    DECLARE insert_cursor CURSOR FOR
    SELECT ProductID, Quantity FROM inserted;

    OPEN insert_cursor;
    FETCH NEXT FROM insert_cursor INTO @ProductID, @Quantity;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        
        SELECT @AvailableStock = UnitsInStock
        FROM Products
        WHERE ProductID = @ProductID;

        
        IF @AvailableStock >= @Quantity
        BEGIN
            
            UPDATE Products
            SET UnitsInStock = UnitsInStock - @Quantity
            WHERE ProductID = @ProductID;

            INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
            VALUES ((SELECT OrderID FROM inserted), @ProductID, @Quantity);
        END
        ELSE
        BEGIN
   
            RAISERROR('Insufficient stock for ProductID %d. Order refused.', 16, 1, @ProductID);
            ROLLBACK;
            RETURN;
        END;

        FETCH NEXT FROM insert_cursor INTO @ProductID, @Quantity;
    END;

    CLOSE insert_cursor;
    DEALLOCATE insert_cursor;
END;
