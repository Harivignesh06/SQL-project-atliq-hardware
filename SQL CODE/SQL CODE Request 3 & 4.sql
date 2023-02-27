# REQUEST 3

#Provide a report with all the unique product counts for each segment and sort them in descending order of product counts.

SELECT segment,COUNT(product) AS product_count
FROM dim_product
GROUP BY segment 
ORDER BY product_count DESC;

# REQUEST 4

#Follow-up: Which segment had the most increase in unique products in 2021 vs 2020?

WITH A AS(SELECT segment,COUNT(DISTINCT product_code) AS product_count_2020
FROM dim_product
JOIN fact_gross_price gp
USING (product_code)
WHERE fiscal_year= 2020
GROUP BY segment
ORDER BY COUNT(DISTINCT product_code) desc),
B AS(SELECT segment,COUNT(DISTINCT product_code) AS product_count_2021
FROM dim_product
JOIN fact_gross_price gp
USING (product_code)
WHERE fiscal_year= 2021
GROUP BY segment
ORDER BY COUNT(DISTINCT product_code) desc)

SELECT *,(product_count_2021-product_count_2020) AS Difference,
ROUND(((product_count_2021-product_count_2020)/product_count_2020)*100,1) AS Difference_percentage
FROM A
JOIN B
USING (segment)
ORDER BY Difference_percentage DESC;