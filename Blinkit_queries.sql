create database blinkit;
use blinkit;
-- Create the table structure
CREATE TABLE blinkit_sales (
    Item_Identifier VARCHAR(50),
    Item_Weight DECIMAL(10,2),
    Item_Fat_Content VARCHAR(20),
    Item_Visibility DECIMAL(10,5),
    Item_Type VARCHAR(50),
    Item_MRP DECIMAL(10,2),
    Outlet_Identifier VARCHAR(50),
    Outlet_Establishment_Year INT,
    Outlet_Size VARCHAR(20),
    Outlet_Location_Type VARCHAR(20),
    Outlet_Type VARCHAR(50),
    Item_Outlet_Sales DECIMAL(10,2),
    Estimated_Profit DECIMAL(10,2)
);

-- Execute this AFTER importing the CSV to verify the total rows
SELECT COUNT(*) AS Total_Rows_Imported 
FROM blinkit_sales;

-- Calculate overall business Key Performance Indicators
SELECT 
    SUM(Item_Outlet_Sales) AS Total_Sales,
    ROUND(AVG(Item_Outlet_Sales), 2) AS Average_Sales,
    SUM(Estimated_Profit) AS Total_Estimated_Profit,
    COUNT(Item_Identifier) AS Total_Items_Sold
FROM blinkit_sales;

-- Break down sales performance by item types
SELECT 
    Item_Type,
    COUNT(Item_Identifier) AS Number_of_Items_Sold,
    SUM(Item_Outlet_Sales) AS Total_Sales,
    ROUND(AVG(Item_MRP), 2) AS Average_MRP
FROM blinkit_sales
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

-- Calculate sales metrics based on customer fat content preference
SELECT 
    Item_Fat_Content,
    COUNT(Item_Identifier) AS Total_Products_Sold,
    SUM(Item_Outlet_Sales) AS Total_Sales,
    ROUND(SUM(Item_Outlet_Sales) * 100.0 / (SELECT SUM(Item_Outlet_Sales) FROM blinkit_sales), 2) AS Sales_Percentage
FROM blinkit_sales
GROUP BY Item_Fat_Content;

-- Rank store sizes within each city tier based on total revenue generated
SELECT 
    Outlet_Location_Type,
    Outlet_Size,
    SUM(Item_Outlet_Sales) AS Total_Outlet_Sales,
    RANK() OVER (PARTITION BY Outlet_Location_Type ORDER BY SUM(Item_Outlet_Sales) DESC) AS Location_Store_Rank
FROM blinkit_sales
GROUP BY Outlet_Location_Type, Outlet_Size;




