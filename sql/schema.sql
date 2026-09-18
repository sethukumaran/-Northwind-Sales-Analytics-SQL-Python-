
CREATE TABLE categories (
    CategoryID INTEGER PRIMARY KEY,
    CategoryName TEXT NOT NULL,
    Description TEXT
);

CREATE TABLE products (
    ProductID INTEGER PRIMARY KEY,
    ProductName TEXT NOT NULL,
    SupplierID INTEGER,
    CategoryID INTEGER,
    QuantityPerUnit TEXT,
    UnitPrice REAL,
    UnitsInStock INTEGER,
    UnitsOnOrder INTEGER,
    ReorderLevel INTEGER,
    Discontinued INTEGER
);

CREATE TABLE customers (
    CustomerID TEXT PRIMARY KEY,
    CompanyName TEXT,
    ContactName TEXT,
    City TEXT,
    Region TEXT,
    Country TEXT
);

CREATE TABLE orders (
    OrderID INTEGER PRIMARY KEY,
    CustomerID TEXT,
    EmployeeID INTEGER,
    OrderDate TEXT,
    RequiredDate TEXT,
    ShippedDate TEXT,
    ShipVia INTEGER,
    Freight REAL
);

CREATE TABLE order_details (
    OrderID INTEGER,
    ProductID INTEGER,
    UnitPrice REAL,
    Quantity INTEGER,
    Discount REAL,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);
