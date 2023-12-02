with join_table as (
    select 
        s.id
        , f.friend_id
        , s.name
        , p.salary
    from
        students s
        , friends f
        , packages p
    where
        s.id = f.id
        and s.id = p.id
)   
select
    jt1.name
from 
    join_table jt1
    , join_table jt2
where 
    jt2.id = jt1.friend_id
    and jt2.salary > jt1.salary
order by
    jt2.salary
;