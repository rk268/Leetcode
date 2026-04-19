# Write your MySQL query statement below
with a as 
(Select u.name as results, count(m.rating) grouped_rating
from Users u
join MovieRating m
on u.user_id = m.user_id
group by u.name
order by grouped_rating desc , u.name asc
limit 1
),
b as (Select mo.title as results , avg(mv.rating) grouped_rating
from Movies mo
join MovieRating mv
on mo.movie_id = mv.movie_id
where mv.created_at >= '2020-02-01'
AND mv.created_at < '2020-03-01'
group by mo.title
order by grouped_rating desc, mo.title asc
limit 1
)

select  results from a union all select results from  b