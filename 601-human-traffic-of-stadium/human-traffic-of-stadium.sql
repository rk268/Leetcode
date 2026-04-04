WITH d AS (
    SELECT id, visit_date, people
    FROM Stadium
    WHERE people >= 100
),
t AS (
    SELECT id,
           visit_date,
           people,
           LEAD(id, 1) OVER (ORDER BY id) AS id1,
           LEAD(id, 2) OVER (ORDER BY id) AS id2
    FROM d
),
valid_ids AS (
    SELECT id
    FROM t
    WHERE id1 = id + 1
      AND id2 = id + 2

    UNION

    SELECT id1
    FROM t
    WHERE id1 = id + 1
      AND id2 = id + 2

    UNION

    SELECT id2
    FROM t
    WHERE id1 = id + 1
      AND id2 = id + 2
)

SELECT s.id, s.visit_date, s.people
FROM d s
JOIN valid_ids v
  ON s.id = v.id
ORDER BY s.visit_date;