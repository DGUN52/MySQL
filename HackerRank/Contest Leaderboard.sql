# https://velog.io/@deaf52/HackerRank-SQL%EB%AC%B8%EC%A0%9C%ED%92%80%EC%9D%B4-lv.4-Challenges
select
    hacker_id
    , name
    , sum(max_score) total_score
from
    hackers h
join (
    select
        s.hacker_id
        , s.challenge_id
        , max(s.score) max_score
    from
        submissions s
    group by
        s.hacker_id
        , s.challenge_id
    having
        max(s.score) > 0
    ) t on h.hacker_id = t.hacker_id
group by
    hacker_id
    , name
order by
    3 desc,
    1 asc;

/*    
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
*/
