SELECT 
    MOST.CNT CNT
    , M.MEMBER_NAME REVIEWER
FROM 
   MEMBER_PROFILE M
   ,(
    SELECT 
        MEMBER_ID, 
        COUNT(*) CNT, 
        RANK() OVER(ORDER BY COUNT(*) DESC) RNK
    FROM REST_REVIEW
    GROUP BY MEMBER_ID
    ) MOST
WHERE
    M.MEMBER_ID = MOST.MEMBER_ID
    AND RNK=1
GROUP BY 
    MEMBER_NAME
UNION ALL
SELECT
    REVIEW_COUNT
    ,CASE 
        WHEN COUNT_OF_SAME_RANK.SAME_COUNT>1 THEN CONCAT(M.MEMBER_NAME," 외 ",COUNT_OF_SAME_RANK.SAME_COUNT," 명") 
        ELSE M.MEMBER_NAME
    END REVIEWER
FROM
    MEMBER_PROFILE M
    ,(
    SELECT 
        MEMBER_ID
        , SAME_COUNT
        , REVIEW_COUNT
    FROM
        (
        SELECT 
            MEMBER_ID
            , COUNT(*) OVER(PARTITION BY REVIEW_COUNT) SAME_COUNT
            , REVIEW_COUNT
        FROM
            (
            SELECT 
                MEMBER_ID
                , COUNT(*) REVIEW_COUNT
                , RANK() OVER(ORDER BY COUNT(*) DESC) RNK
            FROM REST_REVIEW
            GROUP BY MEMBER_ID
            ) t
        WHERE RNK > 1
        ) t
        GROUP BY REVIEW_COUNT
    ) COUNT_OF_SAME_RANK
WHERE 
    M.MEMBER_ID = COUNT_OF_SAME_RANK.MEMBER_ID
ORDER BY 1 DESC, 2 ASC
;



-- SELECT 
--     MOST.CNT CNT
--     , M.MEMBER_NAME REVIEWER
-- FROM 
--    MEMBER_PROFILE M
--    ,(
--     SELECT 
--         MEMBER_ID, 
--         COUNT(*) CNT, 
--         RANK() OVER(ORDER BY COUNT(*) DESC) RNK
--     FROM REST_REVIEW
--     GROUP BY MEMBER_ID
--     ) MOST
-- WHERE
--     M.MEMBER_ID = MOST.MEMBER_ID
--     AND RNK=1
-- GROUP BY 
--     MEMBER_NAME
-- UNION ALL
-- SELECT
--     REVIEW_COUNT
--     ,CASE 
--         WHEN COUNT_OF_SAME_RANK.SAME_COUNT>1 THEN CONCAT(M.MEMBER_NAME," 외 ",COUNT_OF_SAME_RANK.SAME_COUNT," 명") 
--         ELSE M.MEMBER_NAME
--     END REVIEWER
-- FROM
--     MEMBER_PROFILE M
--     ,(
--     SELECT 
--         MAX(MEMBER_ID) MEMBER_ID
--         , SAME_COUNT
--         , REVIEW_COUNT
--     FROM
--         (
--         SELECT 
--             MEMBER_ID
--             , COUNT(*) OVER(PARTITION BY REVIEW_COUNT) SAME_COUNT
--             , REVIEW_COUNT
--         FROM
--             (
--             SELECT 
--                 MEMBER_ID
--                 , COUNT(*) REVIEW_COUNT
--                 , RANK() OVER(ORDER BY COUNT(*) DESC) RNK
--             FROM REST_REVIEW
--             GROUP BY MEMBER_ID
--             ) t
--         WHERE RNK > 1
--         ) t
--         GROUP BY REVIEW_COUNT
--     ) COUNT_OF_SAME_RANK
-- WHERE 
--     M.MEMBER_ID = COUNT_OF_SAME_RANK.MEMBER_ID
-- ORDER BY 1 DESC
-- ;



-- SELECT 
--     MOST.CNT CNT
--     , M.MEMBER_NAME REVIEWER
-- FROM 
--    MEMBER_PROFILE M
--    ,(
--     SELECT 
--         MEMBER_ID, 
--         COUNT(*) CNT, 
--         RANK() OVER(ORDER BY COUNT(*) DESC) RNK
--     FROM REST_REVIEW
--     GROUP BY MEMBER_ID
--     ) MOST
-- WHERE
--     M.MEMBER_ID = MOST.MEMBER_ID
--     AND RNK=1
-- GROUP BY 
--     MEMBER_NAME
-- UNION ALL
-- SELECT
--     REVIEW_COUNT_AND_RANK.CNT
--     ,CASE 
--         WHEN COUNT_OF_SAME_RANK.SAME_COUNT>1 THEN CONCAT(M.MEMBER_NAME," 외 ",COUNT_OF_SAME_RANK.SAME_COUNT," 명") 
--         ELSE M.MEMBER_NAME
--     END REVIEWER
-- FROM
--     MEMBER_PROFILE M
--     ,(
--     SELECT 
--         MAX(MEMBER_ID) MEMBER_ID
--         , SAME_COUNT
--     FROM
--         (
--         SELECT 
--             MEMBER_ID
--             , COUNT(*) OVER(PARTITION BY REVIEW_COUNT) SAME_COUNT
--             , REVIEW_COUNT
--         FROM
--             (
--             SELECT 
--                 MEMBER_ID
--                 , COUNT(*) REVIEW_COUNT
--                 , RANK() OVER(ORDER BY COUNT(*) DESC) RNK
--             FROM REST_REVIEW
--             GROUP BY MEMBER_ID
--             ) T
--         ) T
--         GROUP BY REVIEW_COUNT
--     ) COUNT_OF_SAME_RANK
--     , (
--         SELECT MEMBER_ID, COUNT(*) CNT, RANK() OVER(ORDER BY COUNT(*) DESC) RNK
--         FROM REST_REVIEW
--         GROUP BY MEMBER_ID
--     ) REVIEW_COUNT_AND_RANK
-- WHERE 
--     M.MEMBER_ID = COUNT_OF_SAME_RANK.MEMBER_ID
--     AND COUNT_OF_SAME_RANK.MEMBER_ID = REVIEW_COUNT_AND_RANK.MEMBER_ID
--     AND REVIEW_COUNT_AND_RANK.RNK > 1
-- ORDER BY 1 DESC
-- ;
