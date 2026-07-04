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
