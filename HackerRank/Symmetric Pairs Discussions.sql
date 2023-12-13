select
    f1.x
    , f1.y
from 
    functions f1
    , functions f2
where
    (f1.x = f2.y and f1.y = f2.x)
    and f1.x < f1.y
union all
select *
from functions
where x = y
group by x, y
having count(*) > 1
order by 1
;

-- select *
-- from (
--     select
--         if(f1.x < f1.y, f1.x, null) x
--         , if(f1.x < f1.y, f1.y, null) y
--     from 
--         functions f1
--         , functions f2
--     where
--         f1.x = f2.y and f1.y = f2.x
--     ) t
-- where t.x is not null and t.y is not null    
-- union all
-- select *
-- from functions
-- where x = y
-- group by x, y
-- having count(*) > 1
-- order by 1
-- ;
