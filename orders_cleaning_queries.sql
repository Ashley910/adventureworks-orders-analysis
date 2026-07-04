------------------------------------------------------------
-- STEP 1: Explore the Sales tables
------------------------------------------------------------

-- Explore SalesOrderHeader
SELECT TOP 50 *
FROM Sales.SalesOrderHeader;

-- Explore SalesOrderDetail
SELECT TOP 50 *
FROM Sales.SalesOrderDetail;
------------------------------------------------------------
-- STEP 2: Check for missing or invalid values
------------------------------------------------------------

-- Check for NULL CustomerID
SELECT *
FROM Sales.SalesOrderHeader
WHERE CustomerID IS NULL;

-- Check for NULL OrderDate
SELECT *
FROM Sales.SalesOrderHeader
WHERE OrderDate IS NULL;

-- Check for negative or zero quantities
SELECT *
FROM Sales.SalesOrderDetail
WHERE OrderQty <= 0;

-- Check for negative or zero unit prices
SELECT *
FROM Sales.SalesOrderDetail
WHERE UnitPrice <= 0;

-- Check for negative or zero line totals
SELECT *
FROM Sales.SalesOrderDetail
WHERE LineTotal <= 0;
------------------------------------------------------------
-- STEP 3: Standardize important fields
------------------------------------------------------------

-- Standardize OrderDate format (convert to YYYY-MM-DD)
SELECT 
    SalesOrderID,
    CONVERT(date, OrderDate) AS CleanOrderDate,
    CustomerID,
    TotalDue
FROM Sales.SalesOrderHeader;

-- Standardize Territory names (trim + uppercase)
SELECT 
    TerritoryID,
    UPPER(LTRIM(RTRIM(Name))) AS CleanTerritoryName
FROM Sales.SalesTerritory;

-- Standardize Product names (trim + uppercase)
SELECT 
    ProductID,
    UPPER(LTRIM(RTRIM(Name))) AS CleanProductName
FROM Production.Product;
------------------------------------------------------------
-- STEP 4: Check for duplicates
------------------------------------------------------------

-- Duplicate orders
SELECT SalesOrderID, COUNT(*) AS Cnt
FROM Sales.SalesOrderHeader
GROUP BY SalesOrderID
HAVING COUNT(*) > 1;

-- Duplicate order lines
SELECT SalesOrderID, ProductID, COUNT(*) AS Cnt
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID, ProductID
HAVING COUNT(*) > 1;

-- Duplicate customers
SELECT CustomerID, COUNT(*) AS Cnt
FROM Sales.Customer
GROUP BY CustomerID
HAVING COUNT(*) > 1;
------------------------------------------------------------
-- STEP 5: Build cleaned orders view
------------------------------------------------------------

SELECT 
    h.SalesOrderID,
    CONVERT(date, h.OrderDate) AS OrderDate,
    h.CustomerID,
    h.TerritoryID,
    d.ProductID,
    d.OrderQty,
    d.UnitPrice,
    d.LineTotal
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d
    ON h.SalesOrderID = d.SalesOrderID;
------------------------------------------------------------
-- STEP 6: Join cleaned data with product and territory info
------------------------------------------------------------

SELECT 
    h.SalesOrderID,
    CONVERT(date, h.OrderDate) AS OrderDate,
    h.CustomerID,
    t.Name AS TerritoryName,
    p.Name AS ProductName,
    d.OrderQty,
    d.UnitPrice,
    d.LineTotal
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d
    ON h.SalesOrderID = d.SalesOrderID
JOIN Sales.SalesTerritory t
    ON h.TerritoryID = t.TerritoryID
JOIN Production.Product p
    ON d.ProductID = p.ProductID;
------------------------------------------------------------
-- STEP 7: Calculate revenue metrics
------------------------------------------------------------

SELECT 
    h.SalesOrderID,
    CONVERT(date, h.OrderDate) AS OrderDate,
    h.CustomerID,
    SUM(d.LineTotal) AS OrderRevenue
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d
    ON h.SalesOrderID = d.SalesOrderID
GROUP BY h.SalesOrderID, h.OrderDate, h.CustomerID;
------------------------------------------------------------
-- STEP 8: Revenue by territory
------------------------------------------------------------

SELECT 
    t.Name AS TerritoryName,
    SUM(d.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d
    ON h.SalesOrderID = d.SalesOrderID
JOIN Sales.SalesTerritory t
    ON h.TerritoryID = t.TerritoryID
GROUP BY t.Name
ORDER BY TotalRevenue DESC;
------------------------------------------------------------
-- STEP 9: Top products by revenue
------------------------------------------------------------

SELECT 
    p.Name AS ProductName,
    SUM(d.LineTotal) AS ProductRevenue
FROM Sales.SalesOrderDetail d
JOIN Production.Product p
    ON d.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY ProductRevenue DESC;
------------------------------------------------------------
-- STEP 10: Monthly revenue trend
------------------------------------------------------------

SELECT 
    YEAR(h.OrderDate) AS OrderYear,
    MONTH(h.OrderDate) AS OrderMonth,
    SUM(d.LineTotal) AS MonthlyRevenue
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d
    ON h.SalesOrderID = d.SalesOrderID
GROUP BY YEAR(h.OrderDate), MONTH(h.OrderDate)
ORDER BY OrderYear, OrderMonth;
