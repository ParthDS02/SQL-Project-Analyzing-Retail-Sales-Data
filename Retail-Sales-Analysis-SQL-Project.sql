-- Retail Sales Analytics

create table retail_sales(

	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age	INT,
	category VARCHAR(15),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);

select count(*) from retail_sales;
--------------------------------------
SELECT * FROM retail_sales
where 
	transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or 
	customer_id is null
	or 
	gender is null
	or 
	age is null
	or 
	category is null
	or 
	quantiy is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or 
	total_sale is null;


----------------------------------------

delete from retail_sales
where
	transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or 
	customer_id is null
	or 
	gender is null
	or 
	age is null
	or 
	category is null
	or 
	quantiy is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or 
	total_sale is null;

----------------------------------------

--Data Exploration--

-- 1. how many sales we have

select count (*) total_sales from retail_sales;

---------
-- 2. Number of unique customers we have 

select count (distinct customer_id
) total_sales from retail_sales;

--------
--3. Unique category

select count (distinct category
) total_sales from retail_sales;

select distinct category
 total_sales from retail_sales;
--------


------------Data analysis / Business key issues-------------

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.

select category,
	sum(total_sale) as net_sale,
	count(*) as total_orders
from retail_sales
group by 1


-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > 1000

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
	category,
    gender,
	count(*) as total_transactions
from retail_sales
group by category, gender
order by 1


-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

-- 8. **Write a SQL query to find the top 5 customers based on the highest total sales **

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

-- 11. Write a SQL query to find the total sales for each category for each day, including days when there were no sales also provide.

WITH date_range AS (
    SELECT 
        GENERATE_SERIES(MIN(sale_date), MAX(sale_date), '1 day'::INTERVAL) AS sale_date
    FROM retail_sales
),
category_sales AS (
    SELECT 
        sale_date, 
        category, 
        SUM(total_sale) AS total_sales
    FROM retail_sales
    GROUP BY sale_date, category
)
SELECT 
    dr.sale_date, 
    cs.category, 
    COALESCE(cs.total_sales, 0) AS total_sales
FROM date_range dr
LEFT JOIN category_sales cs ON dr.sale_date = cs.sale_date
ORDER BY 1, 2

-- 12. Write a SQL query to retrieve the category that generated the highest average sales per transaction across all categories.

SELECT category, AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY category
ORDER BY AVG(total_sale) DESC
LIMIT 1;

-- 13. Write a SQL query to find customers who made purchases in consecutive months in 2022.

WITH customer_sales AS (
    SELECT 
        customer_id,
        EXTRACT(MONTH FROM sale_date) AS month,
        EXTRACT(YEAR FROM sale_date) AS year
    FROM retail_sales
    WHERE EXTRACT(YEAR FROM sale_date) = 2022
    GROUP BY customer_id, month, year
),
consecutive_purchases AS (
    SELECT 
        customer_id,
        month,
        LEAD(month) OVER (PARTITION BY customer_id ORDER BY month) AS next_month
    FROM customer_sales
)
SELECT DISTINCT customer_id
FROM consecutive_purchases
WHERE next_month = month + 1;

-- 14. Write a SQL query to retrieve the highest and lowest sale made by customers from each age group (age ranges: 18-25, 26-35, 36-45, 46+).

SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        ELSE '46+'
    END AS age_group,
    MAX(total_sale) AS max_sale,
    MIN(total_sale) AS min_sale
FROM retail_sales
GROUP BY age_group;

-- 15. Write a SQL query to find customers who have returned items (negative sale amounts) and list how many returns they've made.

SELECT customer_id, COUNT(*) AS total_returns
FROM retail_sales
WHERE total_sale < 0
GROUP BY customer_id
HAVING COUNT(*) > 0;


