# Write your MySQL query statement below
Select  u.name, sum(t.amount) as balance
from Transactions t 
join Users u
on u.account = t.account
group by t.account 
having balance > 10000