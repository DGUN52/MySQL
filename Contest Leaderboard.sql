select 
    hacker_id
    , name
    , sum(max_score) total_score
from (
    select 
        h.hacker_id
        , h.name
        , s.challenge_id
        , max(s.score) max_score
    from 
        hackers h
        , submissions s
    where 
        h.hacker_id = s.hacker_id
    group by 
        h.hacker_id
        , h.name
        , s.challenge_id
    having max(s.score) > 0
    ) t
group by 
    hacker_id
    , name
order by 
    3 desc
    , 1 asc
;
