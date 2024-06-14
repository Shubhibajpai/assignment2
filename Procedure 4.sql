CREATE PROCEDURE DeleteOrderDetails
    @OrderID int,
    @ProductID int
AS
BEGIN
    SET NOCOUNT ON;

    
    IF NOT EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
    BEGIN
        PRINT 'Invalid OrderID';
        RETURN -1; -- Return error code
    END

    IF NOT EXISTS (SELECT 1 FROM [Order Details] WHERE OrderID = @OrderID AND ProductID = @ProductID)
    BEGIN
        PRINT 'Product does not exist in the specified order.';
        RETURN -1; -- Return error code
    END

 
    DELETE FROM [Order Details] WHERE OrderID = @OrderID AND ProductID = @ProductID;

    PRINT 'Order Details deleted successfully.';
END
