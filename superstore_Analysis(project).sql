-- Answering specific business related questions on orders column to Super_store sales dataset.

SELECT * FROM sample_super_store.orders;

-- 1. Total sales of super store
SELECT SUM(Sales) AS Total_Sales
FROM Sample_super_store.orders;

-- 2. Total profit of super store
SELECT SUM(Profit) AS Total_Profit
FROM Sample_super_store.orders;

-- 3. The average discount given 
SELECT AVG(Discount) AS Average_Discount
FROM Sample_super_store.orders;

-- 4. Which category of products has the highest total sales?
SELECT Category, SUM(Sales) AS Total_Sales
FROM sample_super_store
GROUP BY Category
ORDER BY Total_Sales DESC
LIMIT 1;

-- 5. Which category of products has the highest average profit per unit sold?
SELECT Category, AVG(Profit/Quantity) AS Average_Profit_Per_Unit
FROM sample_super_store
GROUP BY Category
ORDER BY Average_Profit_Per_Unit DESC
LIMIT 1;

-- 6. What is the trend of total sales by year for each region?
SELECT Region, DATEPART(YEAR, Order_Date) AS Year, SUM(Sales) AS Total_Sales
FROM sample_super_store
GROUP BY Region, DATEPART(YEAR, Order_Date)
ORDER BY Region, Year;

-- 7. What is the average profit per unit sold for each sub-category of products?
SELECT Sub_Category, AVG(Profit/Quantity) AS Average_Profit_Per_Unit
FROM sample_super_store
GROUP BY Sub_Category;

-- 8. Which states have the highest number of orders?
SELECT State, COUNT(DISTINCT Order_ID) AS Num_Orders
FROM sample_super_store
GROUP BY State
ORDER BY Num_Orders DESC;

-- 9. What is the total sales and profit for each region and category of products?
SELECT Region, Category, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM sample_super_store
GROUP BY Region, Category;

-- 10. What is the percentage of sales and profit for each category of products for the dataset?
WITH Total_Sales_Profit AS (
  SELECT SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
  FROM sample_super_store
)
SELECT Category, SUM(Sales)/Total_Sales*100 AS Sales_Percentage, SUM(Profit)/Total_Profit*100 AS Profit_Percentage
FROM SampleSuperstore, Total_Sales_Profit
GROUP BY Category;

--  Window functions to analyze trends over time, such as month-over-month or year-over-year changes in sales.
-- 1. Month-over-Month Change in Sales
SELECT 
  DATEPART(YEAR, Order_Date) AS Year,
  DATEPART(MONTH, Order_Date) AS Month,
  SUM(Sales) AS Monthly_Sales,
  SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY DATEPART(YEAR, Order_Date), DATEPART(MONTH, Order_Date)) AS Monthly_Sales_Change
FROM sample_super_store
GROUP BY DATEPART(YEAR, Order_Date), DATEPART(MONTH, Order_Date)
ORDER BY DATEPART(YEAR, Order_Date), DATEPART(MONTH, Order_Date);

-- 2.Year-over-Year Change in Profit
SELECT 
  DATEPART(YEAR, Order_Date) AS Year,
  SUM(Profit) AS Annual_Profit,
  SUM(Profit) - LAG(SUM(Profit)) OVER (ORDER BY DATEPART(YEAR, Order_Date)) AS Annual_Profit_Change
FROM sample_super_store
GROUP BY DATEPART(YEAR, Order_Date)
ORDER BY DATEPART(YEAR, Order_Date);

-- 3.Cumulative Sales by Month
SELECT 
  DATEPART(YEAR, Order_Date) AS Year,
  DATEPART(MONTH, Order_Date) AS Month,
  SUM(Sales) AS Monthly_Sales,
  SUM(SUM(Sales)) OVER (ORDER BY DATEPART(YEAR, Order_Date), DATEPART(MONTH, Order_Date)) AS Cumulative_Sales
FROM sample_super_store
GROUP BY DATEPART(YEAR, Order_Date), DATEPART(MONTH, Order_Date)
ORDER BY DATEPART(YEAR, Order_Date), DATEPART(MONTH, Order_Date);

-- 4.Running Total Profit by Year
SELECT 
  DATEPART(YEAR, Order_Date) AS Year,
  SUM(Profit) AS Annual_Profit,
  SUM(SUM(Profit)) OVER (ORDER BY DATEPART(YEAR, Order_Date)) AS Cumulative_Profit
FROM sample_super_store
GROUP BY DATEPART(YEAR, Order_Date)
ORDER BY DATEPART(YEAR, Order_Date);

-- 5.Month-over-Month Change in Quantity Sold
SELECT 
  DATEPART(YEAR, Order_Date) AS Year,
  DATEPART(MONTH, Order_Date) AS Month,
  SUM(Quantity) AS Monthly_Quantity_Sold,
  SUM(Quantity) - LAG(SUM(Quantity)) OVER (ORDER BY DATEPART(YEAR, Order_Date), DATEPART(MONTH, Order_Date)) AS Monthly_Quantity_Sold_Change
FROM Sample_super_store
GROUP BY DATEPART(YEAR, Order_Date), DATEPART(MONTH, Order_Date)
ORDER BY DATEPART(YEAR, Order_Date), DATEPART(MONTH, Order_Date);



