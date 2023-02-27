# REQUEST 7

# Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month . This analysis helps to get an idea of low and high-performing months and take strategic decisions.

SELECT YEAR(date),MONTHNAME(date),ROUND(SUM(sold_quantity*gross_price)/10000,1) AS Gross_sales_amount
FROM gdb023.fact_sales_monthly AS fsm
JOIN fact_gross_price AS fgp
ON fgp.product_code=fsm.product_code
JOIN dim_customer AS c
ON c.customer_code=fsm.customer_code
WHERE customer = 'Atliq exclusive'
GROUP BY MONTHNAME(date),YEAR(date)
ORDER BY YEAR(date);


# REQUEST 8

#In which quarter of 2020, got the maximum total_sold_quantity?

SELECT 
	CASE WHEN MONTH(date) IN (9,10,11) THEN 'Q1'
		 WHEN MONTH(date) IN (12,1,2) THEN 'Q2'
         WHEN MONTH(date) IN (3,4,5) THEN 'Q3'
         ELSE 'Q4'
	END AS Quarters,
SUM(sold_quantity) AS Total_sold_quantity
from fact_sales_monthly
WHERE fiscal_year= 2020
GROUP BY Quarters
ORDER BY SUM(sold_quantity) DESC;