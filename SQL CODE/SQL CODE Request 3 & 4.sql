# REQUEST 3

SELECT segment,COUNT(DISTINCT product) AS product_count
FROM dim_product
GROUP BY segment 
ORDER BY product_count DESC;

# REQUEST 4

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
ORDER BY Difference_percentage DESC