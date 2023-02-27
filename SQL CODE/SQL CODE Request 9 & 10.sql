# REQUEST 9

WITH A AS (
SELECT channel,ROUND(SUM(gross_price*sold_quantity)/10000,1) AS Gross_sales_
FROM fact_gross_price AS fgp
JOIN fact_sales_monthly AS fsm
ON fsm.product_code = fgp.product_code
JOIN dim_customer AS c
ON c.customer_code= fsm.customer_code
WHERE fsm.fiscal_year=2021
GROUP BY channel )
SELECT *,ROUND(Gross_sales_*100/SUM(Gross_sales_)OVER(),2) AS Percentage
FROM A


# REQUEST 10

WITH A AS (SELECT division,p.product_code,product,SUM(sold_quantity),
DENSE_RANK() OVER (PARTITION BY division ORDER BY SUM(sold_quantity) DESC) AS Rank_order
FROM dim_product p
JOIN fact_sales_monthly
USING(product_code)
WHERE fiscal_year=2021
GROUP BY division,p.product_code,product
ORDER BY SUM(sold_quantity) DESC)
SELECT *
FROM A
WHERE Rank_order<=3













