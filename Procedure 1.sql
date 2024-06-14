CREATE PROCEDURE InsertOrderDetails 
    @OrderID INT,
    @ProductID INT,
    @UnitPrice DECIMAL(10, 2) = NULL,
    @Quantity INT,
    @Discount DECIMAL(4, 2) = 0
AS
BEGIN
    SET NOCOUNT ON;

    
    DECLARE @ProductUnitPrice DECIMAL(10, 2);
    DECLARE @UnitsInStock INT;
    DECLARE @ReorderLevel INT;

    
    IF NOT EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
    BEGIN
        PRINT 'Failed to place the order. ProductID does not exist.';
        RETURN;
    END

    
    SELECT @ProductUnitPrice = UnitPrice,
           @UnitsInStock = UnitsInStock,
           @ReorderLevel = ReorderLevel
    FROM Products
    WHERE ProductID = @ProductID;

   
    IF @UnitPrice IS NULL
    BEGIN
        SET @UnitPrice = @ProductUnitPrice;
    END

    
    IF @Quantity > @UnitsInStock
    BEGIN
        PRINT 'Failed to place the order. Insufficient quantity in stock.';
        RETURN;
    END

    
    INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
    VALUES (@OrderID, @ProductID, @UnitPrice, @Quantity, @Discount);

    IF @@ROWCOUNT = 1
    BEGIN
        PRINT 'Order details inserted successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Failed to place the order. Please try again.';
        RETURN;
    END

    
    UPDATE Products
    SET UnitsInStock = UnitsInStock - @Quantity
    WHERE ProductID = @ProductID;

    
    IF @UnitsInStock - @Quantity < @ReorderLevel
    BEGIN
        PRINT 'Warning: Quantity in stock dropped below Reorder Level.';
    END
END
