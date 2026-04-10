# Write your MySQL query statement below
with a as(
Select id, student,
case when id % 2 = 1 then LEAD(id,1) over(order by id)
     when id % 2 = 0 then LAG(id,1) over(order by id)
end as pid
from Seat
order by pid asc
)


Select 
        case when pid is null then id
        else pid
        end as id,
        student from a
        order by id
