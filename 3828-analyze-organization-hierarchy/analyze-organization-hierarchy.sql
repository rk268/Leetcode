# Write your MySQL query statement below
WITH RECURSIVE emp_level AS (
    SELECT 
        employee_id,
        employee_name,
        manager_id,
        salary,
        1 AS level
    FROM Employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT 
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.salary,
        el.level + 1
    FROM Employees e
    JOIN emp_level el
        ON e.manager_id = el.employee_id
),

subordinates AS (
    SELECT 
        manager_id,
        employee_id,
        salary
    FROM Employees
    WHERE manager_id IS NOT NULL

    UNION ALL

    SELECT 
        s.manager_id,
        e.employee_id,
        e.salary
    FROM subordinates s
    JOIN Employees e
        ON e.manager_id = s.employee_id
)

SELECT 
    el.employee_id,
    el.employee_name,
    el.level,
    COUNT(s.employee_id) AS team_size,
    el.salary + COALESCE(SUM(s.salary), 0) AS budget
FROM emp_level el
LEFT JOIN subordinates s
    ON el.employee_id = s.manager_id
GROUP BY 
    el.employee_id,
    el.employee_name,
    el.level,
    el.salary
ORDER BY 
    el.level ASC,
    budget DESC,
    el.employee_name ASC;