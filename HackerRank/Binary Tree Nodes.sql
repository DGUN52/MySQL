WITH tmp AS 
    (SELECT
        DISTINCT
        a.N
        ,a.P
        ,if(a.N=b.P,b.N,null) as S
    FROM 
        BST as a
        ,BST as b)
SELECT 
    N
    ,if(
        MAX(P) is null
        ,'Root'
        ,if(
            MAX(S) is null
            ,'Leaf'
            ,'Inner'
        )
    ) 
FROM
    tmp
GROUP BY
    N
ORDER BY
    N
;
