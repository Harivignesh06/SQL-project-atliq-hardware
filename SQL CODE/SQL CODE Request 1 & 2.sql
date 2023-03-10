# REQUEST 1

# Provide the list of markets in which customer 'Atliq Exclusive' operates it's business in the APAC region
SELECT DISTINCT market,customer
FROM gdb023.dim_customer
WHERE customer = 'Atliq exclusive ' AND region = 'APAC';

# REQUEST 2

# What is the percentage of unique product increase in 2021 vs. 2020?

SELECT COUNT(DISTINCT CASE WHEN cost_year = 2020 THEN product_code END) AS unique_products_2020,
COUNT(DISTINCT CASE WHEN cost_year = 2021 THEN product_code END) AS unique_products_2021,
(COUNT(DISTINCT CASE WHEN cost_year = 2021 THEN product_code END)-COUNT(DISTINCT CASE WHEN cost_year = 2020 THEN product_code END))/
COUNT(DISTINCT CASE WHEN cost_year = 2020 THEN product_code END)*100 AS percentage_change
FROM fact_manufacturing_cost;

