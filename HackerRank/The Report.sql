SELECT 
    if(g.grade < 8,'NULL',s.name) 
    , g.grade
    , s.marks
FROM students s, grades g
WHERE s.marks BETWEEN g.min_mark AND g.max_mark 
ORDER BY 
    grade DESC,
    CASE
        WHEN g.grade < 8 THEN s.marks
        ELSE s.name
    END ASC
;
