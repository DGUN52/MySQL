SELECT 
    BOUGHT.*
    , ROUND(BOUGHT.COUNT/USER_2021.COUNT,1)
FROM 
    (
        SELECT 
            YEAR(S.SALES_DATE) YEAR
            , MONTH(S.SALES_DATE) MONTH
            , COUNT(DISTINCT U.USER_ID) COUNT
        FROM 
            USER_INFO U
            , ONLINE_SALE S
        WHERE
            U.USER_ID = S.USER_ID
            AND YEAR(U.JOINED) = 2021
        GROUP BY 
            YEAR(S.SALES_DATE)
            , MONTH(S.SALES_DATE)
    ) BOUGHT
    ,(
        SELECT COUNT(*) COUNT
        FROM USER_INFO U
        WHERE
            YEAR(JOINED) = 2021
    ) USER_2021
ORDER BY 1, 2
;
