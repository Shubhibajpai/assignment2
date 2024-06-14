-- Table creation syntax for Products
CREATE TABLE Products (
    ProductID int PRIMARY KEY,
    ProductName varchar(100),
    QuantityPerUnit varchar(100),
    UnitPrice decimal(10,2),
    SupplierID int,
    CategoryID int,
    Discontinued bit,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Table creation syntax for Suppliers
CREATE TABLE Suppliers (
    SupplierID int PRIMARY KEY,
    CompanyName varchar(100)
);

-- Table creation syntax for Categories
CREATE TABLE Categories (
    CategoryID int PRIMARY KEY,
    CategoryName varchar(100)
);

-- Create the view Myproducts
CREATE VIEW Myproducts AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.QuantityPerUnit,
    p.UnitPrice,
    s.CompanyName,
    c.CategoryName
FROM 
    Products p
    JOIN Suppliers s ON p.SupplierID = s.SupplierID
    JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE 
    p.Discontinued = 0;

-- Sample data insertion for Suppliers and Categories tables
INSERT INTO Suppliers (SupplierID, CompanyName) VALUES
(1, 'Supplier A'),
(2, 'Supplier B');

INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Category X'),
(2, 'Category Y');

-- Sample data insertion for Products table
INSERT INTO Products (ProductID, ProductName, QuantityPerUnit, UnitPrice, SupplierID, CategoryID, Discontinued) VALUES
(101, 'Product 1', '10 units per box', 20.00, 1, 1, 0),
(102, 'Product 2', '5 units per pack', 15.00, 2, 2, 1),
(103, 'Product 3', '20 units per case', 30.00, 1, 1, 0),
(104, 'Product 4', '50 units per carton', 25.00, 2, 2, 0);

-- Select from Myproducts view to see its content
SELECT * FROM Myproducts;
