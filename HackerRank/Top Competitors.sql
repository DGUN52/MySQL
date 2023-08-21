SELECT h1.hacker_id, h1.name
FROM
    hackers h1 INNER JOIN
        (
            SELECT h2.hacker_id, count(*) cnt
            FROM hackers h2
                INNER JOIN submissions s USING(hacker_id)
                INNER JOIN challenges c USING(challenge_id)
                INNER JOIN difficulty d USING(difficulty_level)
            WHERE s.score = d.score
            GROUP BY h2.hacker_id
            HAVING cnt>1
        ) t
        USING(hacker_id)
ORDER BY t.cnt DESC, h1.hacker_id ASC
;
