# Write your MySQL query statement below
Select id,
        case 
            when p_id  is null then 'Root'
            #when id not in (Select p_id from Tree) then 'Leaf'
            when id in (Select p_id from Tree) then 'Inner' 
            else 'Leaf' 
        end as type
from Tree;