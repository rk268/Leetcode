# Write your MySQL query statement below
Select employee_id, 
    case
    when mod(employee_id, 2) = 1 and name not like 'm%'then salary
    else 0
    end as bonus  
from Employees     
group by employee_id
order by employee_id