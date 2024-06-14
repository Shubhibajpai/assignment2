CREATE PROCEDURE GetOrderDetails @OrderID INT
AS
BEGIN
    
    IF EXISTS (SELECT * FROM OrderDetails WHERE OrderID = @OrderID)
    BEGIN
        
        SELECT * FROM OrderDetails WHERE OrderID = @OrderID;
        RETURN 0;
    END
    ELSE
    BEGIN
        
        PRINT 'The OrderID ' + CAST(@OrderID AS VARCHAR(10)) + ' does not exist';
        RETURN 1;
    END
END