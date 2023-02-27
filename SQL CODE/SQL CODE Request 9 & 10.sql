# REQUEST 9

# Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution?

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
FROM A;


# REQUEST 10

# Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021?

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
WHERE Rank_order<=3;













