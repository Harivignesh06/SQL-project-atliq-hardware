# REQUEST 5
SELECT p.product_code,p.product,mc.manufacturing_cost
FROM dim_product AS p
JOIN fact_manufacturing_cost AS mc
USING(product_code)
WHERE 
	manufacturing_cost IN (SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost WHERE cost_year = 2020) OR
	manufacturing_cost IN (SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost WHERE cost_year = 2020)
ORDER BY manufacturing_cost DESC;

SELECT p.product_code,p.product,mc.manufacturing_cost
FROM dim_product AS p
JOIN fact_manufacturing_cost AS mc
USING(product_code)
WHERE 
	manufacturing_cost IN (SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost WHERE cost_year = 2021) OR
	manufacturing_cost IN (SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost WHERE cost_year = 2021)
ORDER BY manufacturing_cost DESC;


# REQUEST 6

SELECT customer_code,customer,ROUND((AVG(pre_invoice_discount_pct))*100,2) AS Average_discount_percentage
FROM fact_pre_invoice_deductions
JOIN dim_customer
USING (customer_code)
WHERE fiscal_year = 2021 AND market = 'India'
GROUP BY customer_code,customer
ORDER BY Average_discount_percentage DESC
LIMIT 5;











