use lite;
CREATE TABLE Customers (
    CustomerID int PRIMARY KEY,
    CompanyName varchar(100)
);

CREATE TABLE Orders (
    OrderID int PRIMARY KEY,
    CustomerID int,
    OrderDate date,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Products (
    ProductID int PRIMARY KEY,
    ProductName varchar(100)
);

CREATE TABLE OrderDetails (
    OrderDetailID int PRIMARY KEY,
    OrderID int,
    ProductID int,
    Quantity int,
    UnitPrice decimal(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

Sample data insertion
INSERT INTO Customers (CustomerID, CompanyName) VALUES
(1, 'Customer A'),
(2, 'Customer B');

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(101, 1, '2024-06-01'),
(102, 2, '2024-06-03');

INSERT INTO Products (ProductID, ProductName) VALUES
(201, 'Product X'),
(202, 'Product Y');

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 101, 201, 5, 10.00),
(2, 101, 202, 3, 15.00),
(3, 102, 201, 2, 10.50);

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
    JOIN Products p ON od.ProductID = p.ProductID;