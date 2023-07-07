WITH tmp AS
    (
    SELECT
        CASE WHEN Occupation = 'Actor' then Name END as a
        ,CASE WHEN Occupation = 'Doctor' then Name END as d
        ,CASE WHEN Occupation = 'Singer' then Name END as s
        ,CASE WHEN Occupation = 'Professor' then Name END as p
        ,row_number() over(partition by Occupation order by name) rn
    FROM occupations
    )
SELECT
    MAX(d), Max(p), Max(s), Max(a)
FROM
    tmp
GROUP BY
    rn
;
