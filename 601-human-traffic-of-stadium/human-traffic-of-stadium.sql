WITH t AS (
    SELECT *,
           LEAD(id,1) OVER (ORDER BY id) AS id1,
           LEAD(id,2) OVER (ORDER BY id) AS id2,
           LAG(id,1)  OVER (ORDER BY id) AS pid1,
           LAG(id,2)  OVER (ORDER BY id) AS pid2
    FROM Stadium
    WHERE people >= 100
)
SELECT id, visit_date, people
FROM t
WHERE (id1 = id + 1 AND id2 = id + 2)
   OR (pid1 = id - 1 AND id1 = id + 1)
   OR (pid2 = id - 2 AND pid1 = id - 1)
ORDER BY visit_date;