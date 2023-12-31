SELECT *
FROM(
    SELECT C.CAR_ID,C.CAR_TYPE, ROUND((100-D.DISCOUNT_RATE)/100*C.DAILY_FEE*30) '30일대여금액'
    FROM
        CAR_RENTAL_COMPANY_CAR C
        , CAR_RENTAL_COMPANY_DISCOUNT_PLAN D
    WHERE 
        C.CAR_TYPE = D.CAR_TYPE -- join
        AND C.CAR_TYPE IN ('세단','SUV')
        AND C.CAR_ID NOT IN (
            SELECT CAR_ID
            FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H
            WHERE 
                END_DATE BETWEEN DATE(20221101) AND DATE_SUB(20221201,INTERVAL 1 SECOND)
                OR (
                    END_DATE >= DATE(20221201) 
                        AND START_DATE <= DATE_SUB(20221201,INTERVAL 1 SECOND)
                )
        )
        AND D.DURATION_TYPE = '30일 이상'
) T
WHERE T.30일대여금액 BETWEEN 500000 AND 1999999
ORDER BY CAR_ID
;
