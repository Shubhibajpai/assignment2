CREATE PROCEDURE UpdateOrderDetails
    @OrderID INT,
    @ProductID INT,
    @UnitPrice DECIMAL(10, 2) = NULL,
    @Quantity INT = NULL,
    @Discount DECIMAL(5, 2) = NULL
AS
BEGIN
    DECLARE @OldQuantity INT
    DECLARE @Difference INT

    
    SELECT @OldQuantity = Quantity
    FROM OrderDetails
    WHERE OrderID = @OrderID AND ProductID = @ProductID

    
    IF @UnitPrice IS NOT NULL
    BEGIN
        UPDATE OrderDetails
        SET UnitPrice = @UnitPrice
        WHERE OrderID = @OrderID AND ProductID = @ProductID
    END

   
    IF @Quantity IS NOT NULL
    BEGIN
        
        SET @Difference = @Quantity - ISNULL(@OldQuantity, 0)

       
        UPDATE OrderDetails
        SET Quantity = @Quantity
        WHERE OrderID = @OrderID AND ProductID = @ProductID

        
        UPDATE Products
        SET UnitsInStock = UnitsInStock - @Difference
        WHERE ProductID = @ProductID
    END

    
    IF @Discount IS NOT NULL
    BEGIN
        UPDATE OrderDetails
        SET Discount = @Discount
        WHERE OrderID = @OrderID AND ProductID = @ProductID
    END
END
