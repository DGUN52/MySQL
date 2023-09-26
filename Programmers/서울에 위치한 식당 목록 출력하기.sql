-- 코드를 입력하세요
SELECT 
    a.rest_id
    , rest_name
    , food_type
    , favorites
    , address
    , round(b.score,2) avg
from 
    rest_info a
    , (
        select rest_id, avg(review_score) score 
        from rest_review 
        group by rest_id
    ) b
where 
    a.rest_id = b.rest_id
    and address like "서울%"
order by 
    avg desc
    , favorites desc
;
