--All from Pizza Table
SELECT * FROM pizza_sales;

--Total number of Revenue
SELECT SUM(total_price) AS Total_Revenue
 FROM pizza_sales 

--To calculate average order per sales
SELECT SUM(total_price) / COUNT(Distinct order_id) AS avergare_order_value
FROM pizza_sales

--Total Pizza sold
SELECT SUM(quantity) AS total_pizza_sold
FROM pizza_sales

-- Total number of orders places
SELECT COUNT(distinct order_id) AS total_order_placed 
FROM pizza_sales

--  Avergage pizzas per order
SELECT CAST(CAST(SUM(quantity)  AS decimal(10,2))  /
CAST(COUNT(DISTINCT order_id) AS decimal(10,2))  AS decimal (10, 2))AS average_pizza_per_order
FROM pizza_sales

--Daily trend of total Orders
SELECT DATENAME(DW, order_date) AS order_day,
COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date) 


--Hourly Trend for Total Orders
SELECT DATEPART(hour, order_time) AS order_hours,
COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATEPART(hour, order_time)
ORDER BY DATEPART(hour, order_time)

--Percentage of sales by Pizza Category
SELECT Distinct pizza_category, SUM(total_price) AS total_sales,
SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS Percentage_sales
from pizza_sales
GROUP BY pizza_category

--percentage of sales by Pizza Category by Month of January
SELECT Distinct pizza_category, SUM(total_price) AS total_sales,
SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales WHERE MONTH(order_date) = 1) AS PCT
from pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

--percentage of sales by size
SELECT pizza_size, CAST(SUM(total_price) AS decimal(10, 2)) AS total_sales,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS decimal(10, 2))AS PCT
from pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC

--percentage of sales by quarter
SELECT pizza_size, CAST(SUM(total_price) AS decimal(10, 2)) AS total_sales,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales WHERE DATEPART(quarter, order_date) = 1) AS decimal(10, 2))AS PCT
from pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC

--Total sale of pizza by category
SELECT pizza_category, sum(quantity) AS total_Pizza_sold
FROM pizza_sales
GROUP BY pizza_category

--Best 5 sellers
SELECT TOP 5 pizza_name, sum(quantity)
FROM pizza_sales
GROUP BY pizza_name
ORDER BY sum(quantity) DESC

--Worst 5 sellers
SELECT TOP 5 pizza_name, sum(quantity)
FROM pizza_sales
GROUP BY pizza_name
ORDER BY sum(quantity)