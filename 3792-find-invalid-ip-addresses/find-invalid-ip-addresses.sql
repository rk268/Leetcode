# Write your MySQL query statement below
WITH invalid_ips AS (
    SELECT ip
    FROM logs
    WHERE LENGTH(ip) - LENGTH(REPLACE(ip, '.', '')) <> 3
       OR ip REGEXP '(^|\\.)0[0-9]'
       OR ip REGEXP '(^|\\.)([0-9]{4,}|[3-9][0-9]{2}|2[6-9][0-9]|25[6-9])(\\.|$)'
)
SELECT ip, COUNT(*) AS invalid_count
FROM invalid_ips
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;
