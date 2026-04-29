# Write your MySQL query statement below
Select user_id,
concat(
upper(left(name,1)),
LOWER(SUBSTRING(name,2))
)
 as name
from Users
order by user_id