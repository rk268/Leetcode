# Write your MySQL query statement below
with t as (
Select accepter_id id, count(accepter_id) num
from RequestAccepted
group by accepter_id
union all
Select requester_id, count(requester_id) num
from RequestAccepted
group by requester_id
)
select id, sum(num) num from t
group by id
order by num desc
limit 1





