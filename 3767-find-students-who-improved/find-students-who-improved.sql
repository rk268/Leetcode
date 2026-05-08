# Write your MySQL query statement below
SELECT
    s1.student_id,
    s1.subject,
    s1.score AS first_score,
    s2.score AS latest_score
FROM Scores s1
JOIN Scores s2
    ON s1.student_id = s2.student_id
   AND s1.subject = s2.subject
WHERE s1.exam_date = (
        SELECT MIN(s3.exam_date)
        FROM Scores s3
        WHERE s3.student_id = s1.student_id
          AND s3.subject = s1.subject
)
AND s2.exam_date = (
        SELECT MAX(s4.exam_date)
        FROM Scores s4
        WHERE s4.student_id = s2.student_id
          AND s4.subject = s2.subject
)
AND s2.score > s1.score
ORDER BY s1.student_id, s1.subject;
