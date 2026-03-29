# Write your MySQL query statement below
with t as 
        (Select customer_number,
count(*) over (partition by customer_number) as `numberCust`
from Orders) 
Select distinct(t.customer_number) from t
where t.numberCust = (Select MAX(t.numberCust) from t)
