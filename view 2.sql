use lite;
-- Sample tables creation
CREATE TABLE Customers1 (
    CustomerID int PRIMARY KEY,
    CompanyName varchar(100)
);

CREATE TABLE Orders1 (
    OrderID int PRIMARY KEY,
    CustomerID int,
    OrderDate date,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Products1 (
    ProductID int PRIMARY KEY,
    ProductName varchar(100)
);

CREATE TABLE OrderDetails1 (
    OrderDetailID int PRIMARY KEY,
    OrderID int,
    ProductID int,
    Quantity int,
    UnitPrice decimal(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Sample data insertion
INSERT INTO Customers1 (CustomerID, CompanyName) VALUES
(1, 'Customer A'),
(2, 'Customer B');

-- Adjusted sample data insertion for yesterday's orders
INSERT INTO Orders1 (OrderID, CustomerID, OrderDate) VALUES
(101, 1, '2024-06-12'), -- yesterday's order for Customer A
(102, 2, '2024-03-12'), -- yesterday's order for Customer B
(103, 1, '2024-06-12'), -- order two days ago for Customer A
(104, 2, '2024-06-12'); -- order two days ago for Customer B

INSERT INTO Products1 (ProductID, ProductName) VALUES
(201, 'Product X'),
(202, 'Product Y');

INSERT INTO OrderDetails1 (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 101, 201, 5, 10.00),
(2, 101, 202, 3, 15.00),
(3, 102, 201, 2, 10.50),
(4, 103, 202, 4, 12.00),
(5, 104, 201, 3, 11.00);

-- View creation
CREATE VIEW CustomerOrders AS
SELECT 
    c.CompanyName,
    o.OrderID,
    o.OrderDate,
    od.ProductID,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    (od.Quantity * od.UnitPrice) AS TotalPrice
FROM 
    Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
WHERE 
    o.OrderDate = '12-06-2024'; -- Filter for orders placed yesterday
