Project Overview

**Project Title:** Retail Sales Analysis
**Level:** Beginner
**Database:** 'Retail_Sales_DB'

This SQL project highlights key skills and techniques that data analysts use to explore, clean, and analyze retail sales data. It involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering business-driven questions using SQL queries. It's an ideal project for beginners looking to build a solid foundation in SQL and gain hands-on experience with retail data.

Objectives

1. **Database Setup:** Create and populate a retail sales database with the provided data.
2. **Data Cleaning:** Identify and remove records with missing or null values.
3. **Exploratory Data Analysis (EDA):** Understand the dataset through basic SQL queries.
4. **Business Analysis:** Use SQL to address specific business questions and derive insights from the sales data.

Project Structure
1. Database Setup

- **Database Creation:** Begin by creating a database.
- **Table Creation:** Set up a retail_sales table with columns for transaction ID, sale date, time, customer info, product category, and sales details.


```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

2. Data Exploration & Cleaning

- **Record Count:** Get the total number of records in the dataset.
- **Customer Count:** Find the number of unique customers.
- **Category Count:** Identify the different product categories.
- **Null Value Check:** Look for and remove any records with missing values.


```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

Findings

- **Customer Demographics:** Sales are spread across various age groups, with categories like Clothing and Beauty being popular.
- **High-Value Transactions:** Transactions with a total sale amount over 1000 indicate premium purchases.
- **Sales Trends:** Monthly analysis reveals seasonal sales peaks.
- **Customer Insights:** Top-spending customers and best-selling product categories are identified.

Conclusion

This project is a great introduction to SQL for data analysts, covering database setup, data cleaning, exploratory analysis, and answering business-related queries. The insights generated can inform strategic business decisions by revealing sales patterns, customer behavior, and product performance.

This project is part of my portfolio, showcasing essential SQL skills for data analyst roles. Feel free to reach out with any questions or feedback!

Thanks for visiting, and I look forward to connecting with you!
