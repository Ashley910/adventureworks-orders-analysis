# AdventureWorks Orders Analysis  
SQL project analyzing and cleaning customer order data from the AdventureWorks Sales tables.

## Overview  
This project focuses on exploring, validating, cleaning, and analyzing sales order data from the AdventureWorks database. It demonstrates a complete analyst workflow using SQL: data exploration, data quality checks, standardization, joining tables, and generating business insights.

## Dataset  
Tables used in this project:  
- Sales.SalesOrderHeader  
- Sales.SalesOrderDetail  
- Sales.SalesTerritory  
- Production.Product  

These tables contain order-level information, line-item details, territory data, and product metadata.

## Project Steps  
**1. Explore the tables**  
Preview the first 50 rows of SalesOrderHeader and SalesOrderDetail to understand structure and data patterns.

**2. Validate the data**  
Check for missing CustomerIDs, missing OrderDates, negative quantities, invalid prices, and inconsistent totals.

**3. Standardize fields**  
Clean OrderDate formats, trim and uppercase territory names, and trim and uppercase product names.

**4. Check for duplicates**  
Identify duplicate orders, duplicate order lines, and duplicate customers.

**5. Build cleaned orders view**  
Combine header and detail tables into a unified dataset with standardized fields.

**6. Join product and territory information**  
Add product names and territory names to enrich the cleaned dataset.

**7. Calculate revenue metrics**  
Compute order-level revenue using LineTotal.

**8. Territory revenue analysis**  
Calculate total revenue per territory and rank territories by performance.

**9. Product revenue analysis**  
Rank products by total revenue generated.

**10. Monthly revenue trend**  
Analyze monthly revenue to identify seasonality and sales patterns.

## Key Insights  
- Certain territories generate significantly higher revenue.  
- A small number of products account for a large share of total revenue.  
- Monthly revenue shows clear patterns that can inform forecasting.  

## How to Run  
1. Install SQL Server and SSMS.  
2. Restore the AdventureWorks sample database.  
3. Open the `orders_cleaning_queries.sql` file.  
4. Run each step sequentially in SSMS.  

## Purpose  
This project demonstrates SQL skills relevant to entry-level and junior data analyst roles, including data cleaning, validation, joining tables, and generating business insights.
