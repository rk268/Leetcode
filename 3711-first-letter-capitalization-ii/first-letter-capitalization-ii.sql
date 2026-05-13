WITH RECURSIVE cte AS (
    SELECT
        content_id,
        content_text,
        1 AS pos,
        SUBSTRING_INDEX(content_text, ' ', 1) AS word,
        SUBSTRING(content_text, LENGTH(SUBSTRING_INDEX(content_text, ' ', 1)) + 2) AS rest
    FROM user_content

    UNION ALL

    SELECT
        content_id,
        content_text,
        pos + 1,
        SUBSTRING_INDEX(rest, ' ', 1),
        SUBSTRING(rest, LENGTH(SUBSTRING_INDEX(rest, ' ', 1)) + 2)
    FROM cte
    WHERE rest <> ''
),

formatted AS (
    SELECT
        content_id,
        pos,
        CASE
            WHEN REGEXP_LIKE(word, '^[A-Za-z]+-[A-Za-z]+$') THEN
                CONCAT(
                    UPPER(LEFT(SUBSTRING_INDEX(word, '-', 1), 1)),
                    LOWER(SUBSTRING(SUBSTRING_INDEX(word, '-', 1), 2)),
                    '-',
                    UPPER(LEFT(SUBSTRING_INDEX(word, '-', -1), 1)),
                    LOWER(SUBSTRING(SUBSTRING_INDEX(word, '-', -1), 2))
                )
            ELSE
                CONCAT(
                    UPPER(LEFT(word, 1)),
                    LOWER(SUBSTRING(word, 2))
                )
        END AS new_word
    FROM cte
)

SELECT
    u.content_id,
    u.content_text AS original_text,
    GROUP_CONCAT(f.new_word ORDER BY f.pos SEPARATOR ' ') AS converted_text
FROM user_content u
JOIN formatted f
    ON u.content_id = f.content_id
GROUP BY u.content_id, u.content_text
ORDER BY u.content_id;