-- 1. Overall KPIs
SELECT COUNT(DISTINCT o.OrderID) AS total_orders,
       ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) AS revenue,
       ROUND(SUM(od.Quantity),0) AS units_sold,
       ROUND(AVG(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) AS avg_line_value
FROM orders o JOIN order_details od USING(OrderID);

-- 2. Revenue by year
SELECT strftime('%Y', o.OrderDate) AS year,
       ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) AS revenue
FROM orders o JOIN order_details od USING(OrderID)
GROUP BY year ORDER BY year;

-- 3. Revenue by category
SELECT c.CategoryName,
       ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) AS revenue
FROM order_details od
JOIN products p USING(ProductID)
JOIN categories c USING(CategoryID)
GROUP BY c.CategoryName ORDER BY revenue DESC;

-- 4. Top 10 products
SELECT p.ProductName,
       ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) AS revenue,
       SUM(od.Quantity) AS units_sold
FROM order_details od JOIN products p USING(ProductID)
GROUP BY p.ProductID, p.ProductName
ORDER BY revenue DESC LIMIT 10;

-- 5. Monthly revenue
SELECT strftime('%Y-%m', o.OrderDate) AS month,
       ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) AS revenue
FROM orders o JOIN order_details od USING(OrderID)
GROUP BY month ORDER BY month;

-- 6. Customer revenue and order frequency
SELECT c.CompanyName, COUNT(DISTINCT o.OrderID) AS orders,
       ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) AS revenue
FROM customers c JOIN orders o USING(CustomerID)
JOIN order_details od USING(OrderID)
GROUP BY c.CustomerID, c.CompanyName
ORDER BY revenue DESC LIMIT 10;

-- 7. Late shipments
SELECT COUNT(*) AS late_orders
FROM orders
WHERE ShippedDate IS NOT NULL AND RequiredDate IS NOT NULL
  AND date(ShippedDate) > date(RequiredDate);

-- 8. Discount impact
SELECT ROUND(AVG(Discount)*100,2) AS avg_discount_pct,
       ROUND(SUM(UnitPrice*Quantity*Discount),2) AS discount_value
FROM order_details;

-- 9. Inventory risk
SELECT ProductName, UnitsInStock, ReorderLevel, UnitsOnOrder
FROM products
WHERE UnitsInStock <= ReorderLevel AND Discontinued = 0
ORDER BY UnitsInStock;

-- 10. Revenue by customer country
SELECT c.Country,
       ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) AS revenue
FROM customers c JOIN orders o USING(CustomerID)
JOIN order_details od USING(OrderID)
GROUP BY c.Country ORDER BY revenue DESC;
