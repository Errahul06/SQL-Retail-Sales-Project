CREATE DATABASE Project;

USE Project

CREATE TABLE Retail_sales ( 
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,	
    customer_id INT,	
    gender VARCHAR(15),
    age INT,
    category VARCHAR(25),	
    quantity INT,	
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
-- DATA CLEANING 
SELECT * FROM Retail_sales 
WHERE 
     transactions_id IS NULL
     OR
     sale_date IS NULL
     OR
     sale_time IS NULL	
     OR
     customer_id IS NULL	
     OR
     gender IS NULL	
     OR
     age IS NULL	
     OR
     category IS NULL	
     OR
     quantity IS NULL	
     OR
     price_per_unit IS NULL	
     OR
     cogs IS NULL	
     OR
     total_sale IS NULL;

                                                             -- DATA EXPLORATION 

-- How  many sales we have 

SELECT COUNT(*) AS total_sale FROM Retail_sales;

-- How many unique customers we have 

SELECT COUNT(DISTINCT customer_id) FROM Retail_sales;

-- How many categories we have

SELECT COUNT(DISTINCT category) FROM Retail_sales;

-- Name of categories we have 

SELECT DISTINCT category FROM Retail_sales;

                                                               -- Exploraotry Data Analysys/ Business problems 

-- Retrieve all columns for sales made on '2022-11-05'

SELECT * 
FROM Retail_sales
WHERE sale_date = '2022-11-05'; 

-- Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT * 
FROM Retail_sales
WHERE category = 'clothing'
AND quantity >= 4
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- calculate the total sales (total_sale) for each category.

SELECT category, 
       SUM(total_sale) AS net_sale 
FROM Retail_sales 
GROUP BY category;

-- Find the average age of customers who purchased items from the 'Beauty' category.

SELECT AVG(age) AS average_age
FROM Retail_sales
WHERE category = 'Beauty';

-- Find all transactions where the total_sale is greater than 1000.

SELECT *
FROM 
Retail_sales
WHERE
total_sale > '1000';

-- find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
gender, 
category, 
COUNT(transactions_id) AS total_transactions
FROM 
Retail_sales
GROUP BY 
gender, 
category;

-- Calculate the average sale for each month. Find out best selling month in each year

SELECT 
    year,
    month,
    total_sales
FROM (
    SELECT 
        DATE_FORMAT(sale_date, '%Y') AS year,
        DATE_FORMAT(sale_date, '%m') AS month,
        SUM(total_sale) AS total_sales
    FROM 
        Retail_sales
    GROUP BY 
        DATE_FORMAT(sale_date, '%Y'), 
        DATE_FORMAT(sale_date, '%m')
) AS monthly_sales
WHERE 
    total_sales = (
        SELECT 
            MAX(total_sales)
        FROM (
            SELECT 
                DATE_FORMAT(sale_date, '%Y') AS year,
                DATE_FORMAT(sale_date, '%m') AS month,
                SUM(total_sale) AS total_sales
            FROM 
                Retail_sales
            GROUP BY 
                DATE_FORMAT(sale_date, '%Y'), 
                DATE_FORMAT(sale_date, '%m')
        ) AS yearly_sales
        WHERE yearly_sales.year = monthly_sales.year
    );

-- Find the top 5 customers based on the highest total sales

SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM 
    Retail_sales
GROUP BY 
    customer_id
ORDER BY 
    total_sales DESC
LIMIT 5;


                                                                                                                          -- END OF PROJECT-- 
        