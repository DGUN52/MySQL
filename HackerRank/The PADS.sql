-- HACKERANK : The PADS (https://www.hackerrank.com/challenges/the-pads/problem?isFullScreen=false)

select res
from (
    select concat(name,'(',substring(occupation,1,1),')') 'res', 1
    from occupations    
    union
    select concat('There are a total of ',count(*),' ',lower(occupation),'s.'), 2
    from occupations
    group by occupation
    order by 2, 1
    ) b
 ;

-- select concat(name,'(',substring(occupation,1,1),')')
-- from occupations
-- union
-- select concat('There are a total of ',count(*),' ',lower(occupation),'s.')
-- from occupations
-- group by occupation
-- order by 1
-- ;
