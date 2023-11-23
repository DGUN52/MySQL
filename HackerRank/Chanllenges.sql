# 최적화
select 
    hacker_id
    , name
    , total_number
from 
    (
        select 
            h.hacker_id
            , h.name
            , count(*) total_number
            , rank() over(order by count(h.hacker_id) desc) rnk
        from
            hackers h
            , challenges c
        where 
            h.hacker_id = c.hacker_id
        group by 
            h.hacker_id, h.name
    ) handc
where 
    rnk = 1
union all
select 
    hacker_id
    , name
    , total_number
from
    (    
        select
            h.hacker_id
            , h.name
            , count(*) total_number
            , dense_rank() over(order by count(*) desc) rnk
            , count(count(*)) over(partition by count(*)) cnt
        from
            hackers h
            , challenges c
        where 
            h.hacker_id = c.hacker_id
        group by 
            h.hacker_id, h.name
    ) hc
where 
    cnt = 1
    and rnk > 1
order by 
    3 desc
    , 1
;
/*
select 
    h.hacker_id
    , h.name
    , handc.total_number
from 
    hackers h
    , (
        select 
            h.hacker_id
            , count(*) total_number
        from
            hackers h
            , challenges c
        where 
            h.hacker_id = c.hacker_id
        group by 
            h.hacker_id
    ) handc
    , (
        select 
            count(*) max_number
        from 
            hackers h
            , challenges c
        where 
            h.hacker_id = c.hacker_id
        group by 
            h.hacker_id
        order by 1 desc
        limit 1
    ) max_count
where
    h.hacker_id = handc.hacker_id
    and handc.total_number = max_count.max_number
union all
select 
    hcrn.hacker_id
    , h.name
    , hcrn.total_number
from
    hackers h
    , (    
        select
            count(*) over(partition by rnk) cnt
            , hacker_id
            , total_number
        from
            (
                select
                    dense_rank() over(order by count(*) desc) rnk
                    , h.hacker_id
                    , count(*) total_number
                from
                    hackers h
                    , challenges c
                where 
                    h.hacker_id = c.hacker_id
                group by 
                    h.hacker_id
            ) hc
        where rnk > 1
    ) hcrn
where 
    h.hacker_id = hcrn.hacker_id
    and cnt = 1
order by 
    3 desc
    , 1
;
*/
