
SELECT  distinct p.product_id, p.product_name
FROM product p join sales s
on p.product_id = s.product_id
WHERE s.sale_date BETWEEN '2019-01-01' AND '2019-03-31'
and p.product_id not in (
SELECT product_id
FROM Sales
WHERE sale_date >'2019-03-31'
)
and p.product_id not in (
SELECT product_id
FROM Sales
WHERE sale_date < '2019-01-01' 
)



