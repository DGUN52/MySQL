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
