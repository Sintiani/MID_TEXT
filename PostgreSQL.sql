WITH ranked_data AS (
  SELECT
    id,
    num,
    LAG(num) OVER (ORDER BY id) AS prev_num,
    LEAD(num) OVER (ORDER BY id) AS next_num
  FROM
    input_key
)

SELECT
  id,
  num
FROM
  ranked_data
WHERE
  num = prev_num
  AND num = next_num;
  WITH consecutive_counts AS (
    SELECT
        num,
        id,
        ROW_NUMBER() OVER (ORDER BY id) - ROW_NUMBER() OVER (PARTITION BY num ORDER BY id) AS grp
    FROM
        input_table
) select num from consecutive_counts
GROUP by num, grp
HAVING
    COUNT(*) >= 3;